//
//  FileMethod.m
//  密码随机性测试
//
//  Created by Lucky_Lay on 17/3/20.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import "FileMethod.h"

@implementation FileMethod

+ (NSData *)divisionFileWithPath:(NSURL *)url
{
    DLog(@"devied File With Path: %@", url);
    
    system("rm /Users/LBLD/Desktop/00.pi");
    
    //获取要处理的文件数据
    
    NSData *fileData = [NSData dataWithContentsOfURL:url];
    
    if (fileData == nil || fileData.length < PART_FILE_DATA_LENGTH /8)
    {
        DLog(@"There is something Wrong With File");
    }

    //对文件进行分割。
    NSUInteger fileDataLength = [fileData length];
    
    NSUInteger startScope = fileDataLength - PART_FILE_DATA_LENGTH/8;
    
    NSUInteger startPos = arc4random() % startScope ;
    
    NSData *partData = [fileData subdataWithRange:NSMakeRange(startPos, PART_FILE_DATA_LENGTH/8)];
    
    [partData writeToFile:@"/Users/LBLD/Desktop/00.pi" atomically:YES];
    
    FILE *fp = fopen("/Users/LBLD/Desktop/00.pi", "rb");
    readHexDigitsInBinaryFormat(fp);
    
    return partData;
}

+ (FileMethod *)sharedInstance
{
        static dispatch_once_t onceToken;
        static FileMethod * sSharedInstance;
        dispatch_once(&onceToken,^{
            sSharedInstance = [[FileMethod alloc] init];
        });
        return sSharedInstance;
}

@end

void
readHexDigitsInBinaryFormat(FILE *fp)
{
    int		i, done, num_0s, num_1s, bitsRead;
    BYTE	buffer[4];
    
    if ( (epsilon = (BitSequence *) calloc(PART_FILE_DATA_LENGTH,sizeof(BitSequence))) == NULL ) {
        printf("BITSTREAM DEFINITION:  Insufficient memory available.\n");
        return;
    }
    
    printf("     Statistical Testing In Progress.........\n\n");
    for ( i=0; i<1; i++ ) {
        num_0s = 0;
        num_1s = 0;
        bitsRead = 0;
        done = 0;
        do {
            if ( fread(buffer, sizeof(unsigned char), 4, fp) != 4 ) {
                printf("READ ERROR:  Insufficient data in file.\n");
                free(epsilon);
                return;
            }
            done = convertToBits(buffer, 32, PART_FILE_DATA_LENGTH, &num_0s, &num_1s, &bitsRead);
        } while ( !done );
        //fprintf(freqfp, "\t\tBITSREAD = %d 0s = %d 1s = %d\n", bitsRead, num_0s, num_1s);
        
        //nist_test_suite();
        
    }
    //free(epsilon);
}

int
convertToBits(BYTE *x, int xBitLength, int bitsNeeded, int *num_0s, int *num_1s, int *bitsRead)
{
    int		i, j, count, bit;
    BYTE	mask;
    int		zeros, ones;
    
    count = 0;
    zeros = ones = 0;
    for ( i=0; i<(xBitLength+7)/8; i++ ) {
        mask = 0x80;
        for ( j=0; j<8; j++ ) {
            if ( *(x+i) & mask ) {
                bit = 1;
                (*num_1s)++;
                ones++;
            }
            else {
                bit = 0;
                (*num_0s)++;
                zeros++;
            }
            mask >>= 1;
            epsilon[*bitsRead] = bit;
            (*bitsRead)++;
            if ( *bitsRead == bitsNeeded )
                return 1;
            if ( ++count == xBitLength )
                return 0;
        }
    }
    
    return 0;
}


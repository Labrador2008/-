//
//  CalculatorMethod.m
//  密码随机性测试
//
//  Created by LuckyMan on 17/3/22.
//  Copyright © 2017年 Lay. All rights reserved.
//

#import "CalculatorMethod.h"

unsigned char *epsilon;

@implementation CalculatorMethod

- (NSMutableDictionary *)allResDic
{
    if (!_allResDic)
    {
        _allResDic = [[NSMutableDictionary alloc] init];
    }
    return _allResDic;
}


//Frequency
- (NSString *)_FrequencyWithDataLength:(int)n
{
    int		i;
    double	f, s_obs, p_value, sum, sqrt2 = 1.41421356237309504880;
    
    sum = 0.0;
    for ( i=0; i<n; i++ )
    sum += 2*(int)epsilon[i]-1;
    s_obs = fabs(sum)/sqrt(n);
    f = s_obs/sqrt2;
    p_value = erfc(f);
    
    /*
     fprintf(stats[TEST_FREQUENCY], "\t\t\t      FREQUENCY TEST\n");
     fprintf(stats[TEST_FREQUENCY], "\t\t---------------------------------------------\n");
     fprintf(stats[TEST_FREQUENCY], "\t\tCOMPUTATIONAL INFORMATION:\n");
     fprintf(stats[TEST_FREQUENCY], "\t\t---------------------------------------------\n");
     fprintf(stats[TEST_FREQUENCY], "\t\t(a) The nth partial sum = %d\n", (int)sum);
     fprintf(stats[TEST_FREQUENCY], "\t\t(b) S_n/n               = %f\n", sum/n);
     fprintf(stats[TEST_FREQUENCY], "\t\t---------------------------------------------\n");
     
     fprintf(stats[TEST_FREQUENCY], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value); fflush(stats[TEST_FREQUENCY]);
     fprintf(results[TEST_FREQUENCY], "%f\n", p_value); fflush(results[TEST_FREQUENCY]);
     */
    
    NSString *resStr = [NSString stringWithFormat:@"%f",p_value];
    
    return resStr;
}

//blockFrequecy
- (NSString *)_blockFrequencyWithDataLength:(int)n andBlockSize:(int)M
{
    int		i, j, N, blockSum;
    double	p_value, sum, pi, v, chi_squared;
    
    N = n/M; 		/* # OF SUBSTRING BLOCKS      */
    sum = 0.0;
    
    for ( i=0; i<N; i++ ) {
        blockSum = 0;
        for ( j=0; j<M; j++ )
        blockSum += epsilon[j+i*M];
        pi = (double)blockSum/(double)M;
        v = pi - 0.5;
        sum += v*v;
    }
    chi_squared = 4.0 * M * sum;
    p_value = cephes_igamc(N/2.0, chi_squared/2.0);
    
    /*
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t\tBLOCK FREQUENCY TEST\n");
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t---------------------------------------------\n");
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\tCOMPUTATIONAL INFORMATION:\n");
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t---------------------------------------------\n");
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t(a) Chi^2           = %f\n", chi_squared);
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t(b) # of substrings = %d\n", N);
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t(c) block length    = %d\n", M);
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t(d) Note: %d bits were discarded.\n", n % M);
    fprintf(stats[TEST_BLOCK_FREQUENCY], "\t\t---------------------------------------------\n");
    
    fprintf(stats[TEST_BLOCK_FREQUENCY], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value); fflush(stats[TEST_BLOCK_FREQUENCY]);
    fprintf(results[TEST_BLOCK_FREQUENCY], "%f\n", p_value); fflush(results[TEST_BLOCK_FREQUENCY]);
     */
    
    NSString *resStr = [NSString stringWithFormat:@"%f",p_value];
    
    return resStr;
}
    
    
//CUMULATIVESUM_TEST
-(NSArray *)_cusumWithDataLength:(int)n
{
    int		S, sup, inf, z = 0, zrev = 0, k;
    double	sum1, sum2, p_value;
    
    double p_value_f, p_value_b;
    
    S = 0;
    sup = 0;
    inf = 0;
    
    for ( k=0; k<n; k++ ) {
        epsilon[k] ? S++ : S--;
        if ( S > sup )
        sup++;
        if ( S < inf )
        inf--;
        z = (sup > -inf) ? sup : -inf;
        zrev = (sup-S > S-inf) ? sup-S : S-inf;
    }
    
    // forward
    sum1 = 0.0;
    for ( k=(-n/z+1)/4; k<=(n/z-1)/4; k++ ) {
        sum1 += cephes_normal(((4*k+1)*z)/sqrt(n));
        sum1 -= cephes_normal(((4*k-1)*z)/sqrt(n));
    }
    sum2 = 0.0;
    for ( k=(-n/z-3)/4; k<=(n/z-1)/4; k++ ) {
        sum2 += cephes_normal(((4*k+3)*z)/sqrt(n));
        sum2 -= cephes_normal(((4*k+1)*z)/sqrt(n));
    }
    
    p_value = 1.0 - sum1 + sum2;
    
    p_value_f = p_value;
    
//    fprintf(stats[TEST_CUSUM], "\t\t      CUMULATIVE SUMS (FORWARD) TEST\n");
//    fprintf(stats[TEST_CUSUM], "\t\t-------------------------------------------\n");
//    fprintf(stats[TEST_CUSUM], "\t\tCOMPUTATIONAL INFORMATION:\n");
//    fprintf(stats[TEST_CUSUM], "\t\t-------------------------------------------\n");
//    fprintf(stats[TEST_CUSUM], "\t\t(a) The maximum partial sum = %d\n", z);
//    fprintf(stats[TEST_CUSUM], "\t\t-------------------------------------------\n");
    
#warning 需要判断下
//    if ( isNegative(p_value) || isGreaterThanOne(p_value) )
//    fprintf(stats[TEST_CUSUM], "\t\tWARNING:  P_VALUE IS OUT OF RANGE\n");
//    
//    fprintf(stats[TEST_CUSUM], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value);
//    fprintf(results[TEST_CUSUM], "%f\n", p_value);
    
    // backwards
    sum1 = 0.0;
    for ( k=(-n/zrev+1)/4; k<=(n/zrev-1)/4; k++ ) {
        sum1 += cephes_normal(((4*k+1)*zrev)/sqrt(n));
        sum1 -= cephes_normal(((4*k-1)*zrev)/sqrt(n));
    }
    sum2 = 0.0;
    for ( k=(-n/zrev-3)/4; k<=(n/zrev-1)/4; k++ ) {
        sum2 += cephes_normal(((4*k+3)*zrev)/sqrt(n));
        sum2 -= cephes_normal(((4*k+1)*zrev)/sqrt(n));
    }
    p_value = 1.0 - sum1 + sum2;
    p_value_b = p_value;
    
//    fprintf(stats[TEST_CUSUM], "\t\t      CUMULATIVE SUMS (REVERSE) TEST\n");
//    fprintf(stats[TEST_CUSUM], "\t\t-------------------------------------------\n");
//    fprintf(stats[TEST_CUSUM], "\t\tCOMPUTATIONAL INFORMATION:\n");
//    fprintf(stats[TEST_CUSUM], "\t\t-------------------------------------------\n");
//    fprintf(stats[TEST_CUSUM], "\t\t(a) The maximum partial sum = %d\n", zrev);
//    fprintf(stats[TEST_CUSUM], "\t\t-------------------------------------------\n");
    
#warning 需要判断下
//    if ( isNegative(p_value) || isGreaterThanOne(p_value) )
//    fprintf(stats[TEST_CUSUM], "\t\tWARNING:  P_VALUE IS OUT OF RANGE\n");
//    
//    fprintf(stats[TEST_CUSUM], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value); fflush(stats[TEST_CUSUM]);
//    fprintf(results[TEST_CUSUM], "%f\n", p_value); fflush(results[TEST_CUSUM]);
    
    
    NSString *resF = [NSString stringWithFormat:@"%f",p_value_f];
    NSString *resB = [NSString stringWithFormat:@"%f",p_value_b];
    NSArray *resAry = @[resF,resB];
    
    return resAry;
}

//RUNS_TEST
- (NSString *)_runsWithDataLength:(int)n
{
    int		S, k;
    double	pi, V, erfc_arg, p_value;
    
    S = 0;
    for ( k=0; k<n; k++ )
        if ( epsilon[k] )
            S++;
    pi = (double)S / (double)n;
    
    if ( fabs(pi - 0.5) > (2.0 / sqrt(n)) ) {
        //        fprintf(stats[TEST_RUNS], "\t\t\t\tRUNS TEST\n");
        //        fprintf(stats[TEST_RUNS], "\t\t------------------------------------------\n");
        //        fprintf(stats[TEST_RUNS], "\t\tPI ESTIMATOR CRITERIA NOT MET! PI = %f\n", pi);
        p_value = 0.0;
    }
    else {
        
        V = 1;
        for ( k=1; k<n; k++ )
            if ( epsilon[k] != epsilon[k-1] )
                V++;
        
        erfc_arg = fabs(V - 2.0 * n * pi * (1-pi)) / (2.0 * pi * (1-pi) * sqrt(2*n));
        p_value = erfc(erfc_arg);
        
        //        fprintf(stats[TEST_RUNS], "\t\t\t\tRUNS TEST\n");
        //        fprintf(stats[TEST_RUNS], "\t\t------------------------------------------\n");
        //        fprintf(stats[TEST_RUNS], "\t\tCOMPUTATIONAL INFORMATION:\n");
        //        fprintf(stats[TEST_RUNS], "\t\t------------------------------------------\n");
        //        fprintf(stats[TEST_RUNS], "\t\t(a) Pi                        = %f\n", pi);
        //        fprintf(stats[TEST_RUNS], "\t\t(b) V_n_obs (Total # of runs) = %d\n", (int)V);
        //        fprintf(stats[TEST_RUNS], "\t\t(c) V_n_obs - 2 n pi (1-pi)\n");
        //        fprintf(stats[TEST_RUNS], "\t\t    -----------------------   = %f\n", erfc_arg);
        //        fprintf(stats[TEST_RUNS], "\t\t      2 sqrt(2n) pi (1-pi)\n");
        //        fprintf(stats[TEST_RUNS], "\t\t------------------------------------------\n");
        //        if ( isNegative(p_value) || isGreaterThanOne(p_value) )
        //            fprintf(stats[TEST_RUNS], "WARNING:  P_VALUE IS OUT OF RANGE.\n");
        //
        //        fprintf(stats[TEST_RUNS], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value); fflush(stats[TEST_RUNS]);
    }
    
    //fprintf(results[TEST_RUNS], "%f\n", p_value); fflush(results[TEST_RUNS]);
    NSString *resStr = [NSString stringWithFormat:@"%f",p_value];
    return resStr;
}

//LONGERSRUN_TEST
- (NSString *)_longestRunOfOnesWithDataLength:(int)n
{
    double			pval, chi2, pi[7];
    int				run, v_n_obs, N, i, j, K, M, V[7];
    unsigned int	nu[7] = { 0, 0, 0, 0, 0, 0, 0 };
    
    if ( n < 128 ) {
        //fprintf(stats[TEST_LONGEST_RUN], "\t\t\t  LONGEST RUNS OF ONES TEST\n");
        //fprintf(stats[TEST_LONGEST_RUN], "\t\t---------------------------------------------\n");
        //fprintf(stats[TEST_LONGEST_RUN], "\t\t   n=%d is too short\n", n);
        return NULL;
    }
    if ( n < 6272 ) {
        K = 3;
        M = 8;
        V[0] = 1; V[1] = 2; V[2] = 3; V[3] = 4;
        pi[0] = 0.21484375;
        pi[1] = 0.3671875;
        pi[2] = 0.23046875;
        pi[3] = 0.1875;
    }
    else if ( n < 750000 ) {
        K = 5;
        M = 128;
        V[0] = 4; V[1] = 5; V[2] = 6; V[3] = 7; V[4] = 8; V[5] = 9;
        pi[0] = 0.1174035788;
        pi[1] = 0.242955959;
        pi[2] = 0.249363483;
        pi[3] = 0.17517706;
        pi[4] = 0.102701071;
        pi[5] = 0.112398847;
    }
    else {
        K = 6;
        M = 10000;
        V[0] = 10; V[1] = 11; V[2] = 12; V[3] = 13; V[4] = 14; V[5] = 15; V[6] = 16;
        pi[0] = 0.0882;
        pi[1] = 0.2092;
        pi[2] = 0.2483;
        pi[3] = 0.1933;
        pi[4] = 0.1208;
        pi[5] = 0.0675;
        pi[6] = 0.0727;
    }
    
    N = n/M;
    for ( i=0; i<N; i++ ) {
        v_n_obs = 0;
        run = 0;
        for ( j=0; j<M; j++ ) {
            if ( epsilon[i*M+j] == 1 ) {
                run++;
                if ( run > v_n_obs )
                    v_n_obs = run;
            }
            else
                run = 0;
        }
        if ( v_n_obs < V[0] )
            nu[0]++;
        for ( j=0; j<=K; j++ ) {
            if ( v_n_obs == V[j] )
                nu[j]++;
        }
        if ( v_n_obs > V[K] )
            nu[K]++;
    }
    
    chi2 = 0.0;
    for ( i=0; i<=K; i++ )
        chi2 += ((nu[i] - N * pi[i]) * (nu[i] - N * pi[i])) / (N * pi[i]);
    
    pval = cephes_igamc((double)(K/2.0), chi2 / 2.0);
    
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t\t  LONGEST RUNS OF ONES TEST\n");
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t---------------------------------------------\n");
//    fprintf(stats[TEST_LONGEST_RUN], "\t\tCOMPUTATIONAL INFORMATION:\n");
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t---------------------------------------------\n");
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t(a) N (# of substrings)  = %d\n", N);
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t(b) M (Substring Length) = %d\n", M);
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t(c) Chi^2                = %f\n", chi2);
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t---------------------------------------------\n");
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t      F R E Q U E N C Y\n");
//    fprintf(stats[TEST_LONGEST_RUN], "\t\t---------------------------------------------\n");
    
//    if ( K == 3 ) {
//        fprintf(stats[TEST_LONGEST_RUN], "\t\t  <=1     2     3    >=4   P-value  Assignment");
//        fprintf(stats[TEST_LONGEST_RUN], "\n\t\t %3d %3d %3d  %3d ", nu[0], nu[1], nu[2], nu[3]);
//    }
//    else if ( K == 5 ) {
//        fprintf(stats[TEST_LONGEST_RUN], "\t\t<=4  5  6  7  8  >=9 P-value  Assignment");
//        fprintf(stats[TEST_LONGEST_RUN], "\n\t\t %3d %3d %3d %3d %3d  %3d ", nu[0], nu[1], nu[2],
//                nu[3], nu[4], nu[5]);
//    }
//    else {
//        fprintf(stats[TEST_LONGEST_RUN],"\t\t<=10  11  12  13  14  15 >=16 P-value  Assignment");
//        fprintf(stats[TEST_LONGEST_RUN],"\n\t\t %3d %3d %3d %3d %3d %3d  %3d ", nu[0], nu[1], nu[2],
//                nu[3], nu[4], nu[5], nu[6]);
//    }
#warning 需要判断
//    if ( isNegative(pval) || isGreaterThanOne(pval) )
//        fprintf(stats[TEST_LONGEST_RUN], "WARNING:  P_VALUE IS OUT OF RANGE.\n");
    
//    fprintf(stats[TEST_LONGEST_RUN], "%s\t\tp_value = %f\n\n", pval < ALPHA ? "FAILURE" : "SUCCESS", pval); fflush(stats[TEST_LONGEST_RUN]);
//    fprintf(results[TEST_LONGEST_RUN], "%f\n", pval); fflush(results[TEST_LONGEST_RUN]);
    
    NSString *resStr = [NSString stringWithFormat:@"%f", pval];
    return resStr;
}

//SERIAL_TEST
- (NSArray *)_serialWithDataLength:(int)n and:(int)m
{
    double	p_value1, p_value2, psim0, psim1, psim2, del1, del2;
    
    psim0 = psi2(m, n);
    psim1 = psi2(m-1, n);
    psim2 = psi2(m-2, n);
    del1 = psim0 - psim1;
    del2 = psim0 - 2.0*psim1 + psim2;
    p_value1 = cephes_igamc(pow(2, m-1)/2, del1/2.0);
    p_value2 = cephes_igamc(pow(2, m-2)/2, del2/2.0);
    
//    fprintf(stats[TEST_SERIAL], "\t\t\t       SERIAL TEST\n");
//    fprintf(stats[TEST_SERIAL], "\t\t---------------------------------------------\n");
//    fprintf(stats[TEST_SERIAL], "\t\t COMPUTATIONAL INFORMATION:		  \n");
//    fprintf(stats[TEST_SERIAL], "\t\t---------------------------------------------\n");
//    fprintf(stats[TEST_SERIAL], "\t\t(a) Block length    (m) = %d\n", m);
//    fprintf(stats[TEST_SERIAL], "\t\t(b) Sequence length (n) = %d\n", n);
//    fprintf(stats[TEST_SERIAL], "\t\t(c) Psi_m               = %f\n", psim0);
//    fprintf(stats[TEST_SERIAL], "\t\t(d) Psi_m-1             = %f\n", psim1);
//    fprintf(stats[TEST_SERIAL], "\t\t(e) Psi_m-2             = %f\n", psim2);
//    fprintf(stats[TEST_SERIAL], "\t\t(f) Del_1               = %f\n", del1);
//    fprintf(stats[TEST_SERIAL], "\t\t(g) Del_2               = %f\n", del2);
//    fprintf(stats[TEST_SERIAL], "\t\t---------------------------------------------\n");
//    
//    fprintf(stats[TEST_SERIAL], "%s\t\tp_value1 = %f\n", p_value1 < ALPHA ? "FAILURE" : "SUCCESS", p_value1);
//    fprintf(results[TEST_SERIAL], "%f\n", p_value1);
//    
//    fprintf(stats[TEST_SERIAL], "%s\t\tp_value2 = %f\n\n", p_value2 < ALPHA ? "FAILURE" : "SUCCESS", p_value2); fflush(stats[TEST_SERIAL]);
//    fprintf(results[TEST_SERIAL], "%f\n", p_value2); fflush(results[TEST_SERIAL]);
    
    NSString *resStr1 = [NSString stringWithFormat:@"%f",p_value1];
    NSString *resStr2 = [NSString stringWithFormat:@"%f",p_value2];
    NSArray *resAry = @[resStr1, resStr2];
    return resAry;
}
    
//ApproximateEntroy
- (NSString *)_ApproximateEntropyWithBlockLength:(int)n and:(int)m
{
    int				i, j, k, r, blockSize, seqLength, powLen, index;
    double			sum, numOfBlocks, ApEn[2], apen, chi_squared, p_value;
    unsigned int	*P;
    
    seqLength = n;
    r = 0;
    
    for ( blockSize=m; blockSize<=m+1; blockSize++ ) {
        if ( blockSize == 0 ) {
            ApEn[0] = 0.00;
            r++;
        }
        else {
            numOfBlocks = (double)seqLength;
            powLen = (int)pow(2, blockSize+1)-1;
            if ( (P = (unsigned int*)calloc(powLen,sizeof(unsigned int))) == NULL ) {
                DLog(@"ApEn:  Insufficient memory available.\n");
                return NULL;
            }
            for ( i=1; i<powLen-1; i++ )
            P[i] = 0;
            for ( i=0; i<numOfBlocks; i++ ) { /* COMPUTE FREQUENCY */
                k = 1;
                for ( j=0; j<blockSize; j++ ) {
                    k <<= 1;
                    if ( (int)epsilon[(i+j) % seqLength] == 1 )
                    k++;
                }
                P[k-1]++;
            }
            /* DISPLAY FREQUENCY */
            sum = 0.0;
            index = (int)pow(2, blockSize)-1;
            for ( i=0; i<(int)pow(2, blockSize); i++ ) {
                if ( P[index] > 0 )
                sum += P[index]*log(P[index]/numOfBlocks);
                index++;
            }
            sum /= numOfBlocks;
            ApEn[r] = sum;
            r++;
            free(P);
        }
    }
    apen = ApEn[0] - ApEn[1];
    
    chi_squared = 2.0*seqLength*(log(2) - apen);
    p_value = cephes_igamc(pow(2, m-1), chi_squared/2.0);
    
//    fprintf(stats[TEST_APEN], "\t\t(b) n (sequence length) = %d\n", seqLength);
//    fprintf(stats[TEST_APEN], "\t\t(c) Chi^2               = %f\n", chi_squared);
//    fprintf(stats[TEST_APEN], "\t\t(d) Phi(m)	       = %f\n", ApEn[0]);
//    fprintf(stats[TEST_APEN], "\t\t(e) Phi(m+1)	       = %f\n", ApEn[1]);
//    fprintf(stats[TEST_APEN], "\t\t(f) ApEn                = %f\n", apen);
//    fprintf(stats[TEST_APEN], "\t\t(g) Log(2)              = %f\n", log(2.0));
//    fprintf(stats[TEST_APEN], "\t\t--------------------------------------------\n");
    
    if ( m > (int)(log(seqLength)/log(2)-5) ) {
        DLog(@"there is something wrong in approximateEntropy");
    }
    
//    fprintf(stats[TEST_APEN], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value); fflush(stats[TEST_APEN]);
//    fprintf(results[TEST_APEN], "%f\n", p_value); fflush(results[TEST_APEN]);
    
    NSString *resStr = [NSString stringWithFormat:@"%f",p_value];
    return resStr;
}

//
- (NSString *)_universalWithDataLength:(int)n
{
    int		i, j, p, L, Q, K;
    double	arg, sqrt2, sigma, phi, sum, p_value, c;
    long	*T, decRep;
    double	expected_value[17] = { 0, 0, 0, 0, 0, 0, 5.2177052, 6.1962507, 7.1836656,
        8.1764248, 9.1723243, 10.170032, 11.168765,
        12.168070, 13.167693, 14.167488, 15.167379 };
    double   variance[17] = { 0, 0, 0, 0, 0, 0, 2.954, 3.125, 3.238, 3.311, 3.356, 3.384,
        3.401, 3.410, 3.416, 3.419, 3.421 };
    
    /* * * * * * * * * ** * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * THE FOLLOWING REDEFINES L, SHOULD THE CONDITION:     n >= 1010*2^L*L       *
     * NOT BE MET, FOR THE BLOCK LENGTH L.                                        *
     * * * * * * * * * * ** * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    L = 5;
    if ( n >= 387840 )     L = 6;
    if ( n >= 904960 )     L = 7;
    if ( n >= 2068480 )    L = 8;
    if ( n >= 4654080 )    L = 9;
    if ( n >= 10342400 )   L = 10;
    if ( n >= 22753280 )   L = 11;
    if ( n >= 49643520 )   L = 12;
    if ( n >= 107560960 )  L = 13;
    if ( n >= 231669760 )  L = 14;
    if ( n >= 496435200 )  L = 15;
    if ( n >= 1059061760 ) L = 16;
    
    Q = 10*(int)pow(2, L);
    K = (int) (floor(n/L) - (double)Q);	 		    /* BLOCKS TO TEST */
    
    p = (int)pow(2, L);
    if ( (L < 6) || (L > 16) || ((double)Q < 10*pow(2, L)) ||
        ((T = (long *)calloc(p, sizeof(long))) == NULL) ) {
        //fprintf(stats[TEST_UNIVERSAL], "\t\tUNIVERSAL STATISTICAL TEST\n");
        //fprintf(stats[TEST_UNIVERSAL], "\t\t---------------------------------------------\n");
        //fprintf(stats[TEST_UNIVERSAL], "\t\tERROR:  L IS OUT OF RANGE.\n");
        //fprintf(stats[TEST_UNIVERSAL], "\t\t-OR- :  Q IS LESS THAN %f.\n", 10*pow(2, L));
        //fprintf(stats[TEST_UNIVERSAL], "\t\t-OR- :  Unable to allocate T.\n");
        return NULL;
    }
    
    /* COMPUTE THE EXPECTED:  Formula 16, in Marsaglia's Paper */
    c = 0.7 - 0.8/(double)L + (4 + 32/(double)L)*pow(K, -3/(double)L)/15;
    sigma = c * sqrt(variance[L]/(double)K);
    sqrt2 = sqrt(2);
    sum = 0.0;
    for ( i=0; i<p; i++ )
        T[i] = 0;
    for ( i=1; i<=Q; i++ ) {		/* INITIALIZE TABLE */
        decRep = 0;
        for ( j=0; j<L; j++ )
            decRep += epsilon[(i-1)*L+j] * (long)pow(2, L-1-j);
        T[decRep] = i;
    }
    for ( i=Q+1; i<=Q+K; i++ ) { 	/* PROCESS BLOCKS */
        decRep = 0;
        for ( j=0; j<L; j++ )
            decRep += epsilon[(i-1)*L+j] * (long)pow(2, L-1-j);
        sum += log(i - T[decRep])/log(2);
        T[decRep] = i;
    }
    phi = (double)(sum/(double)K);
    
//    fprintf(stats[TEST_UNIVERSAL], "\t\tUNIVERSAL STATISTICAL TEST\n");
//    fprintf(stats[TEST_UNIVERSAL], "\t\t--------------------------------------------\n");
//    fprintf(stats[TEST_UNIVERSAL], "\t\tCOMPUTATIONAL INFORMATION:\n");
//    fprintf(stats[TEST_UNIVERSAL], "\t\t--------------------------------------------\n");
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(a) L         = %d\n", L);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(b) Q         = %d\n", Q);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(c) K         = %d\n", K);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(d) sum       = %f\n", sum);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(e) sigma     = %f\n", sigma);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(f) variance  = %f\n", variance[L]);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(g) exp_value = %f\n", expected_value[L]);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(h) phi       = %f\n", phi);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t(i) WARNING:  %d bits were discarded.\n", n-(Q+K)*L);
//    fprintf(stats[TEST_UNIVERSAL], "\t\t-----------------------------------------\n");
    
    arg = fabs(phi-expected_value[L])/(sqrt2 * sigma);
    p_value = erfc(arg);
#warning 需要判断
//    if ( isNegative(p_value) || isGreaterThanOne(p_value) )
//        fprintf(stats[TEST_UNIVERSAL], "\t\tWARNING:  P_VALUE IS OUT OF RANGE\n");
//    
//    fprintf(stats[TEST_UNIVERSAL], "%s\t\tp_value = %f\n\n", p_value < ALPHA ? "FAILURE" : "SUCCESS", p_value); fflush(stats[TEST_UNIVERSAL]);
//    fprintf(results[TEST_UNIVERSAL], "%f\n", p_value); fflush(results[TEST_UNIVERSAL]);
    
    NSString *resStr = [NSString stringWithFormat:@"%f", p_value];
    
    free(T);
    
    return resStr;
}

//OVERLAPPINGTEMPLATEMATCHING_TEST
- (NSString *)_overlappingTemplateMatchingWithDataLength:(int)n and:(int)m
{
    int				i, k, match;
    double			W_obs, eta, sum, chi2, p_value, lambda;
    int				M, N, j, K = 5;
    unsigned int	nu[6] = { 0, 0, 0, 0, 0, 0 };
    //double			pi[6] = { 0.143783, 0.139430, 0.137319, 0.124314, 0.106209, 0.348945 };
    double			pi[6] = { 0.364091, 0.185659, 0.139381, 0.100571, 0.0704323, 0.139865 };
    BitSequence		*sequence;
    
    M = 1032;
    N = n/M;
    
    if ( (sequence = (BitSequence *) calloc(m, sizeof(BitSequence))) == NULL ) {
        //fprintf(stats[TEST_OVERLAPPING], "\t\t    OVERLAPPING TEMPLATE OF ALL ONES TEST\n");
        //fprintf(stats[TEST_OVERLAPPING], "\t\t---------------------------------------------\n");
        //fprintf(stats[TEST_OVERLAPPING], "\t\tTEMPLATE DEFINITION:  Insufficient memory, Overlapping Template Matchings test aborted!\n");
    }
    else
        for ( i=0; i<m; i++ )
            sequence[i] = 1;
    
    lambda = (double)(M-m+1)/pow(2,m);
    eta = lambda/2.0;
    sum = 0.0;
    for ( i=0; i<K; i++ ) {			/* Compute Probabilities */
        pi[i] = Pr(i, eta);
        sum += pi[i];
    }
    pi[K] = 1 - sum;
    
    for ( i=0; i<N; i++ ) {
        W_obs = 0;
        for ( j=0; j<M-m+1; j++ ) {
            match = 1;
            for ( k=0; k<m; k++ ) {
                if ( sequence[k] != epsilon[i*M+j+k] )
                    match = 0;
            }
            if ( match == 1 )
                W_obs++;
        }
        if ( W_obs <= 4 )
            nu[(int)W_obs]++;
        else
            nu[K]++;
    }
    sum = 0;
    chi2 = 0.0;                                   /* Compute Chi Square */
    for ( i=0; i<K+1; i++ ) {
        chi2 += pow((double)nu[i] - (double)N*pi[i], 2)/((double)N*pi[i]);
        sum += nu[i];
    }
    p_value = cephes_igamc(K/2.0, chi2/2.0);
    
//    fprintf(stats[TEST_OVERLAPPING], "\t\t    OVERLAPPING TEMPLATE OF ALL ONES TEST\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t-----------------------------------------------\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\tCOMPUTATIONAL INFORMATION:\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t-----------------------------------------------\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t(a) n (sequence_length)      = %d\n", n);
//    fprintf(stats[TEST_OVERLAPPING], "\t\t(b) m (block length of 1s)   = %d\n", m);
//    fprintf(stats[TEST_OVERLAPPING], "\t\t(c) M (length of substring)  = %d\n", M);
//    fprintf(stats[TEST_OVERLAPPING], "\t\t(d) N (number of substrings) = %d\n", N);
//    fprintf(stats[TEST_OVERLAPPING], "\t\t(e) lambda [(M-m+1)/2^m]     = %f\n", lambda);
//    fprintf(stats[TEST_OVERLAPPING], "\t\t(f) eta                      = %f\n", eta);
//    fprintf(stats[TEST_OVERLAPPING], "\t\t-----------------------------------------------\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t   F R E Q U E N C Y\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t  0   1   2   3   4 >=5   Chi^2   P-value  Assignment\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t-----------------------------------------------\n");
//    fprintf(stats[TEST_OVERLAPPING], "\t\t%3d %3d %3d %3d %3d %3d  %f ",
//            nu[0], nu[1], nu[2], nu[3], nu[4], nu[5], chi2);
    
#warning 需要判断
//    if ( isNegative(p_value) || isGreaterThanOne(p_value) )
//        fprintf(stats[TEST_OVERLAPPING], "WARNING:  P_VALUE IS OUT OF RANGE.\n");
    
    free(sequence);
//    fprintf(stats[TEST_OVERLAPPING], "%f %s\n\n", p_value, p_value < ALPHA ? "FAILURE" : "SUCCESS"); fflush(stats[TEST_OVERLAPPING]);
//    fprintf(results[TEST_OVERLAPPING], "%f\n", p_value); fflush(results[TEST_OVERLAPPING]);
    
    NSString *resStr = [NSString stringWithFormat:@"%f",p_value];
    return resStr;
}



    
- (BOOL)startCalculatorWithData:(NSData *)data andItemNum:(NSNumber *)num
{
    BOOL isFinish = FALSE;
    
    
    NSInteger testItemNum = [num integerValue];
    
    
    if (testItemNum == FREQUENCY_TEST)
    {
        DLog(@"FREQUENCY_TEST");
        NSString *freRes = [self _FrequencyWithDataLength:PART_FILE_DATA_LENGTH];
        if (freRes == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:freRes forKey:@"FREQUENCY_TEST"];
        DLog(@"res: %@",self.allResDic);
 
    }
    else if (testItemNum == BLOCKFREQUENCY_TEST)
    {
        
        DLog(@"BLOCKFREQUENCY_TEST");
        NSString *bloRes = [self _blockFrequencyWithDataLength:PART_FILE_DATA_LENGTH andBlockSize:BLOCKFREQUENCYBLOCKLENGTH];
        if (bloRes == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:bloRes forKey:@"BLOCKFREQUENCY_TEST"];
        DLog(@"res: %@",self.allResDic);
    }
    else if(testItemNum == CUMULATIVESUM_TEST)
    {
        
        DLog(@"CUMULATIVESUM_TEST");
        NSArray *cusumAry = [self _cusumWithDataLength:PART_FILE_DATA_LENGTH];
        if (cusumAry == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:cusumAry forKey:@"CUMULATIVESUM_TEST"];
        DLog(@"res: %@",self.allResDic);
        
    }
    else if(testItemNum == RunsTest)
    {
        DLog(@"RUNS_TEST");
        NSString *runsStr = [self _runsWithDataLength:PART_FILE_DATA_LENGTH];
        if (runsStr == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:runsStr forKey:@"RUNS_TEST"];
        DLog(@"res: %@",self.allResDic);
    }
    
    else if(testItemNum == LONGERSRUN_TEST)
    {
        DLog(@"LONGERSRUN_TEST");
        NSString *longestRunRes = [self _longestRunOfOnesWithDataLength:PART_FILE_DATA_LENGTH];
        if (longestRunRes == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:longestRunRes forKey:@"LONGERSRUN_TEST"];
        DLog(@"res: %@",self.allResDic);
    }
    else if (testItemNum == SERIAL_TEST)
    {
       
        DLog(@"SERIAL_TEST");
        NSArray *serialAry = [self _serialWithDataLength:PART_FILE_DATA_LENGTH and:SERIALBLOCKLENGTH];
        if (serialAry == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:serialAry forKey:@"SERIAL_TEST"];
        DLog(@"%@",self.allResDic);
    }
    else if (testItemNum == APPROXIMATEENTROPY_TEST)
    {
        DLog(@"APPROXIMATEENTROPY_TEST");
        NSString *appStr = [self _ApproximateEntropyWithBlockLength:PART_FILE_DATA_LENGTH and:APPROXIMATEENTROPYBLOCKLENGTH];
        if (appStr == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:appStr forKey:@"APPROXIMATEENTROPY_TEST"];
        DLog(@"res: %@",self.allResDic);
    }
    else if(testItemNum == UNIVERSALSTATICAL_TEST)
    {
        DLog(@"UNIVERSALSTATICAL_TEST");
        NSString *universalStr = [self _universalWithDataLength:PART_FILE_DATA_LENGTH];
        if (universalStr == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:universalStr forKey:@"UNIVERSALSTATICAL_TEST"];
        DLog(@"res : %@",self.allResDic);
    }
    else if (testItemNum == OVERLAPPINGTEMPLATEMATCHING_TEST)
    {
   
        DLog(@"OVERLAPPINGTEMPLATEMATCHING_TEST");
        NSString *overStr = [self _overlappingTemplateMatchingWithDataLength:PART_FILE_DATA_LENGTH and:OVERLAPPINGTEMPLATEBLOCKLENGTH];
        if (overStr == NULL)
        {
            return FALSE;
        }
        [self.allResDic setObject:overStr forKey:@"OVERLAPPINGTEMPLATEMATCHING_TEST"];
        DLog(@"res : %@", self.allResDic);
    }
    else if(testItemNum == NONOVERLAPPINGTEMPLATEMATCHING_TEST)
    {
        DLog(@"NONOVERLAPPINGTEMPLATEMATCHING_TEST");
    }
    else if(testItemNum == RANKS_TEST)
    {
        DLog(@"RANKS_TEST");
    }
    else if (testItemNum == LINEARCOMPLEXITY_TEST)
    {
        DLog(@"LINEARCOMPLEXITY_TEST");
    }
    else if (testItemNum == RANDOMEXCURSIONS_TEST)
    {
        DLog(@"RANDOMEXCURSIONS_TEST");
    }
    else if (testItemNum == DFT_TEST)
    {
        DLog(@"DFT_TEST");
    }
    else if (testItemNum == RANDOMEXCURSIONVARIANT_TEST)
    {
          DLog(@"RANDOMEXCURSIONVARIANT_TEST");
    }
    else
    {
        
    }
 
    
    
    return isFinish;
}


//serial 测试辅助函数
double
psi2(int m, int n)
{
    int				i, j, k, powLen;
    double			sum, numOfBlocks;
    unsigned int	*P;
    
    if ( (m == 0) || (m == -1) )
        return 0.0;
    numOfBlocks = n;
    powLen = (int)pow(2, m+1)-1;
    if ( (P = (unsigned int*)calloc(powLen,sizeof(unsigned int)))== NULL ) {
        //fprintf(stats[TEST_SERIAL], "Serial Test:  Insufficient memory available.\n");
        //fflush(stats[TEST_SERIAL]);
        return 0.0;
    }
    for ( i=1; i<powLen-1; i++ )
        P[i] = 0;	  /* INITIALIZE NODES */
    for ( i=0; i<numOfBlocks; i++ ) {		 /* COMPUTE FREQUENCY */
        k = 1;
        for ( j=0; j<m; j++ ) {
            if ( epsilon[(i+j)%n] == 0 )
                k *= 2;
            else if ( epsilon[(i+j)%n] == 1 )
                k = 2*k+1;
        }
        P[k-1]++;
    }
    sum = 0.0;
    for ( i=(int)pow(2, m)-1; i<(int)pow(2, m+1)-1; i++ )
        sum += pow(P[i], 2);
    sum = (sum * pow(2, m)/(double)n) - (double)n;
    free(P);
    
    return sum;
}

//overlappingTemplateMatching 测试辅助函数
double
Pr(int u, double eta)
{
    int		l;
    double	sum, p;
    
    if ( u == 0 )
        p = exp(-eta);
    else {
        sum = 0.0;
        for ( l=1; l<=u; l++ )
            sum += exp(-eta-u*log(2)+l*log(eta)-cephes_lgam(l+1)+cephes_lgam(u)-cephes_lgam(l)-cephes_lgam(u-l+1));
        p = sum;
    }
    return p;
}


@end

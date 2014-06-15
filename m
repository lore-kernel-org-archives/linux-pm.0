From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 2/4] intel_pstate: Correct rounding in busy calculation
Date: Sun, 15 Jun 2014 07:44:47 -0700
Message-ID: <000601cf88a8$5bac8570$13059050$@net>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com> <1401381145-17745-3-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1401381145-17745-3-git-send-email-dirk.j.brandewie@intel.com>
Content-Language: en-ca
Sender: stable-owner@vger.kernel.org
To: dirk.brandewie@gmail.com, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, 'Dirk Brandewie' <dirk.j.brandewie@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2014.05.29 09:32 Dirk Brandewie wrote:

There is a mistake in this patch.
Even though the patch is from Dirk, the mistake is my fault, sorry.

Severity: Not very serious, but can increase target pstate by one extra value.
For real world work flows the issue should self correct (but I have no proof).
It is the equivalent of different PID gains for positive and negative numbers.

Why this e-mail? Why not just submit a patch?
Because I do not yet know how, particularly for v3.16

This part of the patch:

 	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
 -
 +	if (result >= 0)
 +		result = result + (1 << (FRAC_BITS-1));
 +	else
 +		result = result - (1 << (FRAC_BITS-1));
 	return (signed int)fp_toint(result);

Should actually be this:

        result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
+       result = result + (1 << (FRAC_BITS-1));
        return (signed int)fp_toint(result);

Proof method 1: Use "perf record" and verify all the math by hand.
Realize that some numbers are not what is expected, and work backwards.

Proof method 2: make a table of all the numbers. I.E.

/****************************************************************************/
/*
/* round_truth_table.c  2014.06.15  Smythies
/*       It seems I introduced a mistake into intel_pstate.c.
/*       Since my brain hurts from all the thinking it through, verify
/*       by mindlessly generating all possibilities.
/*
/****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

main(){

   long int count, mistake_way;

   for(count = 1026; count >= -1026; count--){ /* from 4.008 to -4.008 in steps of 1 / 256ths */
      if(count >= 0){
         mistake_way = (count + (1 << 7)) >> 8;
      } else {
         mistake_way = (count - (1 << 7)) >> 8;
      } /* endif */
      printf("%ld %ld %ld %ld %lf\n", count, count >> 8, mistake_way, (count + (1 << 7)) >> 8, (double)count / 256.0);
   } /* endfor */
} /* endprogram */

Which gives (edited):

1025 4 4 4 4.003906
1024 4 4 4 4.000000
1023 3 4 4 3.996094

897 3 4 4 3.503906
896 3 4 4 3.500000
895 3 3 3 3.496094

769 3 3 3 3.003906
768 3 3 3 3.000000
767 2 3 3 2.996094

641 2 3 3 2.503906
640 2 3 3 2.500000
639 2 2 2 2.496094

513 2 2 2 2.003906
512 2 2 2 2.000000
511 1 2 2 1.996094

385 1 2 2 1.503906
384 1 2 2 1.500000
383 1 1 1 1.496094

257 1 1 1 1.003906
256 1 1 1 1.000000
255 0 1 1 0.996094

129 0 1 1 0.503906
128 0 1 1 0.500000
127 0 0 0 0.496094

1 0 0 0 0.003906
0 0 0 0 0.000000
-1 -1 -1 0 -0.003906

-127 -1 -1 0 -0.496094
-128 -1 -1 0 -0.500000
-129 -1 -2 -1 -0.503906

-255 -1 -2 -1 -0.996094
-256 -1 -2 -1 -1.000000
-257 -2 -2 -1 -1.003906

-383 -2 -2 -1 -1.496094
-384 -2 -2 -1 -1.500000
-385 -2 -3 -2 -1.503906

-511 -2 -3 -2 -1.996094
-512 -2 -3 -2 -2.000000
-513 -3 -3 -2 -2.003906

-639 -3 -3 -2 -2.496094
-640 -3 -3 -2 -2.500000
-641 -3 -4 -3 -2.503906

-767 -3 -4 -3 -2.996094
-768 -3 -4 -3 -3.000000
-769 -4 -4 -3 -3.003906

-895 -4 -4 -3 -3.496094
-896 -4 -4 -3 -3.500000
-897 -4 -5 -4 -3.503906

-1024 -4 -5 -4 -4.000000
-1025 -5 -5 -4 -4.003906
-1026 -5 -5 -4 -4.007812

> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>
> Changing to fixed point math throughout the busy calculation in
> commit e66c1768 Change busy calculation to use fixed point
> math. Introduced some inaccuracies by rounding the busy value at two
> points in the calculation.  This change removes roundings and moves
> the rounding to the output of the PID where the calculations are
> complete and the value returned as an integer.
>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Cc: <stable@vger.kernel.org> # 3.14.x
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
> drivers/cpufreq/intel_pstate.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ffef765..db8a992 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -38,10 +38,10 @@
> #define BYT_TURBO_VIDS		0x66d
> 
> 
> -#define FRAC_BITS 6
> +#define FRAC_BITS 8
> #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> #define fp_toint(X) ((X) >> FRAC_BITS)
> -#define FP_ROUNDUP(X) ((X) += 1 << FRAC_BITS)
>+
> 
> static inline int32_t mul_fp(int32_t x, int32_t y)
> {
>@@ -194,7 +194,10 @@ static signed int pid_calc(struct _pid *pid, int32_t busy)
> 	pid->last_err = fp_error;
> 
> 	result = pterm + mul_fp(pid->integral, pid->i_gain) + dterm;
> -
> +	if (result >= 0)
> +		result = result + (1 << (FRAC_BITS-1));
> +	else
> +		result = result - (1 << (FRAC_BITS-1));
> 	return (signed int)fp_toint(result);
> }
> 
> @@ -556,7 +559,6 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> 
> 	core_pct = div_fp(int_tofp(sample->aperf), int_tofp(sample->mperf));
> 	core_pct = mul_fp(core_pct, int_tofp(100));
> -	FP_ROUNDUP(core_pct);
> 
> 	sample->freq = fp_toint(
> 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
> @@ -602,7 +604,7 @@ static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
> 	max_pstate = int_tofp(cpu->pstate.max_pstate);
> 	current_pstate = int_tofp(cpu->pstate.current_pstate);
> 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
> -	return FP_ROUNDUP(core_busy);
> +	return core_busy;
> }
> 
> static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
> -- 
> 1.9.0

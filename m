From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 06:41:20 -0700
Message-ID: <009b01cf857a$d5032090$7f0961b0$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta9.telus.net ([209.171.16.82]:57560 "EHLO cmta9.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbaFKNlY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Jun 2014 09:41:24 -0400
In-Reply-To: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stratos Karafotis' <stratosk@semaphore.gr>, rjw@rjwysocki.net, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


On 2014.06.11 05:34 Stratos Karafotis wrote:

> Local variable core_pct holds fixed point values.
> When we round it we add "1" to core_pct. This has almost
> no effect.
>
> So, add int_toftp(1) to core_pct when rounding.
>
> For example, in a given sample point (values taken from
> tracepoint) with:
> aperf = 5024
> mperf = 10619
>
> the core_pct is (before rounding):
> core_pct = 12111
> fp_toint(core_pct) = 47
>
> After rounding:
> core_pct = 12112
> fp_toint(core_pct) = 47
>
> After rounding with int_toftp(1):
> core_pct = 12367
> fp_toint(core_pct) = 48
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>
> Hi Rafael,
>
> I'm sorry for submitting again in merge window, but
> I thought that maybe we need this fix for 3.16.
>
>
> drivers/cpufreq/intel_pstate.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 4e7f492..dd80aa2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -564,7 +564,7 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> 	core_pct = div_u64_rem(core_pct, int_tofp(sample->mperf), &rem);
> 
> 	if ((rem << 1) >= int_tofp(sample->mperf))
> -		core_pct += 1;
> +		core_pct += int_tofp(1);
> 
> 	sample->freq = fp_toint(
> 		mul_fp(int_tofp(cpu->pstate.max_pstate * 1000), core_pct));
> -- 
> 1.9.3

No.

The intent was only ever to round properly the pseudo floating point result of the divide.
It was much more important (ugh, well 4 times more) when FRACBITS was still 6, which also got changed to 8 in a recent patch.

... Doug



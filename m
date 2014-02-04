From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Take core C0 time into account for core busy calculation
Date: Tue, 04 Feb 2014 21:59:28 +0100
Message-ID: <3052699.M8t2MgI9Sf@vostro.rjw.lan>
References: <1391446531-22785-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51011 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932676AbaBDUpA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2014 15:45:00 -0500
In-Reply-To: <1391446531-22785-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org

On Monday, February 03, 2014 08:55:31 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Take non-idle time into account when calculating core busy time.  This
> ensures that intel_pstate will notice a decrease in load.
> 
> reference:
> https://bugzilla.kernel.org/show_bug.cgi?id=66581
> 
> Cc: stable@vger.kernel.org # 3.10+
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

I've just queued this one up for the next pull request, although it didn't seem
to make it to linux-pm.

Thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 7e257b2..79606f4 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -57,6 +57,7 @@ struct sample {
>  	int32_t core_pct_busy;
>  	u64 aperf;
>  	u64 mperf;
> +	unsigned long long tsc;
>  	int freq;
>  };
>  
> @@ -96,6 +97,7 @@ struct cpudata {
>  
>  	u64	prev_aperf;
>  	u64	prev_mperf;
> +	unsigned long long prev_tsc;
>  	int	sample_ptr;
>  	struct sample samples[SAMPLE_COUNT];
>  };
> @@ -548,30 +550,41 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu,
>  					struct sample *sample)
>  {
>  	u64 core_pct;
> -	core_pct = div64_u64(int_tofp(sample->aperf * 100),
> -			     sample->mperf);
> -	sample->freq = fp_toint(cpu->pstate.max_pstate * core_pct * 1000);
> +	u64 c0_pct;
>  
> -	sample->core_pct_busy = core_pct;
> +	core_pct = div64_u64(sample->aperf * 100, sample->mperf);
> +
> +	c0_pct = div64_u64(sample->mperf * 100, sample->tsc);
> +	sample->freq = fp_toint(
> +		mul_fp(int_tofp(cpu->pstate.max_pstate),
> +			int_tofp(core_pct * 1000)));
> +
> +	sample->core_pct_busy = mul_fp(int_tofp(core_pct),
> +				div_fp(int_tofp(c0_pct + 1), int_tofp(100)));
>  }
>  
>  static inline void intel_pstate_sample(struct cpudata *cpu)
>  {
>  	u64 aperf, mperf;
> +	unsigned long long tsc;
>  
>  	rdmsrl(MSR_IA32_APERF, aperf);
>  	rdmsrl(MSR_IA32_MPERF, mperf);
> +	tsc = native_read_tsc();
>  
>  	cpu->sample_ptr = (cpu->sample_ptr + 1) % SAMPLE_COUNT;
>  	cpu->samples[cpu->sample_ptr].aperf = aperf;
>  	cpu->samples[cpu->sample_ptr].mperf = mperf;
> +	cpu->samples[cpu->sample_ptr].tsc = tsc;
>  	cpu->samples[cpu->sample_ptr].aperf -= cpu->prev_aperf;
>  	cpu->samples[cpu->sample_ptr].mperf -= cpu->prev_mperf;
> +	cpu->samples[cpu->sample_ptr].tsc -= cpu->prev_tsc;
>  
>  	intel_pstate_calc_busy(cpu, &cpu->samples[cpu->sample_ptr]);
>  
>  	cpu->prev_aperf = aperf;
>  	cpu->prev_mperf = mperf;
> +	cpu->prev_tsc = tsc;
>  }
>  
>  static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH v3 2/6] cpufreq: intel_pstate: get P1 from TAR when
 available
Date: Tue, 13 Oct 2015 13:34:56 -0700
Message-ID: <20151013133456.45e44fc2@kcaccard-desk.amr.corp.intel.com>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1443567248-27134-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53454 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515AbbJMUe6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 16:34:58 -0400
In-Reply-To: <1443567248-27134-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Tue, 29 Sep 2015 15:54:04 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> After Ivybridge, the max non turbo ratio obtained from platform info msr
> is not always guaranteed P1 on client platforms. The max non turbo
> activation ratio (TAR), determines the max for the current level of TDP.
> The ratio in platform info is physical max. The TAR MSR can be locked,
> so updating this value is not possible on all platforms.
> This change gets this ratio from MSR TURBO_ACTIVATION_RATIO if
> available,
> but also do some sanity checking to make sure that this value is
> correct.
> The sanity check involves reading the TDP ratio for the current tdp
> control value when platform has configurable TDP present and matching
> TAC
> with this.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>

> ---
>  arch/x86/include/asm/msr-index.h |  7 +++++++
>  drivers/cpufreq/intel_pstate.c   | 39 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index b8c14bb..9f39056 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -206,6 +206,13 @@
>  #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
>  #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
>  
> +/* Config TDP MSRs */
> +#define MSR_CONFIG_TDP_NOMINAL		0x00000648
> +#define MSR_CONFIG_TDP_LEVEL1		0x00000649
> +#define MSR_CONFIG_TDP_LEVEL2		0x0000064A
> +#define MSR_CONFIG_TDP_CONTROL		0x0000064B
> +#define MSR_TURBO_ACTIVATION_RATIO	0x0000064C
> +
>  /* Hardware P state interface */
>  #define MSR_PPERF			0x0000064e
>  #define MSR_PERF_LIMIT_REASONS		0x0000064f
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 576d9e8..b0ae951 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -43,7 +43,6 @@
>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
>  #define fp_toint(X) ((X) >> FRAC_BITS)
>  
> -
>  static inline int32_t mul_fp(int32_t x, int32_t y)
>  {
>  	return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
> @@ -613,10 +612,42 @@ static int core_get_min_pstate(void)
>  
>  static int core_get_max_pstate(void)
>  {
> -	u64 value;
> +	u64 tar;
> +	u64 plat_info;
> +	int max_pstate;
> +	int err;
> +
> +	rdmsrl(MSR_PLATFORM_INFO, plat_info);
> +	max_pstate = (plat_info >> 8) & 0xFF;
> +
> +	err = rdmsrl_safe(MSR_TURBO_ACTIVATION_RATIO, &tar);
> +	if (!err) {
> +		/* Do some sanity checking for safety */
> +		if (plat_info & 0x600000000) {
> +			u64 tdp_ctrl;
> +			u64 tdp_ratio;
> +			int tdp_msr;
> +
> +			err = rdmsrl_safe(MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
> +			if (err)
> +				goto skip_tar;
> +
> +			tdp_msr = MSR_CONFIG_TDP_NOMINAL + tdp_ctrl;
> +			err = rdmsrl_safe(tdp_msr, &tdp_ratio);
> +			if (err)
> +				goto skip_tar;
> +
> +			if (tdp_ratio - 1 == tar) {
> +				max_pstate = tar;
> +				pr_debug("max_pstate=TAC %x\n", max_pstate);
> +			} else {
> +				goto skip_tar;
> +			}
> +		}
> +	}
>  
> -	rdmsrl(MSR_PLATFORM_INFO, value);
> -	return (value >> 8) & 0xFF;
> +skip_tar:
> +	return max_pstate;
>  }
>  
>  static int core_get_turbo_pstate(void)


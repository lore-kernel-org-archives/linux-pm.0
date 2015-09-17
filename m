From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Added multiplier for APERF and MPERF counters
Date: Thu, 17 Sep 2015 19:04:56 +0200
Message-ID: <6353648.5IiCL7fVmQ@vostro.rjw.lan>
References: <1442407938-5228-1-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442407938-5228-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: len.brown@intel.com, dasaratharaman.chandramouli@intel.com, linux-kernel@vger.kernel.org, Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 16, 2015 02:52:18 PM Lukasz Anaczkowski wrote:
> From: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
> 
> Intel(R) Xeon Phi x200 (KNL) increments APERF/MPERF every
> 1024 clocks, which is different than other Intel architectures
> (incremented every single clock).
> It results in understated values for %Busy and Avg_MHz values,
> thus multiplier for APERF/MPERF counters.
> 
> Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

Please *always* send PM-related patches to linux-pm@vger.kernel.org (CCed now).

> ---
>  tools/power/x86/turbostat/turbostat.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9655cb4..1dda607 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -71,6 +71,7 @@ unsigned int extra_msr_offset32;
>  unsigned int extra_msr_offset64;
>  unsigned int extra_delta_offset32;
>  unsigned int extra_delta_offset64;
> +unsigned int aperf_mperf_multiplier = 1;
>  int do_smi;
>  double bclk;
>  unsigned int show_pkg;
> @@ -984,6 +985,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>  			return -3;
>  		if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
>  			return -4;
> +		t->aperf = t->aperf * aperf_mperf_multiplier;
> +		t->mperf = t->mperf * aperf_mperf_multiplier;
>  	}
>  
>  	if (do_smi) {
> @@ -2543,6 +2546,13 @@ int is_knl(unsigned int family, unsigned int model)
>  	return 0;
>  }
>  
> +unsigned int get_aperf_mperf_multiplier(unsigned int family, unsigned int model)
> +{
> +	if (is_knl(family, model))
> +		return 1024;
> +	return 1;
> +}
> +
>  #define SLM_BCLK_FREQS 5
>  double slm_freq_table[SLM_BCLK_FREQS] = { 83.3, 100.0, 133.3, 116.7, 80.0};
>  
> @@ -2744,6 +2754,9 @@ void process_cpuid()
>  		}
>  	}
>  
> +	if (has_aperf)
> +		aperf_mperf_multiplier = get_aperf_mperf_multiplier(family, model);
> +
>  	do_nhm_platform_info = do_nhm_cstates = do_smi = probe_nhm_msrs(family, model);
>  	do_snb_cstates = has_snb_msrs(family, model);
>  	do_pc2 = do_snb_cstates && (pkg_cstate_limit >= PCL__2);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

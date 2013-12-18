From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] intel_pstate: Add setting voltage value for baytrail P
 states.
Date: Wed, 18 Dec 2013 13:37:16 +0100
Message-ID: <1445568.VWz2v5WUSg@amdc1032>
References: <1387302127-7614-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22852 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3LRMhZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 07:37:25 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY000AJC5QBQJ50@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 21:37:23 +0900 (KST)
In-reply-to: <1387302127-7614-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, Dirk Brandewie <dirk.j.brandewie@intel.com>


Hi,

On Tuesday, December 17, 2013 09:42:06 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Baytrail requires setting P state and voltage pairs when adjusting the
> requested P state.  Add function for retrieving the valid voltage
> values and modify *_set_pstate() functions to caluclate the
> appropriate voltage for the requested P state.
> 
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 58 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 5f1cbae..4cc4534 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -35,6 +35,7 @@
>  #define SAMPLE_COUNT		3
>  
>  #define BYT_RATIOS	0x66a
> +#define BYT_VIDS        0x66b
>  
>  #define FRAC_BITS 8
>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> @@ -64,6 +65,12 @@ struct pstate_data {
>  	int	turbo_pstate;
>  };
>  
> +struct vid_data {
> +	int32_t min;
> +	int32_t max;
> +	int32_t ratio;
> +};
> +
>  struct _pid {
>  	int setpoint;
>  	int32_t integral;
> @@ -82,6 +89,7 @@ struct cpudata {
>  	struct timer_list timer;
>  
>  	struct pstate_data pstate;
> +	struct vid_data vid;
>  	struct _pid pid;
>  
>  	int min_pstate_count;
> @@ -106,7 +114,8 @@ struct pstate_funcs {
>  	int (*get_max)(void);
>  	int (*get_min)(void);
>  	int (*get_turbo)(void);
> -	void (*set)(int pstate);
> +	void (*set)(struct cpudata*, int pstate);
> +	void (*get_vid)(struct cpudata *);
>  };
>  
>  struct cpu_defaults {
> @@ -358,6 +367,41 @@ static int byt_get_max_pstate(void)
>  	return (value >> 16) & 0xFF;
>  }
>  
> +static void byt_set_pstate(struct cpudata *cpudata, int pstate)
> +{
> +	u64 val;
> +	int32_t vid_fp;
> +	u32 vid;
> +
> +	val = pstate << 8;
> +	if (limits.no_turbo)
> +		val |= (u64)1 << 32;
> +
> +	vid_fp = mul_fp(cpudata->vid.min +
> +			int_tofp(pstate - cpudata->pstate.min_pstate),
> +			cpudata->vid.ratio);

Shouldn't this be:

+	vid_fp = cpudata->vid.min + mul_fp(
+			int_tofp(pstate - cpudata->pstate.min_pstate),
+			cpudata->vid.ratio);

?

> +	vid_fp = clamp_t(int32_t, vid_fp, cpudata->vid.min, cpudata->vid.max);
> +	vid = fp_toint(vid_fp);
> +
> +	val |= vid;
> +
> +	wrmsrl(MSR_IA32_PERF_CTL, val);
> +}
> +
> +static void byt_get_vid(struct cpudata *cpudata)
> +{
> +	u64 value;

please add a newline here

> +	rdmsrl(BYT_VIDS, value);
> +	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
> +	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
> +	cpudata->vid.ratio = div_fp(
> +		cpudata->vid.max - cpudata->vid.min,
> +		int_tofp(cpudata->pstate.max_pstate - 
> +			cpudata->pstate.min_pstate));
> +}
> +
> +
>  static int core_get_min_pstate(void)
>  {
>  	u64 value;
> @@ -365,6 +409,7 @@ static int core_get_min_pstate(void)
>  	return (value >> 40) & 0xFF;
>  }
>  
> +

superfluous newline

>  static int core_get_max_pstate(void)
>  {
>  	u64 value;
> @@ -384,7 +429,7 @@ static int core_get_turbo_pstate(void)
>  	return ret;
>  }
>  
> -static void core_set_pstate(int pstate)
> +static void core_set_pstate(struct cpudata *cpudata, int pstate)
>  {
>  	u64 val;
>  
> @@ -425,7 +470,8 @@ static struct cpu_defaults byt_params = {
>  		.get_max = byt_get_max_pstate,
>  		.get_min = byt_get_min_pstate,
>  		.get_turbo = byt_get_max_pstate,
> -		.set = core_set_pstate,
> +		.set = byt_set_pstate,
> +		.get_vid = byt_get_vid,
>  	},
>  };
>  
> @@ -462,7 +508,7 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
>  
>  	cpu->pstate.current_pstate = pstate;
>  
> -	pstate_funcs.set(pstate);
> +	pstate_funcs.set(cpu, pstate);
>  }
>  
>  static inline void intel_pstate_pstate_increase(struct cpudata *cpu, int steps)
> @@ -488,6 +534,9 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  	cpu->pstate.max_pstate = pstate_funcs.get_max();
>  	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>  
> +	if (pstate_funcs.get_vid)
> +		pstate_funcs.get_vid(cpu);
> +
>  	/*
>  	 * goto max pstate so we don't slow up boot if we are built-in if we are
>  	 * a module we will take care of it during normal operation
> @@ -776,6 +825,7 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
>  	pstate_funcs.get_min   = funcs->get_min;
>  	pstate_funcs.get_turbo = funcs->get_turbo;
>  	pstate_funcs.set       = funcs->set;
> +	pstate_funcs.get_vid   = funcs->get_vid;
>  }
>  
>  #if IS_ENABLED(CONFIG_ACPI)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA33DC10F13
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 02:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B7520645
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 02:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfDOCKn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:10:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:30810 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfDOCKm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Apr 2019 22:10:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2019 19:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,351,1549958400"; 
   d="scan'208";a="140679783"
Received: from spandruv-mobl3.jf.intel.com ([10.251.156.198])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2019 19:10:41 -0700
Message-ID: <1831fa285e2b73cd8dd7583efe2f073c7277ed2a.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] x86: intel: Define MSR_POWER_CTL bits with symbolic
 constants
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Liran Alon <liran.alon@oracle.com>, linux-pm@vger.kernel.org,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date:   Sun, 14 Apr 2019 19:10:41 -0700
In-Reply-To: <20190414204831.93705-2-liran.alon@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
         <20190414204831.93705-2-liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2019-04-14 at 23:48 +0300, Liran Alon wrote:
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  arch/x86/include/asm/msr-index.h      | 7 +++++++
>  drivers/cpufreq/intel_pstate.c        | 6 ++----
>  drivers/idle/intel_idle.c             | 2 +-
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h
> b/arch/x86/include/asm/msr-index.h
> index 8e40c2446fd1..436f3c5aa358 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -209,6 +209,13 @@
>  
>  #define MSR_IA32_POWER_CTL		0x000001fc
>  
> +/* POWERCTLMSR bits: */
> +#define POWERCTLMSR_BI_DIR_PROCHOT	BIT(0)	/* Bi-directional
> PROCHOT */
> +#define POWERCTLMSR_C1E_ENABLE		BIT(1)  /* C1E Enable
> */
> +#define POWERCTLMSR_EN_ENERGY_PERF_BIAS	BIT(18) /* Enable
> MSR_IA32_ENERGY_PERF_BIAS */
> +#define POWERCTLMSR_DISABLE_RACE_TO_HLT	BIT(19)	/* Disable
> Race to Halt Optimization */
> +#define POWERCTLMSR_DISABLE_EE		BIT(20) /* Disable
> Energy Efficiency Optimization */
> +
>  #define MSR_IA32_MC0_CTL		0x00000400
>  #define MSR_IA32_MC0_STATUS		0x00000401
>  #define MSR_IA32_MC0_ADDR		0x00000402
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 3ce39c332c7b..b42ba4456f66 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1200,8 +1200,6 @@ static void intel_pstate_hwp_enable(struct
> cpudata *cpudata)
>  		cpudata->epp_default = intel_pstate_get_epp(cpudata,
> 0);
>  }
>  
> -#define MSR_IA32_POWER_CTL_BIT_EE	20
> -
>  /* Disable energy efficiency optimization */
>  static void intel_pstate_disable_ee(int cpu)
>  {
> @@ -1212,9 +1210,9 @@ static void intel_pstate_disable_ee(int cpu)
>  	if (ret)
>  		return;
>  
> -	if (!(power_ctl & BIT(MSR_IA32_POWER_CTL_BIT_EE))) {
> +	if (!(power_ctl & POWERCTLMSR_DISABLE_EE)) {
>  		pr_info("Disabling energy efficiency optimization\n");
> -		power_ctl |= BIT(MSR_IA32_POWER_CTL_BIT_EE);
> +		power_ctl |= POWERCTLMSR_DISABLE_EE;
To match SDM defintion
power_ctl |= POWERCTLMSR_DISABLE_RACE_TO_HLT;
To set BIT 20, we need some data why this is necessary. If you really
need performance set eneregy_perf_preference to performance.

Thanks,
Srinivas

>  		wrmsrl_on_cpu(cpu, MSR_IA32_POWER_CTL, power_ctl);
>  	}
>  }
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 8b5d85c91e9d..3654575e6697 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -977,7 +977,7 @@ static void c1e_promotion_disable(void)
>  	unsigned long long msr_bits;
>  
>  	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
> -	msr_bits &= ~0x2;
> +	msr_bits &= ~POWERCTLMSR_C1E_ENABLE;
>  	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
>  }
>  
> diff --git a/tools/power/x86/turbostat/turbostat.c
> b/tools/power/x86/turbostat/turbostat.c
> index 9327c0ddc3a5..0455aa7e9c6f 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2019,7 +2019,7 @@ dump_nhm_platform_info(void)
>  
>  	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
>  	fprintf(outf, "cpu%d: MSR_IA32_POWER_CTL: 0x%08llx (C1E auto-
> promotion: %sabled)\n",
> -		base_cpu, msr, msr & 0x2 ? "EN" : "DIS");
> +		base_cpu, msr, msr & POWERCTLMSR_C1E_ENABLE ? "EN" :
> "DIS");
>  
>  	return;
>  }


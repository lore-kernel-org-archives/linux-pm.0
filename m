From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: set BYT MSR with wrmsrl_on_cpu()
Date: Thu, 07 May 2015 22:58:11 +0200
Message-ID: <2313402.8O0OJYkUeN@vostro.rjw.lan>
References: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52588 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751310AbbEGUdH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 16:33:07 -0400
In-Reply-To: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Konno <joe.konno@linux.intel.com>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, kristen@linux.intel.com

On Thursday, May 07, 2015 09:59:39 AM Joe Konno wrote:
> From: Joe Konno <joe.konno@intel.com>
> 
> In instances where the default cpufreq governor is Performance, reading

I'm not really sure what this is about.  You're talking about cpufreq governors
and this is an intel_pstate patch.  What gives?

> from MSR 0x199 on an applicable multi-core Atom system saw boot-to-boot
> variability in the P-State value set to each logical core.  Sometimes
> only one logical core would be set properly, other times two or three.
> There was an assumption in the code that only a thread on the intended
> logical core would be calling the wrmsrl() function. That was disproven
> during debug, as cpufreq, at init, was not always calling from the same
> as the logical core it targeted. Thus, use wrmsrl_on_cpu() instead, as
> done in the core_set_pstate() function.
> 
> For: LCK-1822

This tag is meaningless upstream.

> Fixes: 007bea098b86 ("intel_pstate: Add setting voltage value for
>        baytrail P states.")

So, you're fixing a function introduced by the above commit, right?

> Signed-off-by: Joe Konno <joe.konno@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 6414661ac1c4..c45d274a75c8 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -535,7 +535,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
>  
>  	val |= vid;
>  
> -	wrmsrl(MSR_IA32_PERF_CTL, val);
> +	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);

So the bug is that this may run on a CPU which is not cpudata->cpu in which
case the write will not happen where it should.  Is that correct?

>  }
>  
>  #define BYT_BCLK_FREQS 5
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

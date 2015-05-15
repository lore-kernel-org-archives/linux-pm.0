From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: set BYT MSR with wrmsrl_on_cpu()
Date: Fri, 15 May 2015 02:13:53 +0200
Message-ID: <1458810.lKIo4Hmxxm@vostro.rjw.lan>
References: <1431017979-28349-1-git-send-email-joe.konno@linux.intel.com> <1431442782-12061-1-git-send-email-joe.konno@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49767 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933297AbbENXsl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:48:41 -0400
In-Reply-To: <1431442782-12061-1-git-send-email-joe.konno@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Konno <joe.konno@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, kristen@linux.intel.com

On Tuesday, May 12, 2015 07:59:42 AM Joe Konno wrote:
> From: Joe Konno <joe.konno@intel.com>
> 
> Commit 007bea098b86 (intel_pstate: Add setting voltage value for
> baytrail P states.) introduced byt_set_pstate() with the assumption that
> it would always be run by the CPU whose MSR is to be written by it.  It
> turns out, however, that is not always the case in practice, so modify
> byt_set_pstate() to enforce the MSR write done by it to always happen on
> the right CPU.
> 
> v2: better commit message, remove For: tag
> 
> Fixes: 007bea098b86 ("intel_pstate: Add setting voltage value for
>        baytrail P states.")
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
>  }
>  
>  #define BYT_BCLK_FREQS 5

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

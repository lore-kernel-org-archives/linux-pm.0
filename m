From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: enable hwp per cpu
Date: Tue, 14 Jul 2015 10:58:32 -0700
Message-ID: <20150714105832.43ef93d0@kcaccard-desk.amr.corp.intel.com>
References: <1436892383-4217-1-git-send-email-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58480 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbbGNR6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 13:58:36 -0400
In-Reply-To: <1436892383-4217-1-git-send-email-kristen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

On Tue, 14 Jul 2015 09:46:23 -0700
Kristen Carlson Accardi <kristen@linux.intel.com> wrote:

> HWP previously was only enabled at driver load time, on the boot
> cpu, however, HWP must be enabled per package. Move the code to
> enable HWP to the cpufreq driver init path so that it will be
> called per cpu.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen@linux.intel.com>
> Tested-by: David Zhuang <david.zhuang@oracle.com>

Oops - don't apply this one yet please.  I think I
might have broken S3 resume.

Sorry for the noise,
Kristen

> ---
>  drivers/cpufreq/intel_pstate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 15ada47..763d8f3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -484,12 +484,11 @@ static void __init intel_pstate_sysfs_expose_params(void)
>  }
>  /************************** sysfs end ************************/
>  
> -static void intel_pstate_hwp_enable(void)
> +static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
> -	hwp_active++;
>  	pr_info("intel_pstate: HWP enabled\n");
>  
> -	wrmsrl( MSR_PM_ENABLE, 0x1);
> +	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
>  }
>  
>  static int byt_get_min_pstate(void)
> @@ -932,6 +931,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  	cpu = all_cpu_data[cpunum];
>  
>  	cpu->cpu = cpunum;
> +
> +	if (hwp_active)
> +		intel_pstate_hwp_enable(cpu);
> +
>  	intel_pstate_get_cpu_pstates(cpu);
>  
>  	init_timer_deferrable(&cpu->timer);
> @@ -1245,7 +1248,7 @@ static int __init intel_pstate_init(void)
>  		return -ENOMEM;
>  
>  	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp)
> -		intel_pstate_hwp_enable();
> +		hwp_active++;
>  
>  	if (!hwp_active && hwp_only)
>  		goto out;


From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: provide option to only use intel_pstate with HWP
Date: Fri, 06 Feb 2015 23:31:25 +0100
Message-ID: <3031066.PyJmDOpUSA@vostro.rjw.lan>
References: <1423258915-26457-1-git-send-email-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52051 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752664AbbBFWI0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Feb 2015 17:08:26 -0500
In-Reply-To: <1423258915-26457-1-git-send-email-kristen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Friday, February 06, 2015 01:41:55 PM Kristen Carlson Accardi wrote:
> Allow users the option to disable the driver for any hardware
> which does not support HWP.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

OK, queued up for 3.20, thanks!

> ---
>  Documentation/kernel-parameters.txt | 3 +++
>  drivers/cpufreq/intel_pstate.c      | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 4df73da..07e6701 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1469,6 +1469,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		       no_hwp
>  		         Do not enable hardware P state control (HWP)
>  			 if available.
> +		hwp_only
> +			Only load intel_pstate on systems which support
> +			hardware P state control (HWP) if available.
>  
>  	intremap=	[X86-64, Intel-IOMMU]
>  			on	enable Interrupt Remapping (default)
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index e7e808d..872c577 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1019,6 +1019,7 @@ static struct cpufreq_driver intel_pstate_driver = {
>  
>  static int __initdata no_load;
>  static int __initdata no_hwp;
> +static int __initdata hwp_only;
>  static unsigned int force_load;
>  
>  static int intel_pstate_msrs_not_valid(void)
> @@ -1216,6 +1217,9 @@ static int __init intel_pstate_init(void)
>  	if (cpu_has(c,X86_FEATURE_HWP) && !no_hwp)
>  		intel_pstate_hwp_enable();
>  
> +	if (!hwp_active && hwp_only)
> +		goto out;
> +
>  	rc = cpufreq_register_driver(&intel_pstate_driver);
>  	if (rc)
>  		goto out;
> @@ -1250,6 +1254,8 @@ static int __init intel_pstate_setup(char *str)
>  		no_hwp = 1;
>  	if (!strcmp(str, "force"))
>  		force_load = 1;
> +	if (!strcmp(str, "hwp_only"))
> +		hwp_only = 1;
>  	return 0;
>  }
>  early_param("intel_pstate", intel_pstate_setup);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

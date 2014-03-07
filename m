From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PowerCap / RAPL : Use async init
Date: Fri, 07 Mar 2014 23:50:03 +0100
Message-ID: <1486699.nLGJSaYjcT@vostro.rjw.lan>
References: <1394214529-11369-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54961 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753829AbaCGWes (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Mar 2014 17:34:48 -0500
In-Reply-To: <1394214529-11369-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Friday, March 07, 2014 09:48:49 AM Srinivas Pandruvada wrote:
> The rapl_init function takes around 58ms per domain. This change
> reduce this by introducing async_schedule. Only disadvanatge is
> that only presence of RAPL feature is checked for succesful module
> init. If there is any other error, it will simply not create powercap
> sysfs files, but module will still return success.

Well, can't we wait for the async stuff to complete and collect status from
it before returning from rapl_init()?

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 61b51e1..3b11c6f 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -29,6 +29,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/cpu.h>
>  #include <linux/powercap.h>
> +#include <linux/async.h>
>  
>  #include <asm/processor.h>
>  #include <asm/cpu_device_id.h>
> @@ -1364,16 +1365,10 @@ static struct notifier_block rapl_cpu_notifier = {
>  	.notifier_call = rapl_cpu_callback,
>  };
>  
> -static int __init rapl_init(void)
> +static void __init rapl_init_async(void *unused, async_cookie_t cookie)
>  {
>  	int ret = 0;
>  
> -	if (!x86_match_cpu(rapl_ids)) {
> -		pr_err("driver does not support CPU family %d model %d\n",
> -			boot_cpu_data.x86, boot_cpu_data.x86_model);
> -
> -		return -ENODEV;
> -	}
>  	/* prevent CPU hotplug during detection */
>  	get_online_cpus();
>  	ret = rapl_detect_topology();
> @@ -1382,14 +1377,27 @@ static int __init rapl_init(void)
>  
>  	if (rapl_register_powercap()) {
>  		rapl_cleanup_data();
> -		ret = -ENODEV;
>  		goto done;
>  	}
>  	register_hotcpu_notifier(&rapl_cpu_notifier);
>  done:
>  	put_online_cpus();
>  
> -	return ret;
> +}
> +
> +static int __init rapl_init(void)
> +{
> +
> +	if (!x86_match_cpu(rapl_ids)) {
> +		pr_err("driver does not support CPU family %d model %d\n",
> +			boot_cpu_data.x86, boot_cpu_data.x86_model);
> +
> +		return -ENODEV;
> +	}
> +
> +	async_schedule(rapl_init_async, NULL);
> +
> +	return 0;
>  }
>  
>  static void __exit rapl_exit(void)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

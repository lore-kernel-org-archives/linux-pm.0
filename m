From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 2/3][v2] Thermal: handle thermal zone device properly
 during system sleep
Date: Wed, 28 Oct 2015 10:33:11 +0000
Message-ID: <20151028103310.GA2686@e104805>
References: <cover.1445828170.git.yu.c.chen@intel.com>
 <263fad83855e3da9c768fec15f496a308953d05a.1445828170.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33201 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbbJ1KdO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Oct 2015 06:33:14 -0400
Content-Disposition: inline
In-Reply-To: <263fad83855e3da9c768fec15f496a308953d05a.1445828170.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, Chen Yu <yu.c.chen@intel.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hi Yu,

some minor nits below.  Other than that, you can add my

Reviewed-by: Javi Merino <javi.merino@arm.com>

On Mon, Oct 26, 2015 at 11:14:31AM +0800, Chen Yu wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Current thermal code does not handle system sleep well because
> 1. the cooling device cooling state may be changed during suspend
> 2. the previous temperature reading becomes invalid after resumed because
>    it is got before system sleep
> 3. updating thermal zone device during suspending/resuming
>    is wrong because some devices may have already been suspended
>    or may have not been resumed.
> 
> Thus, the proper way to do this is to cancel all thermal zone
> device update requirements during suspend/resume, and after all
> the devices have been resumed, reset and update every registered
> thermal zone devices.
> 
> This also fixes a regression introduced by:
> Commit 19593a1fb1f6 ("ACPI / fan: convert to platform driver")
> Because, with above commit applied, all the fan devices are attached
> to the acpi_general_pm_domain, and they are turned on by the pm_domain
> automatically after resume, without the awareness of thermal core.
> 
> CC: <stable@vger.kernel.org> #3.18+
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=78201
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=91411
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 682bc1e..abeb995 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/of.h>
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
> +#include <linux/suspend.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal.h>
> @@ -59,6 +60,8 @@ static LIST_HEAD(thermal_governor_list);
>  static DEFINE_MUTEX(thermal_list_lock);
>  static DEFINE_MUTEX(thermal_governor_lock);
>  
> +static atomic_t in_suspend;
> +
>  static struct thermal_governor *def_governor;
>  
>  static struct thermal_governor *__find_governor(const char *name)
> @@ -554,6 +557,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
>  	int count;
>  
> +	if (atomic_read(&in_suspend))
> +		return;
> +
>  	if (!tz->ops->get_temp)
>  		return;
>  
> @@ -2155,9 +2161,39 @@ static void thermal_unregister_governors(void)
>  	thermal_gov_power_allocator_unregister();
>  }
>  
> +static int thermal_pm_notify(struct notifier_block *nb,
> +				unsigned long mode, void *_unused)
> +{
> +	struct thermal_zone_device *tz;
> +
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		atomic_set(&in_suspend, 1);
> +		break;
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +	case PM_POST_SUSPEND:
> +		atomic_set(&in_suspend, 0);
> +		list_for_each_entry(tz, &thermal_tz_list, node) {
> +			thermal_zone_device_reset(tz);
> +			thermal_zone_device_update(tz);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static struct notifier_block thermal_pm_nb = {
> +	.notifier_call = thermal_pm_notify,
> +};
> +
>  static int __init thermal_init(void)
>  {
> -	int result;
> +	int result, notifier_result;
>  
>  	result = thermal_register_governors();
>  	if (result)
> @@ -2175,6 +2211,12 @@ static int __init thermal_init(void)
>  	if (result)
>  		goto exit_netlink;
>  
> +	notifier_result = register_pm_notifier(&thermal_pm_nb);

No need to define a new variable, you can use result.

> +	if (notifier_result)
> +		pr_err("Thermal: Can not register suspend notifier"

pr_warn ?

> +			"for thermal framework, return %d\n",

Please keep the string in the same line, don't break it.  I know that
checkpatch.pl complains, but the CodingStyle says don't break them:

"However, never break user-visible strings such as printk messages,
because that breaks the ability to grep for them"

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/CodingStyle#n86

Cheers,
Javi

> +			notifier_result);
> +
>  	return 0;
>  
>  exit_netlink:
> @@ -2194,6 +2236,7 @@ error:
>  
>  static void __exit thermal_exit(void)
>  {
> +	unregister_pm_notifier(&thermal_pm_nb);
>  	of_thermal_destroy_zones();
>  	genetlink_exit();
>  	class_unregister(&thermal_class);
> -- 
> 1.8.4.2
> 

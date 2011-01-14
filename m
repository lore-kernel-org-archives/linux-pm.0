From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Do not create wakeup sysfs files
 for devices that cannot wakeup
Date: Fri, 14 Jan 2011 15:08:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101141451500.1885-100000__12481.7605516457$1295035777$gmane$org@iolanthe.rowland.org>
References: <201101140134.43342.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101140134.43342.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Jan 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Currently, wakeup sysfs attributes are created for all devices,
> regardless of whether or not they are wakeup-capable.  This is
> excessive and complicates wakeup device identification from user
> space (i.e. to identify wakeup-capable devices user space has to read
> /sys/devices/.../power/wakeup for all devices and see if these files
> are not empty).
> 
> Fix this issue by avoiding to create wakeup sysfs files for devices
> that cannot wake up the system from sleep states (i.e. whose
> power.can_wakeup flags are unset during registration) and modify
> device_set_wakeup_capable() so that it adds (or removes) the relevant
> sysfs attributes if a device's wakeup capability status is changed.

...

>  static struct attribute *runtime_attrs[] = {
> -#ifndef CONFIG_PM_ADVANCED_DEBUG
> +#ifdef CONFIG_PM_RUNTIME
>  	&dev_attr_runtime_status.attr,
> -#endif
>  	&dev_attr_control.attr,
>  	&dev_attr_runtime_suspended_time.attr,
>  	&dev_attr_runtime_active_time.attr,
>  	&dev_attr_autosuspend_delay_ms.attr,
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +	&dev_attr_runtime_usage.attr,
> +	&dev_attr_runtime_active_kids.attr,
> +	&dev_attr_runtime_enabled.attr,
> +#endif
> +#endif /* CONFIG_PM_RUNTIME */
>  	NULL,
>  };
>  static struct attribute_group pm_runtime_attr_group = {
> @@ -480,35 +485,49 @@ int dpm_sysfs_add(struct device *dev)
>  	int rc;
>  
>  	rc = sysfs_create_group(&dev->kobj, &pm_attr_group);
> -	if (rc == 0 && !dev->power.no_callbacks) {
> +	if (rc)
> +		return rc;
> +
> +	if (pm_runtime_callbacks_present(dev)) {
>  		rc = sysfs_merge_group(&dev->kobj, &pm_runtime_attr_group);
>  		if (rc)
> -			sysfs_remove_group(&dev->kobj, &pm_attr_group);
> +			goto err_out;
> +	}

One thing I don't like about this change.  The original code defines
runtime_status, runtime_usage, runtime_active_kids, and runtime_enabled
whenever PM_RUNTIME and PM_ADVANCED_DEBUG are set.  Now you don't
define these attributes if runtime callbacks aren't present, even 
though they would still make sense.  Maybe you should have two 
runtime-related attribute groups, where one depends on 
callbacks_present and the other doesn't.

Apart from that, it all seems reasonable.  But you should change the
description of the wakeup attribute in Documentation/power/devices.txt;  
it says that the attribute file is present but empty if the device is
not wakeup-capable.

Alan Stern

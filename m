From: Yasuaki Ishimatsu <yasu.isimatu@gmail.com>
Subject: Re: [PATCH] thermal: core: move tz->device.groups cleanup to
 thermal_release
Date: Thu, 5 Jan 2017 12:06:01 -0500
Message-ID: <291c5827-d0c6-51c8-727c-686f826e7b05@gmail.com>
References: <20161230190752.7050-1-jacobvonchorus@cwphoto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161230190752.7050-1-jacobvonchorus@cwphoto.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob von Chorus <jacobvonchorus@cwphoto.ca>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 12/30/2016 02:07 PM, Jacob von Chorus wrote:
> The device_unregister call in thermal_zone_device_unregister causes the
> thermal_zone_device structure to be freed before the call to free the
> dynamically allocated attribute groups. This leads to a kernel panic.

Could you add the following call trace:

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: strlen+0x0/0x20
<snip>
Call Trace:
   ? kernfs_name_hash+0x17/0x80
   kernfs_find_ns+0x3f/0xd0
   kernfs_remove_by_name_ns+0x36/0xa0
   remove_files.isra.1+0x36/0x70
   sysfs_remove_group+0x44/0x90
   sysfs_remove_groups+0x2e/0x50
   device_remove_attrs+0x5e/0x90
   device_del+0x1ea/0x350
   device_unregister+0x1a/0x60
   thermal_zone_device_unregister+0x1f2/0x210
   pkg_thermal_cpu_offline+0x14f/0x1a0 [x86_pkg_temp_thermal]
   ? kzalloc.constprop.2+0x10/0x10 [x86_pkg_temp_thermal]
   cpuhp_invoke_callback+0x8d/0x3f0
   cpuhp_down_callbacks+0x42/0x80
   cpuhp_thread_fun+0x8b/0xf0
   smpboot_thread_fn+0x110/0x160
   kthread+0x101/0x140
   ? sort_range+0x30/0x30
   ? kthread_park+0x90/0x90
   ret_from_fork+0x25/0x30

If someone hit the kernel panic, they can find the patch from git log
more easily.

> Furthermore, the 4 calls to free the trip point attribute structures
> occur before the call to unregister the device, leading to a kernel
> panic when sysfs attempts to access the attributes to remove them.
>
> This patch moves the kfree calls to clean up the dynamic attributes to
> the thermal_class's thermal_zone_device release function.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jacob von Chorus <jacobvonchorus@cwphoto.ca>
Tested-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu
> ---
>  drivers/thermal/thermal_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 641faab..6555913 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -799,6 +799,11 @@ static void thermal_release(struct device *dev)
>  	if (!strncmp(dev_name(dev), "thermal_zone",
>  		     sizeof("thermal_zone") - 1)) {
>  		tz = to_thermal_zone(dev);
> +		kfree(tz->trip_type_attrs);
> +		kfree(tz->trip_temp_attrs);
> +		kfree(tz->trip_hyst_attrs);
> +		kfree(tz->trips_attribute_group.attrs);
> +		kfree(tz->device.groups);
>  		kfree(tz);
>  	} else if (!strncmp(dev_name(dev), "cooling_device",
>  			    sizeof("cooling_device") - 1)) {
> @@ -1305,10 +1310,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>
>  	thermal_zone_device_set_polling(tz, 0);
>
> -	kfree(tz->trip_type_attrs);
> -	kfree(tz->trip_temp_attrs);
> -	kfree(tz->trip_hyst_attrs);
> -	kfree(tz->trips_attribute_group.attrs);
>  	thermal_set_governor(tz, NULL);
>
>  	thermal_remove_hwmon_sysfs(tz);
> @@ -1316,7 +1317,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	idr_destroy(&tz->idr);
>  	mutex_destroy(&tz->lock);
>  	device_unregister(&tz->device);
> -	kfree(tz->device.groups);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>
>

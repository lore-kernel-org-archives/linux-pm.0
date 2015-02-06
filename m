From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 5/5] thermal: fair_share: generalize the weight
 concept
Date: Fri, 06 Feb 2015 17:29:54 +0800
Message-ID: <1423214994.1729.37.camel@rzhang1-mobl4>
References: <1422881490-14695-1-git-send-email-javi.merino@arm.com>
	 <1422881490-14695-6-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44705 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbbBFJaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Feb 2015 04:30:04 -0500
In-Reply-To: <1422881490-14695-6-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Punit.Agrawal@arm.com, Kapileshwar.Singh@arm.com, Eduardo Valentin <edubezval@gmail.com>

Hi, Javi,

In general, the patches look good to me.
They are all reasonable fixes/enhancements to me. Thanks a lot for your
work.
I just have one comment with this patch.

On Mon, 2015-02-02 at 12:51 +0000, Javi Merino wrote:
> The fair share governor has the concept of weights, which is the
> influence of each cooling device in a thermal zone.  The current
> implementation forces the weights of all cooling devices in a thermal
> zone to add up to a 100.  This complicates setups, as you need to know
> in advance how many cooling devices you are going to have.  If you bind a
> new cooling device, you have to modify all the other cooling devices
> weights, which is error prone.  Furthermore, you can't specify a
> "default" weight for platforms since that default value depends on the
> number of cooling devices in the platform.
> 
> This patch generalizes the concept of weight by allowing any number to
> be a "weight".  Weights are now relative to each other.  Platforms that
> don't specify weights get the same default value for all their cooling
> devices, so all their cdevs are considered to be equally influential.
> 
I don't think we have covered these two cases.

First of all. for the thermal zones that bind using tz->tbp, and all the
weights equals 0, it actually means THERMAL_WEIGHT_DEFAULT instead of
zero.
IMO, I think we should 
1. leave THERMAL_WEIGHT_DEFAULT as 0
2. remove
	if (!total_weight)
		return -EINVAL;
3. when calculating percentage,
	if (!total_weight)
		percentage = 100 / total_instances_of_the_current_trip;

Second, for the thermal zones that don't specify the weight for all of
its cooling devices. In this case, I think only the cooling devices with
weight should be used. Thus, we should
1. leave THERMAL_WEIGHT_DEFAULT as 0
2. for cooling devices do not have weight specified, we don't need to
change any code and its percentage is zero.

In all, I'd prefer to remove the change for THERMAL_WEIGHT_DEFAULT, and
change fair_share_throttle() as below, what do you think?

thanks,
rui

@@ -77,7 +77,7 @@ static long get_target_state(struct
thermal_zone_device *tz,
  *
  * Parameters used for Throttling:
  * P1. max_state: Maximum throttle state exposed by the cooling device.
- * P2. weight[i]/100:
+ * P2. percentage[i]/100:
  *     How 'effective' the 'i'th device is, in cooling the given zone.
  * P3. cur_trip_level/max_no_of_trips:
  *     This describes the extent to which the devices should be
throttled.
@@ -89,16 +89,31 @@ static long get_target_state(struct
thermal_zone_device *tz,
 static int fair_share_throttle(struct thermal_zone_device *tz, int
trip)
 {
        struct thermal_instance *instance;
+       int total_weight = 0;
+       int total_instance = 0;
        int cur_trip_level = get_trip_level(tz);
 
        list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+               if (instance->trip != trip)
+                       continue;
+
+               total_weight += instance->weight;
+               total_instance++;
+       }
+
+       list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+               int percentage;
                struct thermal_cooling_device *cdev = instance->cdev;
 
                if (instance->trip != trip)
                        continue;
 
-               instance->target = get_target_state(tz, cdev,
-                                       instance->weight,
cur_trip_level);
+               if (!total_weight)
+                       percentage = 100 / total_instance;
+               else
+                       percentage = (instance->weight * 100) /
total_weight;
+               instance->target = get_target_state(tz, cdev,
percentage,
+                                                   cur_trip_level);
 
                instance->cdev->updated = false;
                thermal_cdev_update(cdev);


> It's important to note that previous users of the weights don't need to
> alter the code: percentages continue to work as they used to.  This
> patch just removes the constraint of all the weights in a thermal zone
> having to add up to a 100.  If they do, you get the same behavior as
> before.  If they don't, fair share now works for that platform.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  Documentation/thermal/sysfs-api.txt |  8 +++++---
>  drivers/thermal/fair_share.c        | 23 ++++++++++++++++++-----
>  include/linux/thermal.h             | 17 ++++++++++++-----
>  3 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 3625453ceef6..c9fd014f0c21 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -129,9 +129,11 @@ temperature) and throttle appropriate devices.
>      This structure defines the following parameters that are used to bind
>      a zone with a cooling device for a particular trip point.
>      .cdev: The cooling device pointer
> -    .weight: The 'influence' of a particular cooling device on this zone.
> -             This is on a percentage scale. The sum of all these weights
> -             (for a particular zone) cannot exceed 100.
> +    .weight: The 'influence' of a particular cooling device on this
> +             zone. This is relative to the rest of the cooling
> +             devices. For example, if all cooling devices have a
> +             weight of 1, then they all contribute the same. You can
> +             use percentages if you want, but it's not mandatory.
>      .trip_mask:This is a bit mask that gives the binding relation between
>                 this thermal zone and cdev, for a particular trip point.
>                 If nth bit is set, then the cdev and thermal zone are bound
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index 692f4053f08b..5cd6ff1d0a4c 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -59,13 +59,13 @@ static int get_trip_level(struct thermal_zone_device *tz)
>  }
>  
>  static long get_target_state(struct thermal_zone_device *tz,
> -		struct thermal_cooling_device *cdev, int weight, int level)
> +		struct thermal_cooling_device *cdev, int percentage, int level)
>  {
>  	unsigned long max_state;
>  
>  	cdev->ops->get_max_state(cdev, &max_state);
>  
> -	return (long)(weight * level * max_state) / (100 * tz->trips);
> +	return (long)(percentage * level * max_state) / (100 * tz->trips);
>  }
>  
>  /**
> @@ -77,7 +77,7 @@ static long get_target_state(struct thermal_zone_device *tz,
>   *
>   * Parameters used for Throttling:
>   * P1. max_state: Maximum throttle state exposed by the cooling device.
> - * P2. weight[i]/100:
> + * P2. percentage[i]/100:
>   *	How 'effective' the 'i'th device is, in cooling the given zone.
>   * P3. cur_trip_level/max_no_of_trips:
>   *	This describes the extent to which the devices should be throttled.
> @@ -89,16 +89,29 @@ static long get_target_state(struct thermal_zone_device *tz,
>  static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
>  {
>  	struct thermal_instance *instance;
> +	int total_weight = 0;
>  	int cur_trip_level = get_trip_level(tz);
>  
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		if (instance->trip != trip)
> +			continue;
> +
> +		total_weight += instance->weight;
> +	}
> +
> +	if (!total_weight)
> +		return -EINVAL;
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		int percentage;
>  		struct thermal_cooling_device *cdev = instance->cdev;
>  
>  		if (instance->trip != trip)
>  			continue;
>  
> -		instance->target = get_target_state(tz, cdev,
> -					instance->weight, cur_trip_level);
> +		percentage = (instance->weight * 100) / total_weight;
> +		instance->target = get_target_state(tz, cdev, percentage,
> +						    cur_trip_level);
>  
>  		instance->cdev->updated = false;
>  		thermal_cdev_update(cdev);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 2ed7062fac1d..2426426731ca 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -40,8 +40,12 @@
>  /* No upper/lower limit requirement */
>  #define THERMAL_NO_LIMIT	((u32)~0)
>  
> -/* Default weight of a bound cooling device */
> -#define THERMAL_WEIGHT_DEFAULT 0
> +/*
> + * Default weight of a bound cooling device.  By setting it to 1024 we
> + * give developers a range so that they can specify cooling devices
> + * that are less or more "influential" than the default
> + */
> +#define THERMAL_WEIGHT_DEFAULT 1024
>  
>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> @@ -217,9 +221,12 @@ struct thermal_bind_params {
>  
>  	/*
>  	 * This is a measure of 'how effectively these devices can
> -	 * cool 'this' thermal zone. The shall be determined by platform
> -	 * characterization. This is on a 'percentage' scale.
> -	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 * cool 'this' thermal zone. It shall be determined by
> +	 * platform characterization. This value is relative to the
> +	 * rest of the weights so a cooling device whose weight is
> +	 * double that of another cooling device is twice as
> +	 * effective. See Documentation/thermal/sysfs-api.txt for more
> +	 * information.
>  	 */
>  	int weight;
>  



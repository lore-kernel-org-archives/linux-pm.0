From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH v3 5/5] thermal: fair_share: generalize the weight
 concept
Date: Thu, 19 Feb 2015 13:36:12 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59090DD994@BGSMSX101.gar.corp.intel.com>
References: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
 <1424275465-16144-6-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30085 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbbBSNgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 08:36:19 -0500
In-Reply-To: <1424275465-16144-6-git-send-email-javi.merino@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

>-----Original Message-----
>From: Javi Merino [mailto:javi.merino@arm.com]
>Sent: Wednesday, February 18, 2015 9:34 PM
>To: Zhang, Rui; edubezval@gmail.com
>Cc: linux-pm@vger.kernel.org; Javi Merino; R, Durgadoss
>Subject: [PATCH v3 5/5] thermal: fair_share: generalize the weight concept
>
>The fair share governor has the concept of weights, which is the
>influence of each cooling device in a thermal zone.  The current
>implementation forces the weights of all cooling devices in a thermal
>zone to add up to a 100.  This complicates setups, as you need to know
>in advance how many cooling devices you are going to have.  If you bind a
>new cooling device, you have to modify all the other cooling devices
>weights, which is error prone.  Furthermore, you can't specify a
>"default" weight for platforms since that default value depends on the
>number of cooling devices in the platform.
>
>This patch generalizes the concept of weight by allowing any number to
>be a "weight".  Weights are now relative to each other.  Platforms that
>don't specify weights get the same default value for all their cooling
>devices, so all their cdevs are considered to be equally influential.
>
>It's important to note that previous users of the weights don't need to
>alter the code: percentages continue to work as they used to.  This

Ok, I verified this in the below code.
Looks good to me,

Acked-by: Durgadoss R <durgadoss.r@intel.com>

>patch just removes the constraint of all the weights in a thermal zone
>having to add up to a 100.  If they do, you get the same behavior as
>before.  If they don't, fair share now works for that platform.
>
>Cc: Zhang Rui <rui.zhang@intel.com>
>Cc: Eduardo Valentin <edubezval@gmail.com>
>Cc: Durgadoss R <durgadoss.r@intel.com>
>Signed-off-by: Javi Merino <javi.merino@arm.com>
>---
> Documentation/thermal/sysfs-api.txt | 12 +++++++++---
> drivers/thermal/fair_share.c        | 26 +++++++++++++++++++++-----
> include/linux/thermal.h             |  9 ++++++---
> 3 files changed, 36 insertions(+), 11 deletions(-)
>
>diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
>index 3625453ceef6..fc7dfe10778b 100644
>--- a/Documentation/thermal/sysfs-api.txt
>+++ b/Documentation/thermal/sysfs-api.txt
>@@ -129,9 +129,15 @@ temperature) and throttle appropriate devices.
>     This structure defines the following parameters that are used to bind
>     a zone with a cooling device for a particular trip point.
>     .cdev: The cooling device pointer
>-    .weight: The 'influence' of a particular cooling device on this zone.
>-             This is on a percentage scale. The sum of all these weights
>-             (for a particular zone) cannot exceed 100.
>+    .weight: The 'influence' of a particular cooling device on this
>+             zone. This is relative to the rest of the cooling
>+             devices. For example, if all cooling devices have a
>+             weight of 1, then they all contribute the same. You can
>+             use percentages if you want, but it's not mandatory. A
>+             weight of 0 means that this cooling device doesn't
>+             contribute to the cooling of this zone unless all cooling
>+             devices have a weight of 0. If all weights are 0, then
>+             they all contribute the same.
>     .trip_mask:This is a bit mask that gives the binding relation between
>                this thermal zone and cdev, for a particular trip point.
>                If nth bit is set, then the cdev and thermal zone are bound
>diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
>index 692f4053f08b..c2c10bbe24d6 100644
>--- a/drivers/thermal/fair_share.c
>+++ b/drivers/thermal/fair_share.c
>@@ -59,13 +59,13 @@ static int get_trip_level(struct thermal_zone_device *tz)
> }
>
> static long get_target_state(struct thermal_zone_device *tz,
>-		struct thermal_cooling_device *cdev, int weight, int level)
>+		struct thermal_cooling_device *cdev, int percentage, int level)
> {
> 	unsigned long max_state;
>
> 	cdev->ops->get_max_state(cdev, &max_state);
>
>-	return (long)(weight * level * max_state) / (100 * tz->trips);
>+	return (long)(percentage * level * max_state) / (100 * tz->trips);
> }
>
> /**
>@@ -77,7 +77,7 @@ static long get_target_state(struct thermal_zone_device *tz,
>  *
>  * Parameters used for Throttling:
>  * P1. max_state: Maximum throttle state exposed by the cooling device.
>- * P2. weight[i]/100:
>+ * P2. percentage[i]/100:
>  *	How 'effective' the 'i'th device is, in cooling the given zone.
>  * P3. cur_trip_level/max_no_of_trips:
>  *	This describes the extent to which the devices should be throttled.
>@@ -89,16 +89,32 @@ static long get_target_state(struct thermal_zone_device *tz,
> static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
> {
> 	struct thermal_instance *instance;
>+	int total_weight = 0;
>+	int total_instance = 0;
> 	int cur_trip_level = get_trip_level(tz);
>
> 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>+		if (instance->trip != trip)
>+			continue;
>+
>+		total_weight += instance->weight;
>+		total_instance++;
>+	}
>+
>+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>+		int percentage;
> 		struct thermal_cooling_device *cdev = instance->cdev;
>
> 		if (instance->trip != trip)
> 			continue;
>
>-		instance->target = get_target_state(tz, cdev,
>-					instance->weight, cur_trip_level);
>+		if (!total_weight)
>+			percentage = 100 / total_instance;
>+		else
>+			percentage = (instance->weight * 100) / total_weight;
>+
>+		instance->target = get_target_state(tz, cdev, percentage,
>+						    cur_trip_level);
>
> 		instance->cdev->updated = false;
> 		thermal_cdev_update(cdev);
>diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>index 2ed7062fac1d..89873f93b40d 100644
>--- a/include/linux/thermal.h
>+++ b/include/linux/thermal.h
>@@ -217,9 +217,12 @@ struct thermal_bind_params {
>
> 	/*
> 	 * This is a measure of 'how effectively these devices can
>-	 * cool 'this' thermal zone. The shall be determined by platform
>-	 * characterization. This is on a 'percentage' scale.
>-	 * See Documentation/thermal/sysfs-api.txt for more information.
>+	 * cool 'this' thermal zone. It shall be determined by
>+	 * platform characterization. This value is relative to the
>+	 * rest of the weights so a cooling device whose weight is
>+	 * double that of another cooling device is twice as
>+	 * effective. See Documentation/thermal/sysfs-api.txt for more
>+	 * information.
> 	 */
> 	int weight;
>
>--
>1.9.1


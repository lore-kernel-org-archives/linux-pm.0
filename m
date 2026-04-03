Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41673A256A;
	Fri,  3 Apr 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220745; cv=none; b=qapMbjyOmFhgg/c1lLOdiHvNN0Z/UuXvFM2YSEaE/6N8P0/r9LFHgrEjtIeX9tdFBtOcRC6O3Cdr+pPerQ1n9eqtNZXY8vCQ8vLtCxQswadw3eDEFBYpHtYZhmdqSH+hYhVyVSCGsH7Aoh3WvnPAQfFmB+qmg8dL5ChSvbtpJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220745; c=relaxed/simple;
	bh=Up0jZCJeG3hwXidaLTOamnGYMfTwe/mm7LHPu2MIQ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/+Kzsb8bd9HPZTqFy8Zax6E2ijOoRVHkiFjDkp5ylZ1wKLvFUs4j6w4cwjalkPg2Y3EFjhJ5mX70ZURe3JHk1GkcP5vn3wDnUUrBvmEiMqje/dKgeJDQYLxe2mqI9vdySdLfxLmoeBbmuFF4z1kY883JmaZlWO4ToxqY/YC5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eePxchZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eePxchZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FDC4CEF7;
	Fri,  3 Apr 2026 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775220744;
	bh=Up0jZCJeG3hwXidaLTOamnGYMfTwe/mm7LHPu2MIQ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eePxchZW0vDZRbLModjZuL2511ttvzsUawkrtvZ6+BZVsDwGxjjK1hF41Q4rvBINx
	 8Vpc4xXY9m/7oiqkiNRklDUZvWnqVtHqbo+iN+Z+FGGqh2/8SuUhtg4aOpW2I4KxJD
	 wJxeEilJCJjvDwwVPfegL/XmLqehfkuG7cKxI4yygIVbsi91bFyga+pQ/Iz2H3W2Fx
	 vu0wwt2TxqSs2sihe74OmLdX0XKI6cVV7I8V7IoooOkIPJF0n15O1vU3K6sBBbc23n
	 +Qt0/WflfKycA6Q2bQyNqW2r5ADtwy2mPttxhNuE55KwN+8G7kW/HY6hevmlXLjchA
	 jdeMVwE6iv8Hg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <w_armin@gmx.de>, Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org
Subject:
 Re: [PATCH RESEND v1] thermal: core: fix blocking in unregistering zone
Date: Fri, 03 Apr 2026 14:52:20 +0200
Message-ID: <2432224.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <20260402022742.17738-1-liujiajia@kylinos.cn>
References: <20260402022742.17738-1-liujiajia@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Thursday, April 2, 2026 4:27:42 AM CEST Jiajia Liu wrote:
> When hwmon->tz_list has more than one member,
> thermal_remove_hwmon_sysfs does not unregister hwmon->device.
> Unregistering the zone which is parent of hwmon->device blocks
> at wait_for_completion(&tz->removal). Add check and move hwmon
> to other zone in thermal_remove_hwmon_sysfs.
> 
> One method of reproducing hung task is to unbind the first
> acpitz zone on systems with two acpitz zones.
> 
>  $ cd /sys/bus/platform/drivers/acpi-thermal/
>  $ ls
>  bind  LNXTHERM:00  LNXTHERM:01  uevent  unbind
>  $ echo 'LNXTHERM:00' | sudo tee unbind > /dev/null

Right, this is a problem.

However, it is more of a design issue IMV because putting temperature
attributes for all of the (possibly unrelated) thermal zones of the
same type under one hwmon interface is not particularly useful (for
example, if there are more then one of them, it is not particularly
straightforward to find the thermal zone corresponding to a given
hwmon attribute and vice versa).  Also it is asking for trouble
as demonstrated by the above.

> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>  drivers/thermal/thermal_hwmon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index b624892bc6d6..43cde079fef0 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -242,6 +242,15 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  	list_del(&temp->hwmon_node);
>  	kfree(temp);
>  	if (!list_empty(&hwmon->tz_list)) {
> +		if (hwmon->device->parent == &tz->device) {
> +			struct thermal_hwmon_temp *first;
> +
> +			first = list_first_entry(&hwmon->tz_list,
> +						 struct thermal_hwmon_temp,
> +						 hwmon_node);
> +			device_move(hwmon->device, &first->tz->device,
> +				    DPM_ORDER_DEV_AFTER_PARENT);
> +		}

This may just confuse user space if it started to use the hwmon
interface already.

>  		mutex_unlock(&thermal_hwmon_list_lock);
>  		return;
>  	}
> 

So I'm wondering if something like the patch below can be done instead.

It will basically cause every thermal zone to get its own hwmon interface
regardless of the type.

It appears to work for me, but I'm not sure if having multiple hwmon class
devices with the same value in the name attribute is fine.

---
 drivers/thermal/thermal_hwmon.c |  109 ++++++++--------------------------------
 1 file changed, 24 insertions(+), 85 deletions(-)

--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -19,19 +19,8 @@
 #include "thermal_hwmon.h"
 #include "thermal_core.h"
 
-/* hwmon sys I/F */
-/* thermal zone devices with the same type share one hwmon device */
-struct thermal_hwmon_device {
-	char type[THERMAL_NAME_LENGTH];
-	struct device *device;
-	int count;
-	struct list_head tz_list;
-	struct list_head node;
-};
-
 struct thermal_hwmon_attr {
 	struct device_attribute attr;
-	char name[16];
 };
 
 /* one temperature input for each thermal zone */
@@ -42,6 +31,15 @@ struct thermal_hwmon_temp {
 	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
 };
 
+/* hwmon sys I/F */
+/* thermal zone devices with the same type share one hwmon device */
+struct thermal_hwmon_device {
+	char type[THERMAL_NAME_LENGTH];
+	struct device *device;
+	struct list_head node;
+	struct thermal_hwmon_temp tz_temp;
+};
+
 static LIST_HEAD(thermal_hwmon_list);
 
 static DEFINE_MUTEX(thermal_hwmon_list_lock);
@@ -87,41 +85,17 @@ temp_crit_show(struct device *dev, struc
 	return sysfs_emit(buf, "%d\n", temperature);
 }
 
-
 static struct thermal_hwmon_device *
-thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
+thermal_hwmon_lookup(const struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
-	char type[THERMAL_NAME_LENGTH];
 
-	mutex_lock(&thermal_hwmon_list_lock);
+	guard(mutex)(&thermal_hwmon_list_lock);
+
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
-		strscpy(type, tz->type);
-		strreplace(type, '-', '_');
-		if (!strcmp(hwmon->type, type)) {
-			mutex_unlock(&thermal_hwmon_list_lock);
+		if (hwmon->tz_temp.tz == tz)
 			return hwmon;
-		}
 	}
-	mutex_unlock(&thermal_hwmon_list_lock);
-
-	return NULL;
-}
-
-/* Find the temperature input matching a given thermal zone */
-static struct thermal_hwmon_temp *
-thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
-			  const struct thermal_zone_device *tz)
-{
-	struct thermal_hwmon_temp *temp;
-
-	mutex_lock(&thermal_hwmon_list_lock);
-	list_for_each_entry(temp, &hwmon->tz_list, hwmon_node)
-		if (temp->tz == tz) {
-			mutex_unlock(&thermal_hwmon_list_lock);
-			return temp;
-		}
-	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return NULL;
 }
@@ -136,20 +110,15 @@ int thermal_add_hwmon_sysfs(struct therm
 {
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_temp *temp;
-	int new_hwmon_device = 1;
 	int result;
 
-	hwmon = thermal_hwmon_lookup_by_type(tz);
-	if (hwmon) {
-		new_hwmon_device = 0;
-		goto register_sys_interface;
-	}
+	if (thermal_hwmon_lookup(tz))
+		return -EEXIST;
 
 	hwmon = kzalloc_obj(*hwmon);
 	if (!hwmon)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&hwmon->tz_list);
 	strscpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
 	strreplace(hwmon->type, '-', '_');
 	hwmon->device = hwmon_device_register_for_thermal(&tz->device,
@@ -159,31 +128,20 @@ int thermal_add_hwmon_sysfs(struct therm
 		goto free_mem;
 	}
 
- register_sys_interface:
-	temp = kzalloc_obj(*temp);
-	if (!temp) {
-		result = -ENOMEM;
-		goto unregister_name;
-	}
+	temp = &hwmon->tz_temp;
 
 	temp->tz = tz;
-	hwmon->count++;
 
-	snprintf(temp->temp_input.name, sizeof(temp->temp_input.name),
-		 "temp%d_input", hwmon->count);
-	temp->temp_input.attr.attr.name = temp->temp_input.name;
+	temp->temp_input.attr.attr.name = "temp1_input";
 	temp->temp_input.attr.attr.mode = 0444;
 	temp->temp_input.attr.show = temp_input_show;
 	sysfs_attr_init(&temp->temp_input.attr.attr);
 	result = device_create_file(hwmon->device, &temp->temp_input.attr);
 	if (result)
-		goto free_temp_mem;
+		goto unregister_name;
 
 	if (thermal_zone_crit_temp_valid(tz)) {
-		snprintf(temp->temp_crit.name,
-				sizeof(temp->temp_crit.name),
-				"temp%d_crit", hwmon->count);
-		temp->temp_crit.attr.attr.name = temp->temp_crit.name;
+		temp->temp_crit.attr.attr.name = "temp1_crit";
 		temp->temp_crit.attr.attr.mode = 0444;
 		temp->temp_crit.attr.show = temp_crit_show;
 		sysfs_attr_init(&temp->temp_crit.attr.attr);
@@ -194,20 +152,15 @@ int thermal_add_hwmon_sysfs(struct therm
 	}
 
 	mutex_lock(&thermal_hwmon_list_lock);
-	if (new_hwmon_device)
-		list_add_tail(&hwmon->node, &thermal_hwmon_list);
-	list_add_tail(&temp->hwmon_node, &hwmon->tz_list);
+	list_add_tail(&hwmon->node, &thermal_hwmon_list);
 	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return 0;
 
  unregister_input:
 	device_remove_file(hwmon->device, &temp->temp_input.attr);
- free_temp_mem:
-	kfree(temp);
  unregister_name:
-	if (new_hwmon_device)
-		hwmon_device_unregister(hwmon->device);
+	hwmon_device_unregister(hwmon->device);
  free_mem:
 	kfree(hwmon);
 
@@ -220,31 +173,17 @@ void thermal_remove_hwmon_sysfs(struct t
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_temp *temp;
 
-	hwmon = thermal_hwmon_lookup_by_type(tz);
-	if (unlikely(!hwmon)) {
-		/* Should never happen... */
-		dev_dbg(&tz->device, "hwmon device lookup failed!\n");
+	hwmon = thermal_hwmon_lookup(tz);
+	if (!hwmon)
 		return;
-	}
 
-	temp = thermal_hwmon_lookup_temp(hwmon, tz);
-	if (unlikely(!temp)) {
-		/* Should never happen... */
-		dev_dbg(&tz->device, "temperature input lookup failed!\n");
-		return;
-	}
+	temp = &hwmon->tz_temp;
 
 	device_remove_file(hwmon->device, &temp->temp_input.attr);
 	if (thermal_zone_crit_temp_valid(tz))
 		device_remove_file(hwmon->device, &temp->temp_crit.attr);
 
 	mutex_lock(&thermal_hwmon_list_lock);
-	list_del(&temp->hwmon_node);
-	kfree(temp);
-	if (!list_empty(&hwmon->tz_list)) {
-		mutex_unlock(&thermal_hwmon_list_lock);
-		return;
-	}
 	list_del(&hwmon->node);
 	mutex_unlock(&thermal_hwmon_list_lock);
 




Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5D41D4F4;
	Tue,  4 Aug 2026 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874322; cv=none; b=KzPNuPDNQfKwPYjoMWM9eo2oUnjnkVLrnY7NlxmtxT+4qqRog6hb6riRKg1iR4el7NdLwHnPOHLRmPBjTdisS1ssZ7Nn+xoi+tABckCEKEQAiulVY+o7GRmJjkkgrVA1OMBVpT4lLcMDrCf86bJfzxW/Q+o2Chbl/X+33DIhKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874322; c=relaxed/simple;
	bh=MXGzPtety15k3dMWTNKBmCDuKtvbBkjKzdecMJ6Q+9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boBku7fXTECmI0MKhbnwDxcurKuSQbGgzfDXpnypTrTEZUFBWHAXRKpbsy3HnKDt4JkhQVxYzl4eZBQTnT7RnMFEhwAPmsCmnYUKkTzaXTwg1bnCFqJRW/TpF9ClPOOLjIZzJpvQPeW0oeQrESOIEv27TO3ErYizlrvZDKaFq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrqDDxkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrqDDxkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6B41F00A3A;
	Tue,  4 Aug 2026 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785874320;
	bh=XwuMDdv982+Ac8o3+cdUuXEVdESLG4TC3hCxN4IvICw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrqDDxkBWsfe4xzLyWtIOOq8mDTZTKUXkW4LJglxg/LoWtWF5nDqQ6Ub408iRzYx1
	 ciS8hTXkmgbAW1prPjFS6rNuzHI05ZgRzB5hmLba/q/jvzIdGJzjECzSHNtNCEO/wX
	 vPhyOde8PuTKthEHmRZq8kWCOGphU0z+4w2/pCk65AyyjkjsGKznvM0j+yF4ZEVa8W
	 oJK4a74WJPcX0RKxyj9T2mCiK+eqEwb7CfUWk/jESj35pMXHAS9Ksoen+IxTXN0QJU
	 gt9CW8aVN6Bhv4wAScozcNFvwI2dZRmDzZtH6seMLF1rNnYQcXxeaZleV+n20nV5lk
	 QkXgt/0TbrnYQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject:
 [PATCH v2 2/2] thermal: hwmon: Remove hwmon class device along with its
 parent
Date: Tue, 04 Aug 2026 22:11:27 +0200
Message-ID: <5094738.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12947893.O9o76ZdvQC@rafael.j.wysocki>
References: <12947893.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code creates one hwmon device per thermal zone type and that
device is registered under the first thermal zone of the given type.

That turns out to be problematic when the thermal zone holding the
hwmon device is removed.

For example, say that there are two ACPI thermal zones on a system

 /sys/devices/virtual/thermal/thermal_zone0/
 /sys/devices/virtual/thermal/thermal_zone1/

The current code registers a hwmon class device for thermal_zone0 only:

 /sys/devices/virtual/thermal/thermal_zone0/hwmon0/

because the type is "acpitz" for both of them, but it adds a sysfs
attribute that belongs to thermal_zone1 under it:

 /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp2_input

There is also

 /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp1_input

which belongs to thermal_zone0.

When thermal_zone0 is removed, say because the ACPI thermal driver is
unbound from the underlying platform device, thermal_remove_hwmon_sysfs()
skips the removal of hwmon0 because of the temp2_input attribute
belonging to thermal_zone1 which effectively prevents thermal_zone0
removal from making progress.

Address this by making thermal_remove_hwmon_sysfs() remove the entire
hwmon class device interface for the given thermal zone type when the
thermal zone device holding it is removed.

To prevent races with thermal_add_hwmon_sysfs() that may interfere
with this, carry out the entire addition and removal of hwmon sysfs
interfaces for thermal zones under thermal_hwmon_list_lock.

Also adjust the layout of the labels in thermal_add_hwmon_sysfs() to
the current kernel coding style to align with the new "unlock" label.

Link: https://lore.kernel.org/linux-pm/20260402021828.16556-1-liujia6264@gmail.com/
Fixes: f6b6b52ef7a5 ("thermal_hwmon: Pass the originating device down to hwmon_device_register_with_info")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase on top of the new [1/2]

---
 drivers/thermal/thermal_hwmon.c |   89 +++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 54 deletions(-)

--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -95,34 +95,12 @@ thermal_hwmon_lookup_by_type(const struc
 	struct thermal_hwmon_device *hwmon;
 	char type[THERMAL_NAME_LENGTH];
 
-	mutex_lock(&thermal_hwmon_list_lock);
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
 		strscpy(type, tz->type);
 		strreplace(type, '-', '_');
-		if (!strcmp(hwmon->type, type)) {
-			mutex_unlock(&thermal_hwmon_list_lock);
+		if (!strcmp(hwmon->type, type))
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
@@ -138,7 +116,9 @@ int thermal_add_hwmon_sysfs(struct therm
 	struct thermal_hwmon_device *hwmon;
 	struct thermal_hwmon_temp *temp;
 	int new_hwmon_device = 1;
-	int result;
+	int result = 0;
+
+	mutex_lock(&thermal_hwmon_list_lock);
 
 	hwmon = thermal_hwmon_lookup_by_type(tz);
 	if (hwmon) {
@@ -147,8 +127,10 @@ int thermal_add_hwmon_sysfs(struct therm
 	}
 
 	hwmon = kzalloc_obj(*hwmon);
-	if (!hwmon)
-		return -ENOMEM;
+	if (!hwmon) {
+		result = -ENOMEM;
+		goto unlock;
+	}
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strscpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
@@ -196,24 +178,24 @@ int thermal_add_hwmon_sysfs(struct therm
 		temp->temp_crit_present = true;
 	}
 
-	mutex_lock(&thermal_hwmon_list_lock);
 	if (new_hwmon_device)
 		list_add_tail(&hwmon->node, &thermal_hwmon_list);
 	list_add_tail(&temp->hwmon_node, &hwmon->tz_list);
-	mutex_unlock(&thermal_hwmon_list_lock);
 
-	return 0;
+	goto unlock;
 
- unregister_input:
+unregister_input:
 	device_remove_file(hwmon->device, &temp->temp_input.attr);
- free_temp_mem:
+free_temp_mem:
 	kfree(temp);
- unregister_name:
+unregister_name:
 	if (new_hwmon_device)
 		hwmon_device_unregister(hwmon->device);
- free_mem:
+free_mem:
 	if (new_hwmon_device)
 		kfree(hwmon);
+unlock:
+	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return result;
 }
@@ -222,8 +204,11 @@ EXPORT_SYMBOL_GPL(thermal_add_hwmon_sysf
 
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
+	struct thermal_hwmon_temp *temp, *entry;
 	struct thermal_hwmon_device *hwmon;
-	struct thermal_hwmon_temp *temp;
+	bool unregister;
+
+	guard(mutex)(&thermal_hwmon_list_lock);
 
 	hwmon = thermal_hwmon_lookup_by_type(tz);
 	if (unlikely(!hwmon)) {
@@ -232,29 +217,25 @@ void thermal_remove_hwmon_sysfs(struct t
 		return;
 	}
 
-	temp = thermal_hwmon_lookup_temp(hwmon, tz);
-	if (unlikely(!temp)) {
-		/* Should never happen... */
-		dev_dbg(&tz->device, "temperature input lookup failed!\n");
-		return;
-	}
+	unregister = hwmon->device->parent == &tz->device;
 
-	device_remove_file(hwmon->device, &temp->temp_input.attr);
-	if (temp->temp_crit_present)
-		device_remove_file(hwmon->device, &temp->temp_crit.attr);
+	list_for_each_entry_safe_reverse(temp, entry, &hwmon->tz_list, hwmon_node) {
+		if (!unregister && temp->tz != tz)
+			continue;
 
-	mutex_lock(&thermal_hwmon_list_lock);
-	list_del(&temp->hwmon_node);
-	kfree(temp);
-	if (!list_empty(&hwmon->tz_list)) {
-		mutex_unlock(&thermal_hwmon_list_lock);
-		return;
+		device_remove_file(hwmon->device, &temp->temp_input.attr);
+		if (temp->temp_crit_present)
+			device_remove_file(hwmon->device, &temp->temp_crit.attr);
+
+		list_del(&temp->hwmon_node);
+		kfree(temp);
 	}
-	list_del(&hwmon->node);
-	mutex_unlock(&thermal_hwmon_list_lock);
 
-	hwmon_device_unregister(hwmon->device);
-	kfree(hwmon);
+	if (unregister) {
+		list_del(&hwmon->node);
+		hwmon_device_unregister(hwmon->device);
+		kfree(hwmon);
+	}
 }
 EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
 




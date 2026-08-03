Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAB4322E7;
	Mon,  3 Aug 2026 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781840; cv=none; b=uE/EAHlrY4iya7TqN0HjPyeNPKJyMdrErf2VFJ6SMTrwD0AtPuBlHH3uQ6+PS0qra6YTvaFV+5llx/0gFLLbNPv0zIKLFycDwAsDOyk8IAlA9em0HmxZrkQBQo0f9Q/9UgGFNx6OOU9DwO+3vhlNTWmccpYN80h7fMt+SNhSq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781840; c=relaxed/simple;
	bh=ejEdjXspy82ihy2AK7N+jLI6ApjVzmHZFhx2yQ61Kgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMC3p73kdq4TtszTnqUcDSdazyPFLhEc09xmoqQGFmD9p05XMkqzXxTmbBG4QxxChcltYmJVHp1ilyD1gutB1zMJjUkbTNOg8k7e8pe6hMOr8A5+pgrTQrB46t38tPfILNqqn9tMiNNmTnZfNkRWNj9lPv/564YhiaVtSiuwEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8WJY3V9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8WJY3V9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593E21F000E9;
	Mon,  3 Aug 2026 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781839;
	bh=NKEAhHR1vkSxFrjzZS7Nbn6XxygKfJDdleDZqxswBJ0=;
	h=From:To:Cc:Subject:Date;
	b=Q8WJY3V9+O4jW/BObtYLLb3aoAU9FvabYgDGkv2n64lhawXS1LMPDAO/ZRiWVU82a
	 3/8AmXaDB49D9xXqYNS/k5U83jB1vgv8+R7qBi4R5CkQAFtxT9VxCw1a7N3zonXTsX
	 jRQ5d4Q0p59RIHo/455tQ0yYYBOuSga8u1P+Q8++TFleiQJpcxJSFVBLE+0FtNh/es
	 C09f/8agzciBhjGAAiBETxsas97hmKSCwOoBWInzCqTPRCCCSxug7tLPnfDc5HyDcS
	 Ll/Nk3hztN75EAbjkq8kdF4j2Ali0HWaYuDQzZfZdNIYOaqUPMAFkj2hbELhW+jyVo
	 YO53tQtNu9eoQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject:
 [PATCH v1] thermal: hwmon: Remove hwmon class device along with its parent
Date: Mon, 03 Aug 2026 20:30:35 +0200
Message-ID: <23195575.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
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

Applies on top of the reverts at

https://lore.kernel.org/linux-pm/6319276.lOV4Wx5bFT@rafael.j.wysocki/

I'd like to make this change in 7.3.

Given the user space sensitivity to hwmon-related changes in the kernel,
there's not much more that can be done to address the problem in the short
term AFAICS.

---
 drivers/thermal/thermal_hwmon.c |   87 +++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 53 deletions(-)

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
@@ -196,23 +178,23 @@ int thermal_add_hwmon_sysfs(struct therm
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
 	kfree(hwmon);
+unlock:
+	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return result;
 }
@@ -220,8 +202,11 @@ EXPORT_SYMBOL_GPL(thermal_add_hwmon_sysf
 
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
@@ -230,29 +215,25 @@ void thermal_remove_hwmon_sysfs(struct t
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
 




Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8E395D8C;
	Tue,  5 May 2026 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981635; cv=none; b=R7FDQAqGaDX9LemqaWZrvmxux//phBwjzMVjpbU2R60OAo8mQwilNeVtMfcpEftjoJxjxL8zCMfxp5Dm9Joak/YVJjQHdVWgoBbW1I+JC7N7Kw3O3nTSHjfiUwv8JAWPw86p7+jSdMC2pt9L+53eZKhGh99IqeL85lVHii8L7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981635; c=relaxed/simple;
	bh=h1noATD0rAmANdV1ooDO4BcdM9R1dSu8eOkWjuaPq18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcPC5WzQU0ibYSFJOaKr6j1E2HlxNwt7SvFC/Wbn6yR26JT1+lm2fc3czwC1+gJbYK1O1lYIlG5UgVoq40TA82Ec0erSXTcHC9bU8c/2Wm4LgEj7KGaNCyn/nc4NH45OEN/8tCUbkK8I+IQNqRhkx2SUz+ioWc/8Y25x1pCVlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUk3P0/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUk3P0/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA51C2BCB4;
	Tue,  5 May 2026 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981635;
	bh=h1noATD0rAmANdV1ooDO4BcdM9R1dSu8eOkWjuaPq18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUk3P0/+LRl+AHDvMTCcFJy5fMPkn007b39v4pFYWiTiBhWoLY0mTbUk+DDy97zRO
	 R0c7qCtRX0f6eA7z05dJ0CuLQS3LqoG14u5O9qoTSiM/TU3dMnNgotr8SHM+YvaHg4
	 6eDz+xCWtNaahbPlb3NXdu0IKAuBCXH3ltSWqzf6Fy2Xn2AtHMG5y/jbNNk5OSdNVY
	 eTMM0HdpmWATzXix7uUKJ9iJo9M7TmI74VL3EENh5k/fhUF+ArDCs865PDXv7+sJzg
	 nE75ekNkomtiD/+u5DNuYWJnY6yW1gFxM9KZTH5xh/0mGMXXC9+cZqzl90e0dXVwvC
	 UTjFNE/yjic7g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>, Jiajia Liu <liujiajia@kylinos.cn>,
 Marc Zyngier <maz@kernel.org>, linux-hwmon@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Subject:
 [PATCH v2 3/3] thermal: hwmon: Use extra_groups for adding temperature
 attributes
Date: Tue, 05 May 2026 13:47:01 +0200
Message-ID: <8704209.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6017595.DvuYhMxLoT@rafael.j.wysocki>
References: <6017595.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of passing NULL as the last argument to __hwmon_device_register()
in hwmon_device_register_for_thermal() and then adding each temperature
sysfs attribute to the hwmon device via device_create_file(), redefine
hwmon_device_register_for_thermal() to take an extra_groups argument
that will be passed to __hwmon_device_register(), define an attribute
group with a proper .is_visible() callback for the temperature
attributes and a related attribute groups pointer, and pass the latter
to hwmon_device_register_for_thermal().

This causes the code to be way more straightforward and closer to
what the other users of the hwmon subsystem do.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase on top of [1-2/3]
   * Drop struct thermal_hwmon_temp (sashiko.dev)
   * 

---
 drivers/hwmon/hwmon.c           |    6 +
 drivers/thermal/thermal_hwmon.c |  122 ++++++++++++++--------------------------
 include/linux/hwmon.h           |    3 
 3 files changed, 51 insertions(+), 80 deletions(-)

--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -1082,6 +1082,7 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_
  * @dev: the parent device
  * @name: hwmon name attribute
  * @drvdata: driver data to attach to created device
+ * @extra_groups: pointer to list of additional non-standard attribute groups
  *
  * The use of this function is restricted. It is provided for legacy reasons
  * and must only be called from the thermal subsystem.
@@ -1093,12 +1094,13 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_
  */
 struct device *
 hwmon_device_register_for_thermal(struct device *dev, const char *name,
-				  void *drvdata)
+				  void *drvdata,
+				  const struct attribute_group **extra_groups)
 {
 	if (!name || !dev)
 		return ERR_PTR(-EINVAL);
 
-	return __hwmon_device_register(dev, name, drvdata, NULL, NULL);
+	return __hwmon_device_register(dev, name, drvdata, NULL, extra_groups);
 }
 EXPORT_SYMBOL_NS_GPL(hwmon_device_register_for_thermal, "HWMON_THERMAL");
 
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -25,25 +25,13 @@
  */
 #define THERMAL_HWMON_NAME_LENGTH (THERMAL_NAME_LENGTH + 11)
 
-struct thermal_hwmon_attr {
-	struct device_attribute attr;
-};
-
-/* one temperature input for each thermal zone */
-struct thermal_hwmon_temp {
-	struct thermal_zone_device *tz;
-	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
-	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
-	bool temp_crit_present;
-};
-
 /* hwmon sys I/F */
 /* thermal zone devices with the same type share one hwmon device */
 struct thermal_hwmon_device {
 	char name[THERMAL_HWMON_NAME_LENGTH];
 	struct device *device;
 	struct list_head node;
-	struct thermal_hwmon_temp tz_temp;
+	struct thermal_zone_device *tz;
 };
 
 static LIST_HEAD(thermal_hwmon_list);
@@ -51,19 +39,14 @@ static LIST_HEAD(thermal_hwmon_list);
 static DEFINE_MUTEX(thermal_hwmon_list_lock);
 
 static ssize_t
-temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
+temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
+	struct thermal_zone_device *tz = hwmon->tz;
 	int temperature;
 	int ret;
-	struct thermal_hwmon_attr *hwmon_attr
-			= container_of(attr, struct thermal_hwmon_attr, attr);
-	struct thermal_hwmon_temp *temp
-			= container_of(hwmon_attr, struct thermal_hwmon_temp,
-				       temp_input);
-	struct thermal_zone_device *tz = temp->tz;
 
 	ret = thermal_zone_get_temp(tz, &temperature);
-
 	if (ret)
 		return ret;
 
@@ -71,14 +54,10 @@ temp_input_show(struct device *dev, stru
 }
 
 static ssize_t
-temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
+temp1_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct thermal_hwmon_attr *hwmon_attr
-			= container_of(attr, struct thermal_hwmon_attr, attr);
-	struct thermal_hwmon_temp *temp
-			= container_of(hwmon_attr, struct thermal_hwmon_temp,
-				       temp_crit);
-	struct thermal_zone_device *tz = temp->tz;
+	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
+	struct thermal_zone_device *tz = hwmon->tz;
 	int temperature;
 	int ret;
 
@@ -91,22 +70,49 @@ temp_crit_show(struct device *dev, struc
 	return sysfs_emit(buf, "%d\n", temperature);
 }
 
-static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *tz)
+static DEVICE_ATTR_RO(temp1_input);
+static DEVICE_ATTR_RO(temp1_crit);
+
+static struct attribute *thermal_hwmon_attrs[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_crit.attr,
+	NULL,
+};
+
+static umode_t thermal_hwmon_attr_is_visible(struct kobject *kobj,
+					     struct attribute *a, int n)
 {
-	int temp;
-	return tz->ops.get_crit_temp && !tz->ops.get_crit_temp(tz, &temp);
+	if (a == &dev_attr_temp1_input.attr)
+		return a->mode;
+
+	if (a == &dev_attr_temp1_crit.attr) {
+		struct thermal_hwmon_device *hwmon = dev_get_drvdata(kobj_to_dev(kobj));
+		struct thermal_zone_device *tz = hwmon->tz;
+		int dummy;
+
+		if (tz->ops.get_crit_temp && !tz->ops.get_crit_temp(tz, &dummy))
+			return a->mode;
+	}
+
+	return 0;
 }
 
+static const struct attribute_group thermal_hwmon_group = {
+	.attrs	= thermal_hwmon_attrs,
+	.is_visible = thermal_hwmon_attr_is_visible,
+};
+
+__ATTRIBUTE_GROUPS(thermal_hwmon);
+
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
-	struct thermal_hwmon_temp *temp;
-	int result;
 
 	hwmon = kzalloc_obj(*hwmon);
 	if (!hwmon)
 		return -ENOMEM;
 
+	hwmon->tz = tz;
 	/*
 	 * Append the thermal zone ID preceded by an underline character to the
 	 * type to disambiguate the sensors command output.
@@ -114,35 +120,13 @@ int thermal_add_hwmon_sysfs(struct therm
 	scnprintf(hwmon->name, THERMAL_HWMON_NAME_LENGTH, "%s_%d", tz->type, tz->id);
 	strreplace(hwmon->name, '-', '_');
 	hwmon->device = hwmon_device_register_for_thermal(&tz->device,
-							  hwmon->name, hwmon);
+							  hwmon->name, hwmon,
+							  thermal_hwmon_groups);
 	if (IS_ERR(hwmon->device)) {
-		result = PTR_ERR(hwmon->device);
-		goto free_mem;
-	}
-
-	temp = &hwmon->tz_temp;
-
-	temp->tz = tz;
+		int result = PTR_ERR(hwmon->device);
 
-	temp->temp_input.attr.attr.name = "temp1_input";
-	temp->temp_input.attr.attr.mode = 0444;
-	temp->temp_input.attr.show = temp_input_show;
-	sysfs_attr_init(&temp->temp_input.attr.attr);
-	result = device_create_file(hwmon->device, &temp->temp_input.attr);
-	if (result)
-		goto unregister_name;
-
-	if (thermal_zone_crit_temp_valid(tz)) {
-		temp->temp_crit.attr.attr.name = "temp1_crit";
-		temp->temp_crit.attr.attr.mode = 0444;
-		temp->temp_crit.attr.show = temp_crit_show;
-		sysfs_attr_init(&temp->temp_crit.attr.attr);
-		result = device_create_file(hwmon->device,
-					    &temp->temp_crit.attr);
-		if (result)
-			goto unregister_input;
-
-		temp->temp_crit_present = true;
+		kfree(hwmon);
+		return result;
 	}
 
 	/* The list is needed for hwmon lookup during removal. */
@@ -151,15 +135,6 @@ int thermal_add_hwmon_sysfs(struct therm
 	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return 0;
-
- unregister_input:
-	device_remove_file(hwmon->device, &temp->temp_input.attr);
- unregister_name:
-	hwmon_device_unregister(hwmon->device);
- free_mem:
-	kfree(hwmon);
-
-	return result;
 }
 EXPORT_SYMBOL_GPL(thermal_add_hwmon_sysfs);
 
@@ -169,7 +144,7 @@ thermal_hwmon_lookup(const struct therma
 	struct thermal_hwmon_device *hwmon;
 
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
-		if (hwmon->tz_temp.tz == tz)
+		if (hwmon->tz == tz)
 			return hwmon;
 	}
 	return NULL;
@@ -178,7 +153,6 @@ thermal_hwmon_lookup(const struct therma
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
-	struct thermal_hwmon_temp *temp;
 
 	scoped_guard(mutex, &thermal_hwmon_list_lock) {
 		hwmon = thermal_hwmon_lookup(tz);
@@ -188,12 +162,6 @@ void thermal_remove_hwmon_sysfs(struct t
 		list_del(&hwmon->node);
 	}
 
-	temp = &hwmon->tz_temp;
-
-	device_remove_file(hwmon->device, &temp->temp_input.attr);
-	if (temp->temp_crit_present)
-		device_remove_file(hwmon->device, &temp->temp_crit.attr);
-
 	hwmon_device_unregister(hwmon->device);
 	kfree(hwmon);
 }
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -477,7 +477,8 @@ hwmon_device_register_with_info(struct d
 				const struct attribute_group **extra_groups);
 struct device *
 hwmon_device_register_for_thermal(struct device *dev, const char *name,
-				  void *drvdata);
+				  void *drvdata,
+				  const struct attribute_group **extra_groups);
 struct device *
 devm_hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,




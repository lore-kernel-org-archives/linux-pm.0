Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C041A4E5;
	Fri, 31 Jul 2026 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503350; cv=none; b=LNo1UVWh81KgePlfoIAUJgPPpmeKZrUMU11TAHd+CcoH6cM6et5Kex1hQD42IjOXxhiyBaCMufeZXQpeKdIS6WF+ah45OYtwY1XYYVF5y4QBLLpYpTZytlI637b55lB2csjPeTvxBUqefxUDs1OAufoeMi9ysZgbn4mPJMf+C9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503350; c=relaxed/simple;
	bh=LyieVsLtHYHD06iN+yhyItYqmhamyWRzH8FBJVPotwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJvEdHdLzr4RtZnpEh7Ti3LEKCnz/S7U4I5O0iIKpSBtVVkBl6HoYr/H53bOUS8Am1DD9szvM554yJXbkE7k1ezmD/hTrgfe2upGrI9mQVHq4EL7rKu9XycmbWMnSlhTypDJVkKDnBShgtKAoTHShvaRlT+83bzEp05jh671MrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoctMaXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoctMaXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7381F000E9;
	Fri, 31 Jul 2026 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503348;
	bh=zY5zNSkVz2zo7gj1Xc9+ZwhlDuvCE/eHB6M12n1Mq0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LoctMaXnOmE8JM5oJGj5p9CJVNXAmwn1rvdbeI4aPzKsbaiaLdUb72VQULyxHdbrK
	 0K0+fooB2XJBpU5K3KFGbiqeq8bu5PA8dnOwpcP9SqE6nbJoG9p6P3pWChgpBUHl7O
	 5e9DTneFm3Cf9TBvjTjDm8UoEXbj/dU5c2HiMbf+Nh9uiERz1WvJwz3DWlDwtX5aYq
	 36NkaiR3L6KAIbXH1osjMxEjvSrjec4Wu6toruhI9nemyJBj3poM0bq5EZ2askXY/g
	 ZFdYi1pdvWB8tLHWu16X+ZgaK1MhXdR/+sbPQERc+l4R9ymgu5CxXZM0AcBHNaszzS
	 QA867W2KiFSyQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>, Jiajia Liu <liujiajia@kylinos.cn>,
 Marc Zyngier <maz@kernel.org>, linux-hwmon@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject:
 [PATCH v1 1/2] Revert "thermal: hwmon: Use extra_groups for adding
 temperature attributes"
Date: Fri, 31 Jul 2026 15:00:36 +0200
Message-ID: <1992232.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <6319276.lOV4Wx5bFT@rafael.j.wysocki>
References: <6319276.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit cfb5dc0f60fb ("thermal: hwmon: Use extra_groups for adding
temperature attributes") because it is depended on by another one that
turned out to be problematic.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/hwmon.c           |   6 +-
 drivers/thermal/thermal_hwmon.c | 122 ++++++++++++++++++++------------
 include/linux/hwmon.h           |   3 +-
 3 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 55a9a3ddd4aa..29dc90a2c3fe 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -1083,7 +1083,6 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
  * @dev: the parent device
  * @name: hwmon name attribute
  * @drvdata: driver data to attach to created device
- * @extra_groups: pointer to list of additional non-standard attribute groups
  *
  * The use of this function is restricted. It is provided for legacy reasons
  * and must only be called from the thermal subsystem.
@@ -1095,13 +1094,12 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
  */
 struct device *
 hwmon_device_register_for_thermal(struct device *dev, const char *name,
-				  void *drvdata,
-				  const struct attribute_group **extra_groups)
+				  void *drvdata)
 {
 	if (!name || !dev)
 		return ERR_PTR(-EINVAL);
 
-	return __hwmon_device_register(dev, name, drvdata, NULL, extra_groups);
+	return __hwmon_device_register(dev, name, drvdata, NULL, NULL);
 }
 EXPORT_SYMBOL_NS_GPL(hwmon_device_register_for_thermal, "HWMON_THERMAL");
 
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 386dfb9f559e..223ae1571655 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -25,13 +25,25 @@
  */
 #define THERMAL_HWMON_NAME_LENGTH (THERMAL_NAME_LENGTH + 11)
 
+struct thermal_hwmon_attr {
+	struct device_attribute attr;
+};
+
+/* one temperature input for each thermal zone */
+struct thermal_hwmon_temp {
+	struct thermal_zone_device *tz;
+	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
+	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
+	bool temp_crit_present;
+};
+
 /* hwmon sys I/F */
 /* thermal zone devices with the same type share one hwmon device */
 struct thermal_hwmon_device {
 	char name[THERMAL_HWMON_NAME_LENGTH];
 	struct device *device;
 	struct list_head node;
-	struct thermal_zone_device *tz;
+	struct thermal_hwmon_temp tz_temp;
 };
 
 static LIST_HEAD(thermal_hwmon_list);
@@ -39,14 +51,19 @@ static LIST_HEAD(thermal_hwmon_list);
 static DEFINE_MUTEX(thermal_hwmon_list_lock);
 
 static ssize_t
-temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
+temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
-	struct thermal_zone_device *tz = hwmon->tz;
 	int temperature;
 	int ret;
+	struct thermal_hwmon_attr *hwmon_attr
+			= container_of(attr, struct thermal_hwmon_attr, attr);
+	struct thermal_hwmon_temp *temp
+			= container_of(hwmon_attr, struct thermal_hwmon_temp,
+				       temp_input);
+	struct thermal_zone_device *tz = temp->tz;
 
 	ret = thermal_zone_get_temp(tz, &temperature);
+
 	if (ret)
 		return ret;
 
@@ -54,10 +71,14 @@ temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 
 static ssize_t
-temp1_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
+temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
-	struct thermal_zone_device *tz = hwmon->tz;
+	struct thermal_hwmon_attr *hwmon_attr
+			= container_of(attr, struct thermal_hwmon_attr, attr);
+	struct thermal_hwmon_temp *temp
+			= container_of(hwmon_attr, struct thermal_hwmon_temp,
+				       temp_crit);
+	struct thermal_zone_device *tz = temp->tz;
 	int temperature;
 	int ret;
 
@@ -70,49 +91,22 @@ temp1_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	return sysfs_emit(buf, "%d\n", temperature);
 }
 
-static DEVICE_ATTR_RO(temp1_input);
-static DEVICE_ATTR_RO(temp1_crit);
-
-static struct attribute *thermal_hwmon_attrs[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_crit.attr,
-	NULL,
-};
-
-static umode_t thermal_hwmon_attr_is_visible(struct kobject *kobj,
-					     struct attribute *a, int n)
+static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *tz)
 {
-	if (a == &dev_attr_temp1_input.attr)
-		return a->mode;
-
-	if (a == &dev_attr_temp1_crit.attr) {
-		struct thermal_hwmon_device *hwmon = dev_get_drvdata(kobj_to_dev(kobj));
-		struct thermal_zone_device *tz = hwmon->tz;
-		int dummy;
-
-		if (tz->ops.get_crit_temp && !tz->ops.get_crit_temp(tz, &dummy))
-			return a->mode;
-	}
-
-	return 0;
+	int temp;
+	return tz->ops.get_crit_temp && !tz->ops.get_crit_temp(tz, &temp);
 }
 
-static const struct attribute_group thermal_hwmon_group = {
-	.attrs	= thermal_hwmon_attrs,
-	.is_visible = thermal_hwmon_attr_is_visible,
-};
-
-__ATTRIBUTE_GROUPS(thermal_hwmon);
-
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
+	struct thermal_hwmon_temp *temp;
+	int result;
 
 	hwmon = kzalloc_obj(*hwmon);
 	if (!hwmon)
 		return -ENOMEM;
 
-	hwmon->tz = tz;
 	/*
 	 * Append the thermal zone ID preceded by an underline character to the
 	 * type to disambiguate the sensors command output.
@@ -120,13 +114,35 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	scnprintf(hwmon->name, THERMAL_HWMON_NAME_LENGTH, "%s_%d", tz->type, tz->id);
 	strreplace(hwmon->name, '-', '_');
 	hwmon->device = hwmon_device_register_for_thermal(&tz->device,
-							  hwmon->name, hwmon,
-							  thermal_hwmon_groups);
+							  hwmon->name, hwmon);
 	if (IS_ERR(hwmon->device)) {
-		int result = PTR_ERR(hwmon->device);
+		result = PTR_ERR(hwmon->device);
+		goto free_mem;
+	}
 
-		kfree(hwmon);
-		return result;
+	temp = &hwmon->tz_temp;
+
+	temp->tz = tz;
+
+	temp->temp_input.attr.attr.name = "temp1_input";
+	temp->temp_input.attr.attr.mode = 0444;
+	temp->temp_input.attr.show = temp_input_show;
+	sysfs_attr_init(&temp->temp_input.attr.attr);
+	result = device_create_file(hwmon->device, &temp->temp_input.attr);
+	if (result)
+		goto unregister_name;
+
+	if (thermal_zone_crit_temp_valid(tz)) {
+		temp->temp_crit.attr.attr.name = "temp1_crit";
+		temp->temp_crit.attr.attr.mode = 0444;
+		temp->temp_crit.attr.show = temp_crit_show;
+		sysfs_attr_init(&temp->temp_crit.attr.attr);
+		result = device_create_file(hwmon->device,
+					    &temp->temp_crit.attr);
+		if (result)
+			goto unregister_input;
+
+		temp->temp_crit_present = true;
 	}
 
 	/* The list is needed for hwmon lookup during removal. */
@@ -135,6 +151,15 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	mutex_unlock(&thermal_hwmon_list_lock);
 
 	return 0;
+
+ unregister_input:
+	device_remove_file(hwmon->device, &temp->temp_input.attr);
+ unregister_name:
+	hwmon_device_unregister(hwmon->device);
+ free_mem:
+	kfree(hwmon);
+
+	return result;
 }
 EXPORT_SYMBOL_GPL(thermal_add_hwmon_sysfs);
 
@@ -144,7 +169,7 @@ thermal_hwmon_lookup(const struct thermal_zone_device *tz)
 	struct thermal_hwmon_device *hwmon;
 
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
-		if (hwmon->tz == tz)
+		if (hwmon->tz_temp.tz == tz)
 			return hwmon;
 	}
 	return NULL;
@@ -153,6 +178,7 @@ thermal_hwmon_lookup(const struct thermal_zone_device *tz)
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
+	struct thermal_hwmon_temp *temp;
 
 	scoped_guard(mutex, &thermal_hwmon_list_lock) {
 		hwmon = thermal_hwmon_lookup(tz);
@@ -162,6 +188,12 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 		list_del(&hwmon->node);
 	}
 
+	temp = &hwmon->tz_temp;
+
+	device_remove_file(hwmon->device, &temp->temp_input.attr);
+	if (temp->temp_crit_present)
+		device_remove_file(hwmon->device, &temp->temp_crit.attr);
+
 	hwmon_device_unregister(hwmon->device);
 	kfree(hwmon);
 }
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 77a6f2bffcba..dd713e193d0c 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -480,8 +480,7 @@ hwmon_device_register_with_info(struct device *dev,
 				const struct attribute_group **extra_groups);
 struct device *
 hwmon_device_register_for_thermal(struct device *dev, const char *name,
-				  void *drvdata,
-				  const struct attribute_group **extra_groups);
+				  void *drvdata);
 struct device *
 devm_hwmon_device_register_with_info(struct device *dev,
 				const char *name, void *drvdata,
-- 
2.51.0





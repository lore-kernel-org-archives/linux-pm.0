Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBA3F074A;
	Wed, 22 Apr 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884993; cv=none; b=o/5/yplHFj/T45WxlLhtapyJ8XNfCSU0HRAAOZoD1J+4M+YrTwsaZSHEVI6lWi8g0sfz/GQdF/VX/B02bh/zxX7sDhbHG2qG1XOYUcpZIcKzYcYtSr8Ca+N+/llucSEGSEFd0UAjpyqWFzo1rs58/wB6kr6xDec71wV7VFKdZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884993; c=relaxed/simple;
	bh=Cq9ntGuniLpfxw15CP8xJiYmwt7Mrtt3HRmb0vxAfxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUi5Ku5rtta6uSnWt7mL4EgSeq8oonEMJkroD6F+ALktbdcvlggLbGg4TR43YGYPqmMbICa6918Ja5HGnU4/QAhLlL/AJ4MsXz9Fd9oY8kMlgmwrxJma4hmUsYVNyZI9H4Eu4Fqv6LaGEHDQ71DfJRFeQgwCo2nTuGMPTVG9xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcFk5j9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcFk5j9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DB3C19425;
	Wed, 22 Apr 2026 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776884989;
	bh=Cq9ntGuniLpfxw15CP8xJiYmwt7Mrtt3HRmb0vxAfxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcFk5j9i5pPz/F6lIHNNSJIqwTbNKUZc9zUfRMAV1apZRit+QYN0WKr+FpgIrZ1Rd
	 AH7eKpMkWyUAVdzRfIz+0tvcelulxE19DxG4vuU83MlNvi5gnIyFGjsa+Y8sYwX2cA
	 OEjQwfKZBrE4MR9qbLJNYRdiU/LXEkJHGp1Y4uXbD2QZjpQyFH1NCp9BscRKS0iG3V
	 9XulxNrlM2/W84Qg5HJLfq+jfxs6wJYhZE9yJiR2As6zXNapnuK6jvEGpulFlZO5hS
	 AR528ykwd8jj/taje9nLC6NG1XPetesFFeb1Lkeu+1Kr322Bg1dApE926ciQseBmxr
	 HIBGy8M15HZRQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>, Jiajia Liu <liujiajia@kylinos.cn>,
 Marc Zyngier <maz@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject:
 [PATCH v1 2/2] thermal: hwmon: Use extra_groups for adding temperature
 attributes
Date: Wed, 22 Apr 2026 21:09:33 +0200
Message-ID: <2267033.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5100596.31r3eYUQgx@rafael.j.wysocki>
References: <5100596.31r3eYUQgx@rafael.j.wysocki>
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

This causes the code to be way more straightforward and closer to what
the other users of the hwmon subsystem do.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/hwmon.c           |    6 +-
 drivers/thermal/thermal_hwmon.c |  112 ++++++++++++++++------------------------
 include/linux/hwmon.h           |    3 -
 3 files changed, 51 insertions(+), 70 deletions(-)

--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -1081,6 +1081,7 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_
  * @dev: the parent device
  * @name: hwmon name attribute
  * @drvdata: driver data to attach to created device
+ * @extra_groups: pointer to list of additional non-standard attribute groups
  *
  * The use of this function is restricted. It is provided for legacy reasons
  * and must only be called from the thermal subsystem.
@@ -1092,12 +1093,13 @@ EXPORT_SYMBOL_GPL(hwmon_device_register_
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
@@ -19,16 +19,12 @@
 #include "thermal_hwmon.h"
 #include "thermal_core.h"
 
-struct thermal_hwmon_attr {
-	struct device_attribute attr;
-};
-
 /* one temperature input for each thermal zone */
 struct thermal_hwmon_temp {
 	struct list_head hwmon_node;
 	struct thermal_zone_device *tz;
-	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
-	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
+	struct device_attribute temp_input;	/* hwmon sys attr */
+	struct device_attribute temp_crit;	/* hwmon sys attr */
 };
 
 /* hwmon sys I/F */
@@ -45,19 +41,14 @@ static LIST_HEAD(thermal_hwmon_list);
 static DEFINE_MUTEX(thermal_hwmon_list_lock);
 
 static ssize_t
-temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
+temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
+	struct thermal_zone_device *tz = hwmon->tz_temp.tz;
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
 
@@ -65,14 +56,10 @@ temp_input_show(struct device *dev, stru
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
+	struct thermal_zone_device *tz = hwmon->tz_temp.tz;
 	int temperature;
 	int ret;
 
@@ -85,22 +72,49 @@ temp_crit_show(struct device *dev, struc
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
+		struct thermal_zone_device *tz = hwmon->tz_temp.tz;
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
 
+	hwmon->tz_temp.tz = tz;
 	/*
 	 * Append the thermal zone ID preceded by an underline character to the
 	 * type to disambiguate the sensors command output.
@@ -108,33 +122,13 @@ int thermal_add_hwmon_sysfs(struct therm
 	scnprintf(hwmon->type, THERMAL_NAME_LENGTH, "%s_%d", tz->type, tz->id);
 	strreplace(hwmon->type, '-', '_');
 	hwmon->device = hwmon_device_register_for_thermal(&tz->device,
-							  hwmon->type, hwmon);
+							  hwmon->type, hwmon,
+							  thermal_hwmon_groups);
 	if (IS_ERR(hwmon->device)) {
-		result = PTR_ERR(hwmon->device);
-		goto free_mem;
-	}
+		int result = PTR_ERR(hwmon->device);
 
-	temp = &hwmon->tz_temp;
-
-	temp->tz = tz;
-
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
+		kfree(hwmon);
+		return result;
 	}
 
 	/* The list is needed for hwmon lookup during removal. */
@@ -143,15 +137,6 @@ int thermal_add_hwmon_sysfs(struct therm
 	}
 
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
 
@@ -170,7 +155,6 @@ thermal_hwmon_lookup(const struct therma
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
 	struct thermal_hwmon_device *hwmon;
-	struct thermal_hwmon_temp *temp;
 
 	scoped_guard(mutex, &thermal_hwmon_list_lock) {
 		hwmon = thermal_hwmon_lookup(tz);
@@ -180,12 +164,6 @@ void thermal_remove_hwmon_sysfs(struct t
 		list_del(&hwmon->node);
 	}
 
-	temp = &hwmon->tz_temp;
-
-	device_remove_file(hwmon->device, &temp->temp_input.attr);
-	if (thermal_zone_crit_temp_valid(tz))
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




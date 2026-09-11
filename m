Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6F484227;
	Fri, 11 Sep 2026 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132142; cv=none; b=LVK7pWp+FknP9LLdqsCRrqO330fr8xzUm8hbFrcjcC5LMFngsZg84LE16672yLty5KOcbhhWQX6oahpf79xBiiAJUkuZMUhXr3XTf1OpxF6ZKP5c0jY5vYu/Uad22WxAOMrJ7lyHTdRn9twLx132/DQvjF+x534JeOGygvWGuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132142; c=relaxed/simple;
	bh=CsNqL0BuXS2HxAUk3Cdl0ZZH9lyeOc0+/2Zhl8odbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrxOPE4dLg1t3BOW+4aIRTBl88M/Z4/rYXF6QM0iVQm/jDS59iW+PVVbYH7tNsmter1ndqNGmadHQ/zPhkUcMn9rLKD2xEc+f2C8U3OPqhvYyM1WAL/hIas+uloqjj1Qx+i+BG+9leAnj5Clf8Y5V+TyhFqSwwvyW84XCu5AFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJWApZVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJWApZVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055101F000FF;
	Fri, 11 Sep 2026 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132140;
	bh=YQTbKgPMhYDA9tSRj8kGXhhpYzMNoRXjZDmXBCiCu2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OJWApZVffGgIMwtp6NTz0djfT23rcMsKPs9MzqSUEEhWvLeSEWK/yM6bZx6jZyMVL
	 KLyYdUB+ThwdRdomaAc1Jf8hIa21iZw7gxVIxruu2CZyYZfQs8uABXuUD3J6TJJmnh
	 i8aA3/ut9umNL+L2sUsgB/mJpkxtjdFISPt2neccNiXiZho9mvKnaFZJjkGMvrJvIA
	 3FdL+iA08QHV8uRrhbDf9Fbhdu8dPBndPp9XJ9LUjw9qflxPs5CzF11h3JtB+xU8Z9
	 fLzqIGCqgSxKcH8Y+0rVHMWOPbYaVGYF8KoQj6ZD8d3bHpdT/dwlPLYiGzZAP58w4Q
	 n7GnIucTbxUvQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
Date: Fri, 11 Sep 2026 15:02:53 +0200
Message-ID: <2362345.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1965933.tdWV9SEqCh@rafael.j.wysocki>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Instead of using thermal_cooling_device_register() for registering
a cooling device in the ACPI processor driver, make it use
thermal_cooling_device_create() and pass a pointer to the processor
device representing the given CPU to that function as the cooling
device's parent.  That will cause the cooling device's sysfs directory
to be created under the parent's sysfs directory (among other things).

Since creating a class device under a parent causes a "device" symbolic
link from the sysfs directory of the class device to the sysfs directory
of the parent to appear automatically, remove the code creating the
"device" symbolic link from the sysfs directory of the cooling device
in question to the sysfs directory of the parent's companion ACPI
device.  That ACPI device is reachable through the "firmware_node"
symbolic link in the parent's sysfs directory regardless.

Moreover, since the cooling device is now located in sysfs under its
parent and it can be easily identified as a cooling device, there is
no need to create a "thermal_cooling" symbolic link from its parent's
ACPI companion to it.  Accordingly, also remove the code creating that
symbolic link.

While at it, check for error pointer values in addition to checking
for NULL in acpi_processor_thermal_exit() to avoid dereferncing them
mistakenly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_driver.c  |  4 +--
 drivers/acpi/processor_thermal.c | 47 +++++---------------------------
 include/acpi/processor.h         |  3 +-
 3 files changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index cdc2ae1632b2..90c14480393d 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -179,7 +179,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	return 0;
 
 err_thermal_exit:
-	acpi_processor_thermal_exit(pr, device);
+	acpi_processor_thermal_exit(pr);
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
@@ -203,7 +203,7 @@ static int acpi_processor_stop(struct device *dev)
 
 	acpi_cppc_processor_exit(pr);
 
-	acpi_processor_thermal_exit(pr, device);
+	acpi_processor_thermal_exit(pr);
 
 	return 0;
 }
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index c7b1dc5687ec..6cd47551844a 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -311,52 +311,19 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
 int acpi_processor_thermal_init(struct acpi_processor *pr,
 				struct acpi_device *device)
 {
-	int result = 0;
-
-	pr->cdev = thermal_cooling_device_register("Processor", device,
-						   &processor_cooling_ops);
-	if (IS_ERR(pr->cdev)) {
-		result = PTR_ERR(pr->cdev);
-		return result;
-	}
-
-	dev_dbg(&device->dev, "registered as cooling_device%d\n",
-		pr->cdev->id);
-
-	result = sysfs_create_link(&device->dev.kobj,
-				   &pr->cdev->device.kobj,
-				   "thermal_cooling");
-	if (result) {
-		dev_err(&device->dev,
-			"Failed to create sysfs link 'thermal_cooling'\n");
-		goto err_thermal_unregister;
-	}
+	pr->cdev = thermal_cooling_device_create(pr->dev, "Processor", device,
+						 &processor_cooling_ops);
+	if (IS_ERR(pr->cdev))
+		return PTR_ERR(pr->cdev);
 
-	result = sysfs_create_link(&pr->cdev->device.kobj,
-				   &device->dev.kobj,
-				   "device");
-	if (result) {
-		dev_err(&pr->cdev->device,
-			"Failed to create sysfs link 'device'\n");
-		goto err_remove_sysfs_thermal;
-	}
+	dev_dbg(pr->dev, "registered as cooling_device%d\n", pr->cdev->id);
 
 	return 0;
-
-err_remove_sysfs_thermal:
-	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-err_thermal_unregister:
-	thermal_cooling_device_unregister(pr->cdev);
-
-	return result;
 }
 
-void acpi_processor_thermal_exit(struct acpi_processor *pr,
-				 struct acpi_device *device)
+void acpi_processor_thermal_exit(struct acpi_processor *pr)
 {
-	if (pr->cdev) {
-		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-		sysfs_remove_link(&pr->cdev->device.kobj, "device");
+	if (!IS_ERR_OR_NULL(pr->cdev)) {
 		thermal_cooling_device_unregister(pr->cdev);
 		pr->cdev = NULL;
 	}
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 554be224ce76..656aaf74fb18 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -429,8 +429,7 @@ int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 /* in processor_thermal.c */
 int acpi_processor_thermal_init(struct acpi_processor *pr,
 				struct acpi_device *device);
-void acpi_processor_thermal_exit(struct acpi_processor *pr,
-				 struct acpi_device *device);
+void acpi_processor_thermal_exit(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
-- 
2.51.0





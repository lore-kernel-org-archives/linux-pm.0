Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CED485505;
	Fri, 11 Sep 2026 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132136; cv=none; b=ErmsQtD9wlCKvzqstfymMBugii96lUr0J32LmrVhBmRtgpI/1+wBYZRwkrFKhX2AljAgD4bY2tckEJ/bWCqTeG9NeZaJtmrIPn634zL1MA/zwAjx2gdNN63UlWT+DTqy2mb1CRjeTsiewsKZjN1IDyevvSFnLCg95NYhy2+SPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132136; c=relaxed/simple;
	bh=bxaA0P3IpNy7IQt1Q0NlSVbYIixLLU7eAAHt0RD1sok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjvJqaLUceUMYCsefU5n8uHLrPkf/xVBScf5FVSuzMZpZJ8nWL2maGxg3lfYye+XmB54fZpqoNGoqtFI8OB1vmAcAwk2PpeQB152jZra8PbPYoX75lz2GpW5eCrihgQo7KRApxdtymIgU2BvxxKU3gErK5ufvp4loYEV1XAYSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUH42vPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUH42vPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C27E1F000FF;
	Fri, 11 Sep 2026 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132135;
	bh=ZWKqeVkJoj+jhaKF5oGxhQbNxyvtVd6WfRcSDn/fX04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUH42vPiXPC2qNuxxUdOE0Mm3rxD36K+c58mmKxO8JpIXBg3C47PeY/HfKgCYH3jx
	 IqVakZb1lHWT3enFQOmagoPJxkQKW7ahUCtS1w4FiGlxKT6miHpfMnWcSyJPBq9EFe
	 E4YCV1703sF7RoHWwsjUtfq6/fNh6NWobQ5F7m+6ucM7Lg3guMcs5MZJKc4l1jJb7r
	 jwMDFho5EXrkDbMpTY1ZVMzUCTjQ5AU/T+oMIA+wNJYCuvKxQXhiFBUwRDOglHwxFC
	 RL9JZZnal8n0R+U5nlubW+zf6cSbNvnnMfHAKA1HxhMXEAdX37d2qTGUBvqUoz8d2m
	 DSrRLINUBo/mg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 05/10] ACPI: video: Use thermal_cooling_device_create()
Date: Fri, 11 Sep 2026 15:03:34 +0200
Message-ID: <23237491.EfDdHjke4D@rafael.j.wysocki>
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

Instead of using thermal_cooling_device_register() for registering a
backlight cooling device in the ACPI video bus driver, make it use
thermal_cooling_device_create() and pass a pointer to the LCD device
to that function as the cooling class device's parent.  That will
cause the cooling device's sysfs directory to be created under
the parent's sysfs directory (among other things).

Since creating a class device under a parent causes a "device" symbolic
link from the sysfs directory of the class device to the sysfs directory
of the parent to appear automatically, remove the code creating the
"device" symbolic link from the sysfs directory of the cooling device
in question to the sysfs directory of the parent's ACPI companion
device.  That companion device is reachable through the "firmware_node"
symbolic link in the parent's sysfs directory regardless.

Moreover, since the cooling class device is now located in sysfs under
its parent and it can be easily identified as a cooling device, there is
no need to create a "thermal_cooling" symbolic link from its parent's
ACPI companion to it.  Accordingly, also remove the code creating that
symbolic link.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 6cfe390411c1..2a2822516665 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1700,9 +1700,9 @@ static int acpi_video_resume(struct notifier_block *nb,
 
 static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 {
+	struct device *phys_dev, *parent = NULL;
 	struct backlight_properties props;
 	struct pci_dev *pdev;
-	struct device *parent = NULL;
 	int result;
 	static int count;
 	char *name;
@@ -1729,11 +1729,10 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 						      device,
 						      &acpi_backlight_ops,
 						      &props);
-	put_device(parent);
 	kfree(name);
 	if (IS_ERR(device->backlight)) {
 		device->backlight = NULL;
-		return;
+		goto put_parent;
 	}
 
 	/*
@@ -1743,8 +1742,12 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 	device->backlight->props.brightness =
 			acpi_video_get_brightness(device->backlight);
 
-	device->cooling_dev = thermal_cooling_device_register("LCD", device,
-							      &video_cooling_ops);
+	phys_dev = acpi_bus_get_primary_device(device->dev);
+	if (!phys_dev)
+		phys_dev = get_device(parent);
+
+	device->cooling_dev = thermal_cooling_device_create(phys_dev, "LCD", device,
+							    &video_cooling_ops);
 	if (IS_ERR(device->cooling_dev)) {
 		/*
 		 * Set cooling_dev to NULL so we don't crash trying to free it.
@@ -1753,21 +1756,17 @@ static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 		 * -- dtor
 		 */
 		device->cooling_dev = NULL;
-		return;
+		goto put_phys_dev;
 	}
 
-	dev_info(&device->dev->dev, "registered as cooling_device%d\n",
-		 device->cooling_dev->id);
-	result = sysfs_create_link(&device->dev->dev.kobj,
-			&device->cooling_dev->device.kobj,
-			"thermal_cooling");
-	if (result)
-		pr_info("sysfs link creation failed\n");
+	dev_info(&device->cooling_dev->device, "Using ACPI device %s\n",
+		acpi_dev_name(device->dev));
 
-	result = sysfs_create_link(&device->cooling_dev->device.kobj,
-			&device->dev->dev.kobj, "device");
-	if (result)
-		pr_info("Reverse sysfs link creation failed\n");
+put_phys_dev:
+	put_device(phys_dev);
+
+put_parent:
+	put_device(parent);
 }
 
 static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
@@ -1826,8 +1825,6 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 static void acpi_video_dev_unregister_backlight(struct acpi_video_device *device)
 {
 	if (device->cooling_dev) {
-		sysfs_remove_link(&device->dev->dev.kobj, "thermal_cooling");
-		sysfs_remove_link(&device->cooling_dev->device.kobj, "device");
 		thermal_cooling_device_unregister(device->cooling_dev);
 		device->cooling_dev = NULL;
 	}
-- 
2.51.0





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615886;
	b=AKsPV0ORd6091J8k2I40pZoRhI03Q346vzVGEf5KUqY4DhXmjoK2COrGZg6W4XTWc/70
	 wF/f3LOaARwPdCjWLNDeu5rC0/yN0iiBoET0zERgqkDWwWle4eZanp4dRDSnH6HIwfrWQ
	 dJRL1Ne9oPyaeS28TsWydULaNxa6T/C7I26GQiy4duZfTxZocMjqlG/frEr8ObHfG7+Re
	 9e3zmF3IwZHlGm5/EMFXoG49OVoW2mcLMCkDXwKZ3E3iuAaBnkhD4YrDrtKF7vDhuVMm2
	 vjqWpsYBqIzhKOPLVvYAFUuxSwvuAam3N12BO8odusRKztgjdBgVk5e74210qh74P5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615886;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=kboA2q0ySNJQa/zrnR//o4m67AduAYfUqrV6MJxG7v4=;
	b=e+BgVTZo7dBmhsiF/cpJUPoZeLI5zjpyEkrZKWXDWC3Xrnqr4fO++idFMfgM9PideK7c
	 jzksOfiqQhG07yQaaa4wr12YdOywtOOQeWjacudvuVfBB7mJeg6d6sM2rn7nD/zh9nPRh
	 vH2rmFxPrhZFQ0gekQUER7qZCCjlXKceKHoAAsemNmZUbtzZSOEXDt6xBdPOf9zHWm+py
	 iEY7LIIPzu7xb2Yu9YgeHx6HQ99V6dFQC8mdksJHLGwC7WgBSYxn0C3t3hremE3JNP4K1
	 oMtpfmOkW/EDT7AHpw4mhoQnyky7GP3rYkp/cAF3ITEkTF4ThODsV1JdZGFFQrvjggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9kLPMgP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BF606A33A;
	Wed, 25 Nov 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9kLPMgP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D1D1F000CA;
	Wed, 25 Nov 2026 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615885;
	bh=kboA2q0ySNJQa/zrnR//o4m67AduAYfUqrV6MJxG7v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O9kLPMgP48SsuuloLCzqwaAytybhoeaNFGIJTCkylLrh0O0OM2bp6bKey5gOO9S+8
	 lL3/tbZOooh50OCQClZPljtRyS/VsBgSxY+J/cXS4SfRN/bpbkSqOa2TclPfNGaj/c
	 nI1xXouPXJ2HQ5WE13vmW7gPSDmyoshjw+WGnS/xDdj4NWjzjl+SvFx+BjLJt1ND6v
	 j1YJV5jk6TQwuF5i57BElRifcGW+wMt9SbhHZ6C/fd77rlyMimoEcijQf89pQ2MiFN
	 aqKybzVH8pKAyw7eoBQg6jhICcgf+OI9iOr6Ri5+xFwF1He4Z3KmUq5GKnewCfZcKD
	 IC/et0GU2ermw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v2 2/5] ACPI: fan: Stop using driver_data pointer from struct
 acpi_device
Date: Wed, 25 Nov 2026 15:07:30 +0100
Message-ID: <14143841.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <2859850.mvXUDI8C0e@rafael.j.wysocki>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Instead of using the driver_data pointer under struct acpi_device,
make the ACPI fan driver use the driver data under the dev member of
struct acpi_device and clean it up properly on driver removal and on
probe failures.

While at it, unify the code ordering of acpi_fan_delete_attributes()
with the rollback path in acpi_fan_create_attributes().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---

v1 -> v2:
   * Use dev directly in show_fine_grain_control() (Andy)
   * Use for (int i = 0; ...) in acpi_fan_delete_attributes() (Andy)
   * Add R-by from Armin (thanks!)

---
 drivers/acpi/fan_attr.c | 20 ++++++++++----------
 drivers/acpi/fan_core.c |  1 -
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 5b43b7bb0ab4..9af73f81ec5e 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -64,8 +64,7 @@ static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr,
 
 static ssize_t show_fine_grain_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
-	struct acpi_fan *fan = acpi_driver_data(acpi_dev);
+	struct acpi_fan *fan = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
 }
@@ -88,6 +87,7 @@ int acpi_fan_create_attributes(struct acpi_fan *fan)
 	if (!fan->acpi4)
 		return 0;
 
+	dev_set_drvdata(&device->dev, fan);
 	sysfs_attr_init(&fan->fine_grain_control.attr);
 	fan->fine_grain_control.show = show_fine_grain_control;
 	fan->fine_grain_control.store = NULL;
@@ -122,6 +122,7 @@ int acpi_fan_create_attributes(struct acpi_fan *fan)
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 
 rem_fst_attr:
+	dev_set_drvdata(&device->dev, NULL);
 	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 
 	return status;
@@ -130,15 +131,14 @@ int acpi_fan_create_attributes(struct acpi_fan *fan)
 void acpi_fan_delete_attributes(struct acpi_fan *fan)
 {
 	struct acpi_device *device = fan->adev;
-	int i;
-
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 
-	if (!fan->acpi4)
-		return;
+	if (fan->acpi4) {
+		for (int i = 0; i < fan->fps_count; ++i)
+			sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
 
-	for (i = 0; i < fan->fps_count; ++i)
-		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
+		sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+		dev_set_drvdata(&device->dev, NULL);
+	}
 
-	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 }
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9b4b57614d66..d4f1d9a1d62d 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -478,7 +478,6 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	}
 
 	fan->adev = device;
-	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
 	if (acpi_has_method(device->handle, "_FST")) {
-- 
2.51.0





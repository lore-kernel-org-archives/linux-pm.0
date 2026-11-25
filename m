Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615888;
	b=AjTueENATU29KBE6jk6nrk57uczx+/P5A2CotEKho16bdBq6lSWKzEX8UFxqrUhFgWLf
	 5rk8PyN3wVaRdOViFOlMmwcjlIeiftjTLFRsihWYMqXvCBfvYaX0uYcM/4WNzQf8hCKtV
	 wRRz+bm+gfu5xH3SC8IYGfDDbiF5y3QZOQMOCkArcx6Dy9BGU72pcXBRYoBbPdacnIUOh
	 d0aF9VqsfjDeys0g2baod/N3PPyhh+J5HqfPGe16EyVWsf/iCHNSWwv5DG7yI96+XO6AJ
	 Z5IGggqTiz3aSTORLZxbsU6oeotqCmBkTf4K5znzar288ZdL2IQzYhFlBcNZf9g8/jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615888;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=5LTZv+bwpoyuP1pqldXGa5UL3Vf1nadNaj7jfDABTus=;
	b=OjjQ7WkTAVaMBl46TwcUndMj3SoKEJOy2LnHSGhOClRXdCJdogOZ3xvJh2c4NCEhRquk
	 tpKiUU0gdAT/fgfnHP3Dv35qr1EqsxumRdiHDFdrb3/T/2zdC3XrFipx+xf+CjILtz062
	 WtwGHT5FEf68tr7UdP/CxShDJ3xMgUxnt9qEcxXlBgDbCOoDfyqKDm0Y19shpaBqHavGn
	 lV6xXj0JyUYb5jA+a+yH37Bql2Ibao1xuEjgxxVZ5FXg3XVOn1vBpr15jC1NAEz6p7qmz
	 L5ixmnWFFFwAGdhZMq+4XTPPg7Vp8UdvKx5LyVFNuSfdaaWikFfhWzuxPrWHraDc+Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oF8Z35eQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5804606A327;
	Wed, 25 Nov 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oF8Z35eQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52B41F000C6;
	Wed, 25 Nov 2026 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615888;
	bh=5LTZv+bwpoyuP1pqldXGa5UL3Vf1nadNaj7jfDABTus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oF8Z35eQpr8bVupdw9xYAvH96iln09vy43wPe5sZdyOdC7+afMiIXAMUEZV/2t5Xo
	 LxB5EMbzmcCLAwhCH6FYSrVoKLdfcX9XSX5QaBHAE8VtKfWis9Av2A3UsZOVemxg0w
	 xFKK4b707J3mJEIjU6eVMu4UcH6a/tOCGFO7xu2gUDQjueAPcnWn+VvFLX2tCsltmc
	 0cAkZQ1AHEkOSiEV/ZJnQDI9q2uXdnUJLcQfel9RZTnYRJSIAkOgtCcLaVxoI6lCjn
	 DUa1L1WgX1l3PYyj6c2oVOtbyUZrb/ZXa3vDDe9p8WQM01WYUiDDM2qpZciZ1LTqfZ
	 5PNrRaMYMf9Qw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] ACPI: fan: Pass struct acpi_fan pointers to functions
Date: Wed, 25 Nov 2026 15:07:24 +0100
Message-ID: <1976174.tdWV9SEqCh@rafael.j.wysocki>
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

Pass a struct acpi_fan pointer as an argument to several functions in
the ACPI fan driver either instead of or in addition to a struct
acpi_device or a struct device pointer.

This allows acpi_driver_data() usage to be reduced and some other
simplifications to be made.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---

v1 -> v2:
   * Pass acpi_fan as the first argument to functions (Andy)
   * Add R-by from Armin (thanks!)

---
 drivers/acpi/fan.h      |  4 ++--
 drivers/acpi/fan_attr.c |  8 ++++----
 drivers/acpi/fan_core.c | 42 ++++++++++++++++++-----------------------
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 3faa247af514..66dbcc138ddd 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -101,8 +101,8 @@ static inline bool acpi_fan_power_valid(u64 power)
 }
 
 int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst);
-int acpi_fan_create_attributes(struct acpi_device *device);
-void acpi_fan_delete_attributes(struct acpi_device *device);
+int acpi_fan_create_attributes(struct acpi_fan *fan);
+void acpi_fan_delete_attributes(struct acpi_fan *fan);
 
 #if IS_REACHABLE(CONFIG_HWMON)
 int devm_acpi_fan_create_hwmon(struct device *dev);
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 9b7fa52f3c2a..5b43b7bb0ab4 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -70,9 +70,9 @@ static ssize_t show_fine_grain_control(struct device *dev, struct device_attribu
 	return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
 }
 
-int acpi_fan_create_attributes(struct acpi_device *device)
+int acpi_fan_create_attributes(struct acpi_fan *fan)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_device *device = fan->adev;
 	int i, status;
 
 	/* _FST is present if we are here */
@@ -127,9 +127,9 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 	return status;
 }
 
-void acpi_fan_delete_attributes(struct acpi_device *device)
+void acpi_fan_delete_attributes(struct acpi_fan *fan)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_device *device = fan->adev;
 	int i;
 
 	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 4324ff5d9c4c..9b4b57614d66 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -222,10 +222,9 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
  * --------------------------------------------------------------------------
 */
 
-static int acpi_fan_get_fif(struct acpi_device *device)
+static int acpi_fan_get_fif(struct acpi_fan *fan, struct acpi_device *device)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_fan *fan = acpi_driver_data(device);
 	struct acpi_buffer format = { sizeof("NNNN"), "NNNN" };
 	u64 fields[4];
 	struct acpi_buffer fif = { sizeof(fields), fields };
@@ -269,9 +268,9 @@ static int acpi_fan_speed_cmp(const void *a, const void *b)
 	return fps1->speed - fps2->speed;
 }
 
-static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device)
+static int acpi_fan_get_fps(struct acpi_fan *fan, struct device *dev,
+			    struct acpi_device *device)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	acpi_status status;
 	int i;
@@ -310,7 +309,7 @@ static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_fan_dsm_init(struct device *dev)
+static int acpi_fan_dsm_init(struct acpi_fan *fan, struct device *dev)
 {
 	union acpi_object dummy = {
 		.package = {
@@ -319,7 +318,6 @@ static int acpi_fan_dsm_init(struct device *dev)
 			.elements = NULL,
 		},
 	};
-	struct acpi_fan *fan = dev_get_drvdata(dev);
 	acpi_handle fan_handle = fan->adev->handle;
 
 	if (!acpi_check_dsm(fan_handle, &acpi_fan_microsoft_guid, 0,
@@ -344,7 +342,7 @@ static int acpi_fan_dsm_init(struct device *dev)
 	return 0;
 }
 
-static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper, u64 lower)
+static int acpi_fan_dsm_set_trip_points(struct acpi_fan *fan, u64 upper, u64 lower)
 {
 	union acpi_object args[2] = {
 		{
@@ -360,7 +358,6 @@ static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper, u64 lower
 			},
 		},
 	};
-	struct acpi_fan *fan = dev_get_drvdata(dev);
 	union acpi_object in = {
 		.package = {
 			.type = ACPI_TYPE_PACKAGE,
@@ -377,9 +374,8 @@ static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper, u64 lower
 	return 0;
 }
 
-static int acpi_fan_dsm_start(struct device *dev)
+static int acpi_fan_dsm_start(struct acpi_fan *fan)
 {
-	struct acpi_fan *fan = dev_get_drvdata(dev);
 	int ret;
 
 	if (!fan->fan_trip_granularity)
@@ -401,11 +397,11 @@ static int acpi_fan_dsm_start(struct device *dev)
 	 * overlap, meaning that the current fan speed needs to be outside at
 	 * least one range.
 	 */
-	ret = acpi_fan_dsm_set_trip_points(dev, fan->fan_trip_granularity, 0);
+	ret = acpi_fan_dsm_set_trip_points(fan, fan->fan_trip_granularity, 0);
 	if (ret < 0)
 		return ret;
 
-	return acpi_fan_dsm_set_trip_points(dev, fan->fan_trip_granularity * 3,
+	return acpi_fan_dsm_set_trip_points(fan, fan->fan_trip_granularity * 3,
 					    fan->fan_trip_granularity * 2);
 }
 
@@ -431,7 +427,7 @@ static int acpi_fan_dsm_update_trips_points(struct device *dev, struct acpi_fan_
 		lower = rounddown((u32)fst->speed - min_trip_distance, fan->fan_trip_granularity);
 	}
 
-	return acpi_fan_dsm_set_trip_points(dev, upper, lower);
+	return acpi_fan_dsm_set_trip_points(fan, upper, lower);
 }
 
 static void acpi_fan_notify_handler(acpi_handle handle, u32 event, void *context)
@@ -493,17 +489,17 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	}
 
 	if (fan->acpi4) {
-		result = acpi_fan_get_fif(device);
+		result = acpi_fan_get_fif(fan, device);
 		if (result)
 			return result;
 
-		result = acpi_fan_get_fps(&pdev->dev, device);
+		result = acpi_fan_get_fps(fan, &pdev->dev, device);
 		if (result)
 			return result;
 	}
 
 	if (fan->has_fst) {
-		result = acpi_fan_dsm_init(&pdev->dev);
+		result = acpi_fan_dsm_init(fan, &pdev->dev);
 		if (result)
 			return result;
 
@@ -518,13 +514,13 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		if (result)
 			return result;
 
-		result = acpi_fan_dsm_start(&pdev->dev);
+		result = acpi_fan_dsm_start(fan);
 		if (result) {
 			dev_err(&pdev->dev, "Failed to start Microsoft fan extensions\n");
 			return result;
 		}
 
-		result = acpi_fan_create_attributes(device);
+		result = acpi_fan_create_attributes(fan);
 		if (result)
 			return result;
 	}
@@ -556,7 +552,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 
 err_end:
 	if (fan->has_fst)
-		acpi_fan_delete_attributes(device);
+		acpi_fan_delete_attributes(fan);
 
 	return result;
 }
@@ -565,11 +561,9 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
-	if (fan->has_fst) {
-		struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	if (fan->has_fst)
+		acpi_fan_delete_attributes(fan);
 
-		acpi_fan_delete_attributes(device);
-	}
 	thermal_cooling_device_unregister(fan->cdev);
 }
 
@@ -591,7 +585,7 @@ static int acpi_fan_resume(struct device *dev)
 	int result;
 
 	if (fan->has_fst) {
-		result = acpi_fan_dsm_start(dev);
+		result = acpi_fan_dsm_start(fan);
 		if (result)
 			dev_err(dev, "Failed to start Microsoft fan extensions: %d\n", result);
 	}
-- 
2.51.0





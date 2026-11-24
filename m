Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535479;
	b=iC6dwel3oGnv9PnY4eDPsezWXe9fuqAgn0X6mfrxVZwFyV6058Qm/OJpT79JOC2hrygp
	 Zx0QiqIpyBrdfTBEfMwJfGJ6oOraObpnVeWfXfXyJ3RFnqaHjGlYw+508tPLCFsSeZia8
	 em4BM09weLV6TWSah9UZw+W0NifvAA8apcfOSIpS0hW3wv5Z/I37/ehz04geHhcAZL9dR
	 dKUzXngnsNsQXymjqs4LpINGL9emvlqzGrQ6pDKcnx9K4qTr3KSturI5by1kgjLT7uARw
	 uOk/GHl/gNBYm7mwR+gLS3th8vaFavlQvBT+vUsol8W71hQDcm74dC2y+WLPkuhy7Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535479;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=yP+n4z95zXJsrQLlsq1LEG72dZs7iifGi/TDTu5HjAM=;
	b=OtTeVpdiis1q4A7NXrS36HBTzhhJiFMO1s8NsxkWHqlxCSlBE8fvUdnvzLLlspKMTIpU
	 NTH2svVgmi/GzcnAEwFzEiTz3ymDPDOYpidX2o4M0Gqay2akiyyUsHK8dCxh9Ou0QO212
	 8abWhvobMuKikLF1W8ypaNKsbLK6E2OIyOnODFcBT6YuCwx0tVcORDDYr1uqkniEPWGim
	 ZcGSODypcC5TwsVpDPVUE/QljrtRfb2E2LQHg5KlwRYe9/+a/2+UpdLerQyHjQrx/hnsy
	 06akaIdraDSaWKFmDW8lh0rOHLEXeIWzC2fWDIDa99BxzU5vnxWL2+SPIhbyvjySHWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7kjTsx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC425606A31E;
	Tue, 24 Nov 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7kjTsx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2AF1F000E0;
	Tue, 24 Nov 2026 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535478;
	bh=yP+n4z95zXJsrQLlsq1LEG72dZs7iifGi/TDTu5HjAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y7kjTsx8gyflRc4Q8OyOQtFjIArYJoMxJFNRrMJTht1tWubw8TCqhssU3jZC/0WgY
	 fPstQci++VMcezSmqXJDhFszVC5kQlK3L8uIHcZPebTw6oiswHG1flrHvZFnJzVtiY
	 GTpEFxduNgtE1hmZtXl7SQ+Va5AMD6VYTIGQHKDwzLtG5hCe9IMnO7PwwtzT+TrPDR
	 LzgqBJoDrG5j2AVvOF4oRGxe1O2KZrrLvC/hyOcbQ5BimJS1YtSltKir00q4jJPoin
	 SEQtFc+DdV/lr5bFRQNSLXAQ8hINMw6OIUzZRkJzoWp8GatxcOcmwE1gCvOsu54uPZ
	 jXp/yoC7Umdmg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] ACPI: fan: Pass struct acpi_fan pointers to functions
Date: Tue, 24 Nov 2026 16:46:10 +0100
Message-ID: <9710131.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3985766.kQq0lBPeGt@rafael.j.wysocki>
References: <3985766.kQq0lBPeGt@rafael.j.wysocki>
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
index 4324ff5d9c4c..4a12e3bfe3be 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -222,10 +222,9 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
  * --------------------------------------------------------------------------
 */
 
-static int acpi_fan_get_fif(struct acpi_device *device)
+static int acpi_fan_get_fif(struct acpi_device *device, struct acpi_fan *fan)
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
+static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device,
+			    struct acpi_fan *fan)
 {
-	struct acpi_fan *fan = acpi_driver_data(device);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	acpi_status status;
 	int i;
@@ -310,7 +309,7 @@ static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_fan_dsm_init(struct device *dev)
+static int acpi_fan_dsm_init(struct device *dev, struct acpi_fan *fan)
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
+		result = acpi_fan_get_fif(device, fan);
 		if (result)
 			return result;
 
-		result = acpi_fan_get_fps(&pdev->dev, device);
+		result = acpi_fan_get_fps(&pdev->dev, device, fan);
 		if (result)
 			return result;
 	}
 
 	if (fan->has_fst) {
-		result = acpi_fan_dsm_init(&pdev->dev);
+		result = acpi_fan_dsm_init(&pdev->dev, fan);
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





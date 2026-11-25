Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615880;
	b=5il6/ii8BzOuUTZl/J/s9xYRqXWFeq2R0DGGs9qQazRp9fzk4NVu035pTSa6tA08xlGy
	 X99UuNF58OcSg3V7I3mRnuNM5z34pfG024QoEX9+MiFWLO8m6ezMNGXVwD3ZGz59vw6Nv
	 ortNzKwknsI9kNEQQ7CfElFLcZgFQVnsZ2W/ipMh7hLJKLHcE42puxdFSqctuJDcXHa+5
	 ZXYAqOs6LJm3HZqD8hi+RLFRoCfSK2GclC3PR/vcQjNoNbm7I90EblQQMqAP/Yw4dplU9
	 DczZd6GldsPEW/LCRjz77ppkR4LreS/5viUgCwoN+wy/jKcWEH0Y6PVjCUT7wMa3upQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615880;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=WFf0vNA13utgNKfrmijENh6FhX5rJWjSsj/yJoRcnlg=;
	b=xTaAouuf3CS8ijIlMAKZuNhJ0oDXKrAJ1akbTBpn9Ar107U4POcgqyEik2NnqMTNxWqr
	 nKXCTfHfSdbLXwykUWMS62jjjsO0TaqIXfGFeePCq8dtQ+2TPudpOAIXefPFNIBEUcGAa
	 3Z71gMulgz6xtCqf1ArJqm1UdPO88C0dmcHJArthX0OzgUTuvBVAAtjRZimRAyjYxOtp4
	 HUWp9MwVFO2pCd5AbyEJWEviviIBhKcNl1T1NLvhB+gOHVwVyzcRShtdCHx5qWWyuiMeg
	 4s8ZObmBxutmmbyegTg3q6APftIGbFohVB5ntt8r4Gujfkhu4kp/t9pXfrON8tU1P/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngqNGxOB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539D606A32A;
	Wed, 25 Nov 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngqNGxOB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57CA1F000CF;
	Wed, 25 Nov 2026 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615879;
	bh=WFf0vNA13utgNKfrmijENh6FhX5rJWjSsj/yJoRcnlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngqNGxOBcA6m2J4PR2oqMSr5AM/NlIt7bMMpLpDIEKwoC/3e86RPao2Le4MaWrsCJ
	 v0pVJdfSLNSyJ/wxQnX+QOZAyXGEEZ5vrD0eIWzz9VZ7C+/7uw9s2kmOdX/PYy8P6X
	 EuMEAefuNCmv7N710w45P9SWcUWfUoFPKKlSL4r7FFw1Cf97tvwtPt7ahEcy9vV+oz
	 jdYwIc9+5Skz8590XQCYEJn/oXBr/AKWTQ7GsT/eSTYxCD2hEpUqTpLLYVAQvImZ25
	 O2OqqjYN83Dz7A/XavbPUiB/iEAWqTCLyypKYS9lO/lfUiaZ/7ToF3EHosy22BEy49
	 1nO65Lt6mChZw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/5] ACPI: fan: Add local variable dev to acpi_fan_probe()
Date: Wed, 25 Nov 2026 15:09:34 +0100
Message-ID: <8764237.T7Z3S40VBb@rafael.j.wysocki>
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

In acpi_fan_probe(), use a new local variable called "dev" to store
a pointer to the dev field in the platform device object passed to it
and use that variable wherever the pointer held by it is needed.

While at it, adjust a leftover message printing statement that printed
a message relative to the fan device's ACPI companion by mistake and
remove a redundant error message after a memory allocation failure,
also printed relative to the fan device's ACPI companion.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---

v1 -> v2:
   * Add R-by from Armin (thanks!)

---
 drivers/acpi/fan_core.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index d000bf0ef58c..f1efa0db9958 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -462,20 +462,19 @@ static void acpi_fan_notify_handler(acpi_handle handle, u32 event, void *context
 
 static int acpi_fan_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	int result = 0;
 	struct thermal_cooling_device *cdev;
 	struct acpi_fan *fan;
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	char *name;
 
 	if (!device)
 		return -ENODEV;
 
-	fan = devm_kzalloc_obj(&pdev->dev, *fan);
-	if (!fan) {
-		dev_err(&device->dev, "No memory for fan\n");
+	fan = devm_kzalloc_obj(dev, *fan);
+	if (!fan)
 		return -ENOMEM;
-	}
 
 	fan->adev = device;
 	platform_set_drvdata(pdev, fan);
@@ -492,30 +491,29 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		if (result)
 			return result;
 
-		result = acpi_fan_get_fps(fan, &pdev->dev, device);
+		result = acpi_fan_get_fps(fan, dev, device);
 		if (result)
 			return result;
 	}
 
 	if (fan->has_fst) {
-		result = acpi_fan_dsm_init(fan, &pdev->dev);
+		result = acpi_fan_dsm_init(fan, dev);
 		if (result)
 			return result;
 
-		result = devm_acpi_fan_create_hwmon(&pdev->dev);
+		result = devm_acpi_fan_create_hwmon(dev);
 		if (result)
 			return result;
 
-		result = devm_acpi_install_notify_handler(&pdev->dev,
-							  ACPI_DEVICE_NOTIFY,
+		result = devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
 							  acpi_fan_notify_handler,
-							  &pdev->dev);
+							  dev);
 		if (result)
 			return result;
 
 		result = acpi_fan_dsm_start(fan);
 		if (result) {
-			dev_err(&pdev->dev, "Failed to start Microsoft fan extensions\n");
+			dev_err(dev, "Failed to start Microsoft fan extensions\n");
 			return result;
 		}
 
@@ -527,7 +525,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	if (!fan->acpi4) {
 		result = acpi_device_update_power(device, NULL);
 		if (result) {
-			dev_err(&device->dev, "Failed to set initial power state\n");
+			dev_err(dev, "Failed to set initial power state\n");
 			goto err_end;
 		}
 	}
@@ -537,13 +535,13 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	else
 		name = acpi_device_bid(device);
 
-	cdev = thermal_cooling_device_create(&pdev->dev, name, fan, &fan_cooling_ops);
+	cdev = thermal_cooling_device_create(dev, name, fan, &fan_cooling_ops);
 	if (IS_ERR(cdev)) {
 		result = PTR_ERR(cdev);
 		goto err_end;
 	}
 
-	dev_dbg(&pdev->dev, "registered as cooling_device%d\n", cdev->id);
+	dev_dbg(dev, "registered as cooling_device%d\n", cdev->id);
 
 	fan->cdev = cdev;
 
-- 
2.51.0





Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535470;
	b=dKLQw4HNwcLGpnomJLOXw+3XI0tERP3QyI/OPXkdYhNOfvCTZDWS8jsPQM4ryV8S+chM
	 fbB+f1VvL9Sx2yEFC+9TrrsvAPb6OlENz1q4MoIG02IRkQ9UHhk2aCuYX3kTB0laW9sqY
	 HD0mfY3JaJWY4oSLtU8p55Ft2LpXUvLE+bryFSNgCb4DomAplWQeFd4M2w1CdwPRn7k/+
	 lOIi8hQn1F5Z1jdeheUQjGqa7oGPUvGwLD9D0qIxGIlXOwxbwORx8M/Lpi+Pk+wx1H5Rh
	 n54Kj6oBthnIcN7EgYUYt2yeo8NhyYA0rXtsIZVRuYRjTWeFPKZglZmpm3Au+lN7TdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=VsquXXORdfKJErqGFiAsFreL5SPHEu4yuJDbDV/k0MM=;
	b=JFXmzUSKd9Iq/0yQbcz0VyNIDhfqJWQCgg2clcDYgS0+U+qzm7nguXJC3zdSeaqR3kHF
	 VlRwziQGF8wkAe6r5oTwbBeU2E8XzmwBAhNmN7sMzn0e3wK1iye6VdKCUubP4tCo96GGl
	 1vnRWKXf3mfxsYRIB7+djkbegNVNUIR4ZGF2cNoAyRe9xYtOik4iQrVk7in6fGm4/Ivvm
	 Jnjn0QgYywTHsofsD+8E1M5c+VOuCQCeqDvaiuKPK/cHi0/3j1KKi0rSNvxZU2tYwsnvo
	 h1zrIg3HcAyqoWh37nxQieeTeR293QSdMwkXaoFrvpV7G8voEAu9+NAMHCJZzO1/NoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mklMu+EL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4E606A326;
	Tue, 24 Nov 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mklMu+EL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C971F000C0;
	Tue, 24 Nov 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535469;
	bh=VsquXXORdfKJErqGFiAsFreL5SPHEu4yuJDbDV/k0MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mklMu+ELUCanVa5ChqcWx5Dtuvd5sBMuwN87ffBWdz9vMMh8rt46lYr7DIVNfHo1f
	 kaXB4wRhei1IvlDdy22Shj1CTzZa2rxiCbiIDfgpdfau/sNM50c6fWcXN/kZP5H9iv
	 RipGpWQdkMVuB8uDlzpxrIggnvNEfY/l12xG5Xl25ymBjBLI6UnjgtL50nyLpF8LA+
	 yuvDK6ZuZMExmvA8v1qkIV0Kl/zufPknPWozHPdJfDbD4EB8G99VmLB50DpXyddpUB
	 NYKNAqD0wmxgFPmMGl1PeMGa19SkPDtuoPbibhv6Fhkq3i3eFjSoVojddmJrEnkNkT
	 Z7JvXIqdMZvLA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] ACPI: fan: Add local variable dev to acpi_fan_probe()
Date: Tue, 24 Nov 2026 16:49:03 +0100
Message-ID: <3646595.QJadu78ljV@rafael.j.wysocki>
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

In acpi_fan_probe(), use a new local variable called "dev" to store
a pointer to the dev field in the platform device object passed to it
and use that variable wherever the pointer held by it is needed.

While at it, adjust a leftover message printing statement that printed
a message relative to the fan device's ACPI companion by mistake and
remove a redundant error message after a memory allocation failure,
also printed relative to the fan device's ACPI companion.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 5085d975a20c..4b37f6ea2aa6 100644
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
 
-		result = acpi_fan_get_fps(&pdev->dev, device, fan);
+		result = acpi_fan_get_fps(dev, device, fan);
 		if (result)
 			return result;
 	}
 
 	if (fan->has_fst) {
-		result = acpi_fan_dsm_init(&pdev->dev, fan);
+		result = acpi_fan_dsm_init(dev, fan);
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





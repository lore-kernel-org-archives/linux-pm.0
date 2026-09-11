Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AE486B8B;
	Fri, 11 Sep 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132131; cv=none; b=cyk+3zTTyhlu6mj2AfdOnMGoxlAP2fbfeTlUUbbsb2kfXVbqsk5srJK5JgmsgROoIULYT5lAm0qPfF81m/XPDN+L3WwJ80LQxTX7T6VzUcsIjo6oUijGbpZ1DxJwsjmAwl8u6RUXcajKDqVcqWOK91YwPWt3KMvDXGIKsREKhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132131; c=relaxed/simple;
	bh=fDSXALvvR5G9nLlxtV82I2rtk1ERcQZeIXEXw3fUNQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMWi/hYPOuATz1rnCpptFBycgl5UPhBf2guAxvw/ahWouYRZ495DfD3ufoS4q+l88YZK1PAcnv2rCzdxkW585nLVfE5AY19OFmiftityfDn5M8McmHPjU3X0OSbXlgMcLzaef/kLaDKuPox3XZhN9rVFARuI2mqMVyLClGksoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6OVE3ME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6OVE3ME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5291F0089A;
	Fri, 11 Sep 2026 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132130;
	bh=/AkQ6jEZTrwnH31l0S6TJm8WsStWiXnxaXazMuscouA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6OVE3ME+hXNAEk8AoMVemZNA+3IxnUwXkl1LaQj+dOzkrAeils58SYKq2pwSclLL
	 hMH/t+hDp1kQljo93HpSlEQ/ZcIosJUN2PrNt0xEiC+FPUHoX64WL4oUYgxC36dMh4
	 sqQMnI2ci8oO98t1urByN/DAhjXylJ6ymh1gZtqaXZyc+5VwtmwvOlLz38VVDlzFO0
	 cLAPeDvo0Dp1ChchNsoiF6zvc8OV+H1TWCgSYWOJUlkIGTzC9izu2jmH8+qEHixGKF
	 WRBu5ij1qO+0fiWvPGS6Y7twLos3q/V1uf9Bsgwz3DnerbnSRjovtufBcp1GGbHk9H
	 guXlk206yz5rw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 06/10] ACPI: fan: Use thermal_cooling_device_create()
Date: Fri, 11 Sep 2026 15:04:11 +0200
Message-ID: <3969045.kQq0lBPeGt@rafael.j.wysocki>
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

Instead of using thermal_cooling_device_register() for
registering a cooling device in the ACPI fan driver, make it use
thermal_cooling_device_create() and pass a pointer to the platform
device representing the given fan to that function as the cooling
device's parent.  That will cause the cooling device's sysfs directory
to be created under the parent's sysfs directory (among other things).

Since creating a class device under a parent causes a "device" symbolic
link from the sysfs directory of the class device to the sysfs directory
of the parent to appear automatically, remove the code creating that
symbolic link manually.

Moreover, since the cooling device is now located in sysfs under its
parent and it can be easily identified as a cooling device, there is
no need to create a "thermal_cooling" symbolic link from its parent
to it.  Accordingly, also remove the code creating that symbolic link.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index a31d7beca5d0..29ca97503deb 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -564,8 +564,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	else
 		name = acpi_device_bid(device);
 
-	cdev = thermal_cooling_device_register(name, device,
-						&fan_cooling_ops);
+	cdev = thermal_cooling_device_create(&pdev->dev, name, device, &fan_cooling_ops);
 	if (IS_ERR(cdev)) {
 		result = PTR_ERR(cdev);
 		goto err_end;
@@ -574,28 +573,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "registered as cooling_device%d\n", cdev->id);
 
 	fan->cdev = cdev;
-	result = sysfs_create_link(&pdev->dev.kobj,
-				   &cdev->device.kobj,
-				   "thermal_cooling");
-	if (result) {
-		dev_err(&pdev->dev, "Failed to create sysfs link 'thermal_cooling'\n");
-		goto err_unregister;
-	}
-
-	result = sysfs_create_link(&cdev->device.kobj,
-				   &pdev->dev.kobj,
-				   "device");
-	if (result) {
-		dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
-		goto err_remove_link;
-	}
 
 	return 0;
 
-err_remove_link:
-	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
-err_unregister:
-	thermal_cooling_device_unregister(cdev);
 err_end:
 	if (fan->has_fst)
 		acpi_fan_delete_attributes(device);
@@ -612,8 +592,6 @@ static void acpi_fan_remove(struct platform_device *pdev)
 
 		acpi_fan_delete_attributes(device);
 	}
-	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
-	sysfs_remove_link(&fan->cdev->device.kobj, "device");
 	thermal_cooling_device_unregister(fan->cdev);
 }
 
-- 
2.51.0





Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33120E334;
	Mon, 11 May 2026 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529295; cv=none; b=GdaLvkVDlBoIQ5RuqYBQT9ET3Jb+Jc5DyodFFP1VMvp17YbXnpbbh21Fe3IaOWDNdOz5XQzgQpDFZVrEd/Ko+Py5pGz1It/zUwGJ3VvrDcTCDzqxJwT+OIUn6ZhnWPUsmhSB2y1686xLhiTtaiO2lQg4+mOplNBjoSp+2ZtwXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529295; c=relaxed/simple;
	bh=SmycbUfU5q/ceSLi9AUZnde3P/EFVo+BHXzp2TdjABc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtE/9FM2TknTKn4sZBNGjCVa7AZx/boY7vsV3952fLlBDeel4q9YfRnVkJslb73tydsR1LEjUX9wsRYW/IpX23YWIqoEtkQfGuhPqd0ihGdwGwT4vfk5NEqMjYndnUNlCkDf0xoQttuztndtGDLDZVk7XAcLubiRZTzwxdYvyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSeuP0Sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSeuP0Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE97C2BCB0;
	Mon, 11 May 2026 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529295;
	bh=SmycbUfU5q/ceSLi9AUZnde3P/EFVo+BHXzp2TdjABc=;
	h=From:To:Cc:Subject:Date:From;
	b=TSeuP0SwSU++DiMKa3ziOZHaiJ8VSgg9UgrphBJvtTMzFy+jK6T22Mh4RCN8kpOd0
	 3ChOF3mJWUhL9LNhsJHR//8H6NuX9v3U+RNYjfFt1tfFsHOdU12pxQT+R1FA3oaw1v
	 WlQPxXmCuJMIEZBCZvMwjacvxhxD137E6ocxLmk2xvv7mIbHQ5zW1OKR0Qq4mmuTVy
	 +Jb/yo53RHZXIX+Q+octytrR7NA8KX3WsMkh+/8neTqBY4p6e8REYzerLyegSZvF8r
	 t5Tkf9WvNVDje+o2UhC8K0Dn7p7ST0t2vCjIqnejnUXlutTv8TF5W41lWCQfCLLAoJ
	 evBg+bUNRbbXQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1] hwmon: (acpi_power_meter) Check ACPI_COMPANION() against NULL
Date: Mon, 11 May 2026 21:54:51 +0200
Message-ID: <5068745.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
acpi_power_meter hwmon driver.

Fixes: afc6c4aedea5 ("hwmon: (acpi_power_meter) Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/acpi_power_meter.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -884,10 +884,14 @@ static void acpi_power_meter_notify(acpi
 
 static int acpi_power_meter_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_power_meter_resource *resource;
+	struct acpi_device *device;
 	int res;
 
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
+
 	resource = kzalloc_obj(*resource);
 	if (!resource)
 		return -ENOMEM;




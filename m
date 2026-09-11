Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5AA489FC1;
	Fri, 11 Sep 2026 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132154; cv=none; b=WRaaigARNMq1BtNdcSKpo/S2NWL/TAR9jQ56L+NN4MO7CQGCApErVKVwQQn43B0jhngPrvSztmW+jsEbldAGHXSBgjsswfyarTiBRQGTTFjpZ32sUXg/JV8nQRjejOnEaQ6u9wMCWOcuWZE3S9TpU87adaNLRS0rMMmn+58eLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132154; c=relaxed/simple;
	bh=Fu32E1DpnOWBmTrmLUU7DvPHppIuyHBw/g93pmK57tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYNoOJtdePWduUiaHSWGehbVrObINsfnvmVFKnfN6GEAz5/etY4joM8Ra+LsI0h7Y/35d3E0dItfsq3RGoWI599njVOhtl29waEvgOSP8Ju/Qu6dDnYeLksJ72QNsUnJvJoijkTd0LhV/AZk5Bpkl23WKs2mb7kMSsMDH9uSH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VknPrnMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VknPrnMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069A51F000FF;
	Fri, 11 Sep 2026 13:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132153;
	bh=Di7b34N806SVPeEXMP0pT1oX7c2Vi6c+fpBMo2zCWLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VknPrnMzdHDyo3tOj06qDi2eFFoXcPyp8sevNOgYm3OyViTKsq/z47FdI5XTi/6U0
	 PAk5zWVAS56Bm222lT+oFAuwPK2puN7wzYQEgkMBmd1/DBKhNWLlfN13nE0p+JheAZ
	 CHleK7Mm5AL8UXjGcwVkXF3ImegFgT2a/FIYl0T9qUlGk8ssQEZa8LoWA9bOpOZnAl
	 l13E6R+VS8dltyKsvfVwhxOOhEFT5OszRB0NfcajEEAJ2ZY70SXqpeC2BKj+7N/IRK
	 VRtEvot9GqQzvBaZTRsGEjdQJgq46GluhhLplz0wXs9oXD+aK9Y4M5RKniPddxBCY+
	 dafnlHf/OC3Mw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 01/10] ACPI: fan: Fix memory leak due to leftover devm_kcalloc()
 argument
Date: Fri, 11 Sep 2026 15:00:51 +0200
Message-ID: <14089663.uLZWGnKmhe@rafael.j.wysocki>
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

An ACPI device object's dev field in passed as the first argument to
devm_kcalloc() in acpi_fan_get_fps() which is incorrect and leads to
a memory leak on driver probe errors and removal because the driver
is not bound to that ACPI device.

Address this by replacing that pointer with a pointer to the device the
driver is actually bound to.

While at it, drop a redundant error message after a memory allocation
failure (that also gets printed relative to the ACPI device).

Fixes: d91a1d129b63 ("ACPI: fan: Use platform device for devres-related actions")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 624d0736b581..a31d7beca5d0 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -284,7 +284,7 @@ static int acpi_fan_speed_cmp(const void *a, const void *b)
 	return fps1->speed - fps2->speed;
 }
 
-static int acpi_fan_get_fps(struct acpi_device *device)
+static int acpi_fan_get_fps(struct device *dev, struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -304,11 +304,8 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	}
 
 	fan->fps_count = obj->package.count - 1; /* minus revision field */
-	fan->fps = devm_kcalloc(&device->dev,
-				fan->fps_count, sizeof(struct acpi_fan_fps),
-				GFP_KERNEL);
+	fan->fps = devm_kcalloc(dev, fan->fps_count, sizeof(*fan->fps), GFP_KERNEL);
 	if (!fan->fps) {
-		dev_err(&device->dev, "Not enough memory\n");
 		status = -ENOMEM;
 		goto err;
 	}
@@ -522,7 +519,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		if (result)
 			return result;
 
-		result = acpi_fan_get_fps(device);
+		result = acpi_fan_get_fps(&pdev->dev, device);
 		if (result)
 			return result;
 	}
-- 
2.51.0





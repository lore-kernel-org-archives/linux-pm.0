Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0390483BED;
	Fri, 11 Sep 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132150; cv=none; b=R9PAIo9IkqWuONapq9XOqNsk6rgAnDTe0mJdCnZdozW9lJgoaldkT4Ctq71TOKH8ekpJaK3bIdlZOKx+Yvv0u+3iaL1+HsXm3f0K8yQ4eYq7D2JKAt1eExejAKLtatW90hXWdH1EXq+Hpacq/VL+AaxzjZkgfwTTF7dC894zzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132150; c=relaxed/simple;
	bh=kxVk/AzwUVXqIv31A0JbN7cYc7dk3SwXC23zehYhdFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOe49oBaMCGFdKvl/yNDZVvC81mpnWd7hmUg/9zCs2q0Ks32B6uPEfvcv8BSBuLMrtMiH6NPQvS0ylrdZtG5w4nXsU5uqE1dTZxh3+3gySc7HNdJV1h1D+oeQCHENKNbGn1/1ykRgRqNsgh1XFPYYI2s3pWXjDgcdN/uH3ytYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4eNdxKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4eNdxKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31431F000FF;
	Fri, 11 Sep 2026 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132148;
	bh=QHbamjAUUV1lhAIi6tseD8ciIJGtNSgY77Oy7F7ieAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4eNdxKitAn1Vb+rSQoMmnmlho8YaWwhdWCRKhAtYJqRDwtAg3DqfCEEy8S6Df5oV
	 lSNli0KP4A3i8PD57xbBUg+Sn2bW8B5I5bJ6vqgQtlKwfvByrIPciWeYHbijn5gdLm
	 cyt3vxgK6I/KqQyAopwRrriYYp6uOzzovnlwg5QWK0AqpQJRSTPzOe6GoX9vErc3gx
	 F0ibqzmZ29spN/uxJgeE8hYOIqwa6D6/Po2Jy+YI7mQNTEFIQtUoTOwVED64TcX2HM
	 vlxJ6w7FT5j4bXJceeIrbmqL0P1fVPfgeolxTNqFVDTilT6c3+RSKw46HXhRtqUdUJ
	 vS5eiUv80q7UA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 02/10] ACPI: video: Fix backlight unregistration ordering
Date: Fri, 11 Sep 2026 15:01:30 +0200
Message-ID: <3429468.aeNJFYEL58@rafael.j.wysocki>
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

In acpi_video_dev_unregister_backlight(), the sysfs interface of the
cooling class device may access the brightness object under the
backlight device's ACPI companion, so that object cannot be freed
before unregistering the cooling class device.

Adjust the code to take that into account.

Fixes:
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4d6fd9f6e9ad..6cfe390411c1 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1825,6 +1825,12 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 
 static void acpi_video_dev_unregister_backlight(struct acpi_video_device *device)
 {
+	if (device->cooling_dev) {
+		sysfs_remove_link(&device->dev->dev.kobj, "thermal_cooling");
+		sysfs_remove_link(&device->cooling_dev->device.kobj, "device");
+		thermal_cooling_device_unregister(device->cooling_dev);
+		device->cooling_dev = NULL;
+	}
 	if (device->backlight) {
 		backlight_device_unregister(device->backlight);
 		device->backlight = NULL;
@@ -1834,12 +1840,6 @@ static void acpi_video_dev_unregister_backlight(struct acpi_video_device *device
 		kfree(device->brightness);
 		device->brightness = NULL;
 	}
-	if (device->cooling_dev) {
-		sysfs_remove_link(&device->dev->dev.kobj, "thermal_cooling");
-		sysfs_remove_link(&device->cooling_dev->device.kobj, "device");
-		thermal_cooling_device_unregister(device->cooling_dev);
-		device->cooling_dev = NULL;
-	}
 }
 
 static int acpi_video_bus_unregister_backlight(struct acpi_video_bus *video)
-- 
2.51.0





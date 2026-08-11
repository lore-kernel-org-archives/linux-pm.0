Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD463F23A4
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429090; cv=none; b=I2m0R4aV0BhOD3ngKc0tVr8Xqb7mcsFAXmIsLBE+zmcCKcKif5h4HjqDpecchjVxA6OJBG+gM2qMxGKbbkCbx8CS0LxGDl84kVRgzXO4zJE53T3V6tvH+69X+/jsqBX9EsYnDrpplBIlr7AUL9Obas9WQziMdvRSK1EUOL7Jz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429090; c=relaxed/simple;
	bh=NZVBgOqemxnC6dI5OZqidxROEUvU2V9C2Z1ODzjji50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyy/Nu9oAjwZFG8hX+5Fr7hqVBKl8HJiZj+BnCPh19xzqjrin2VntUmBVQW8hRH3/WzqDJ4nzNiay6/uR8kPW3PkSvW8gOk6TLmVqWztNIg4N+fzu10U7vDGlJlX9sBUhlSRbUJ67wEQTT7yj4l2GrjeSnjUaq9jF6dgHdf4LwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oUkHIbpi; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oUkHIbpi"
X-KPN-MessageId: 40029555-954c-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 40029555-954c-11f1-a055-005056abad63;
	Tue, 11 Aug 2026 08:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TeHZvgtyCGLOahkyeGBFtALg1mq30BAVLkQW716VLFY=;
	b=oUkHIbpiXvls4UnE4SZfHf+aPt5nk55nr26aqH3x7pEUK2R2k/cpgrQ3akiAq7kg2eP5mLrQyQRc2
	 WcaCRySfX6jQNi2ceiuWhGoC89tjBfDyPux4xT08V52Uukt7Ek1zd0ZhUri9mdhP9y1cif1Pxi3DIz
	 Pzz8H8ylA2QgQWYdoEV6ag4s/d1UQ7O4+wjeTC12WJuYcr8OUI0XFJb4s2Or4gy+8OGNsv7yBWgrG2
	 gWkX9K9nQ/JAn+eC1UpQFV1glTGImAId7zalp2WgwEjeTYq6gZArxLXDY1MaPNHantrwjD+YHUAdyj
	 Lj1nEeUM4LAtwtUOvd/5WJjV5IZbw+g==
X-KPN-MID: 33|GONWCl8N/nfbfn5UUmRHjJuv0xCzdZeVzaL8Pq+3io8gH4NyFlginXCGBbJpMWy
 8C+NQSEkgDdO95sWjzHycsk2xOJ8w/77Tl1+hGx9bQQs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|X1EAAYIRt07Om/hncePwpIxiPBSO9YooAf6Ho4P46MkaNRH+mrMrsKcB6H/5l4c
 UF31Lb/3pn9oewcwbHS0KQg==
Received: from fedora (unknown [14.52.27.3])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 19607b6e-954c-11f1-86b3-005056ab7584;
	Tue, 11 Aug 2026 08:16:34 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: change thermal_class to a const struct
Date: Tue, 11 Aug 2026 02:15:29 -0400
Message-ID: <20260811061530.21789-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change thermal_class to be a const struct class and drop the
class_create() call.

Compile tested only.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 drivers/thermal/thermal_core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 28a20d4b475c..36220113ca8e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -889,7 +889,9 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 	kfree(pos);
 }
 
-static struct class *thermal_class __ro_after_init;
+static const struct class thermal_class = {
+	.name	= "thermal"
+};
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -973,7 +975,7 @@ thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_devi
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (!class_is_registered(&thermal_class))
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1010,7 +1012,7 @@ int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdat
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->updated = false;
-	cdev->device.class = thermal_class;
+	cdev->device.class = &thermal_class;
 	cdev->device.release = thermal_cdev_release;
 	device_initialize(&cdev->device);
 	cdev->devdata = devdata;
@@ -1447,7 +1449,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (!class_is_registered(&thermal_class))
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1483,7 +1485,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = thermal_class;
+	tz->device.class = &thermal_class;
 	tz->device.release = thermal_zone_device_release;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
@@ -1745,7 +1747,7 @@ static void __thermal_pm_prepare(void)
 
 void thermal_pm_prepare(void)
 {
-	if (!thermal_class)
+	if (!class_is_registered(&thermal_class))
 		return;
 
 	__thermal_pm_prepare();
@@ -1776,7 +1778,7 @@ void thermal_pm_complete(void)
 {
 	struct thermal_zone_device *tz;
 
-	if (!thermal_class)
+	if (!class_is_registered(&thermal_class))
 		return;
 
 	guard(mutex)(&thermal_list_lock);
@@ -1789,7 +1791,6 @@ void thermal_pm_complete(void)
 
 static int __init thermal_init(void)
 {
-	struct class *tc;
 	int result;
 
 	thermal_debug_init();
@@ -1808,13 +1809,10 @@ static int __init thermal_init(void)
 	if (result)
 		goto unregister_governors;
 
-	tc = class_create("thermal");
-	if (IS_ERR(tc)) {
-		result = PTR_ERR(tc);
+	result = class_register(&thermal_class);
+	if (result)
 		goto unregister_governors;
-	}
 
-	thermal_class = tc;
 	return 0;
 
 unregister_governors:
-- 
2.55.0


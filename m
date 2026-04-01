Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D72F2910;
	Wed,  1 Apr 2026 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055094; cv=none; b=R4t7sUsfo4mvB0uFUc5/iDtw0+P7WLggDtVWsQ16UsKiaWCZvMKlYuIQPR6PrMahXiMSr8lOyUavT2hP7pKv973B2bNylOy3p0Y12BHfa3F3CF8UsN8Le1ySU7JYMhMTJ77KAO4KxKkYHOUwvzKqWJxqpmMEa0AIx4vfnvjsHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055094; c=relaxed/simple;
	bh=Q19lsxMvAeX1PQIMo9e5I3zrq6GF7svRcEwDH1xWHeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHGpqjxPFuLRexbe5Tc2a43Y5bPDBZWL6oKFJka5Q60WHIpvag2dvK53W2T2NpX4DFUcoUKv2SK9Lrijc77U8cF3rCur/hTfQCqo1gtHX+4ODxW9d5m73zHYfXg6u0V0a6W/UsDQDyU3V9HH4CuCqos9IinGme8h9fFlWG+Dy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgvRkSa2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgvRkSa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF60C19421;
	Wed,  1 Apr 2026 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775055094;
	bh=Q19lsxMvAeX1PQIMo9e5I3zrq6GF7svRcEwDH1xWHeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgvRkSa2Y5EyMjgRnZBhdxCSr3uu9AM/E1IaEtsFQxZP13wc1s8HYWQB6gs+s6uMb
	 tjAFOqKcLE91l+5BGKgUUewldH/duzzFj1YlVE6/3vT/4RgAmUsk3+2kIns4rQqOBJ
	 QdyrpPGVaZO53QGde8HZP50Xi5LXDuII9GyODV+TS10dCXF0dkwB1LJfXrDdhIVK66
	 gZyzDJRqmWwJ8+PaOWbQcU5Mf8oXQiVhVq4wVunwUpSTPJPJbrOiRZtdXlbxoGV/5u
	 WdHfztiPVN7006weyRGIoPPgVpvCp4yT/YslSDPmzqTuor6041KZmEUlW2CDpeVj/+
	 kZh2+1YgSEHbg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v2 3/4] thermal: core: Allocate thermal_class statically
Date: Wed, 01 Apr 2026 16:45:40 +0200
Message-ID: <10851294.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
References: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define thermal_class as a static structure to simplify thermal_init()
and the thermal class availability checks that will need to be carried
out during the suspend and resume of thermal zones after subsequent
changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Reorder with respect to the next patch to allow the latter to be simpler
   * Add thermal_class_unavailable() (the next patch uses it too)

---
 drivers/thermal/thermal_core.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -977,7 +977,15 @@ static void thermal_release(struct devic
 	}
 }
 
-static struct class *thermal_class;
+static const struct class thermal_class = {
+	.name = "thermal",
+	.dev_release = thermal_release,
+};
+
+static bool thermal_class_unavailable(void)
+{
+	return !class_is_registered(&thermal_class);
+}
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -1070,7 +1078,7 @@ __thermal_cooling_device_register(struct
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable())
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1094,7 +1102,7 @@ __thermal_cooling_device_register(struct
 	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
-	cdev->device.class = thermal_class;
+	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
@@ -1542,7 +1550,7 @@ thermal_zone_device_register_with_trips(
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable())
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1578,7 +1586,7 @@ thermal_zone_device_register_with_trips(
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = thermal_class;
+	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
@@ -1925,21 +1933,9 @@ static int __init thermal_init(void)
 	if (result)
 		goto destroy_workqueue;
 
-	thermal_class = kzalloc_obj(*thermal_class);
-	if (!thermal_class) {
-		result = -ENOMEM;
-		goto unregister_governors;
-	}
-
-	thermal_class->name = "thermal";
-	thermal_class->dev_release = thermal_release;
-
-	result = class_register(thermal_class);
-	if (result) {
-		kfree(thermal_class);
-		thermal_class = NULL;
+	result = class_register(&thermal_class);
+	if (result)
 		goto unregister_governors;
-	}
 
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)




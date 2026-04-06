Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFDA388E6C;
	Mon,  6 Apr 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492221; cv=none; b=YFawW5/jHEFhNTA7UY9shwD54oG5Nw/Iow8FbKCjESCEcRIxtYHP5j8rmlJ0XXlcu47OtHguMSMmXdIQQGLO5cAmTmSOhAL3SdaFJTtI6XtGoAciO4ZaODD1YbGyl9XhRfoL0G3igwJ0rxenHl31DXGO7pnvtlVD9wBedmgbFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492221; c=relaxed/simple;
	bh=0aGTht9VLcfiQqJkuVO6E4gQYNji+02CFFId3nTyKb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meyQD+DFDA1fLwHlPzNn//eMbug/cu2URJl0e5NP/E8MWUuKelvHdjbPsPOPP5ahHHJPMSYeTvmUfh6vYd76cayJgZRhTciK7nvt5eJCOczhikC4FY2GluwMr0Md7tIc2aAkgc1YOM2BGd+Ud/C/BkAWZuxZkHvX7yNcnhFWey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJLAEY29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJLAEY29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE64C19421;
	Mon,  6 Apr 2026 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492221;
	bh=0aGTht9VLcfiQqJkuVO6E4gQYNji+02CFFId3nTyKb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJLAEY29CnyWrS3JTRmYoCvtI5LQBnc9Unp6czsyqFAApQPaaAjDO/qjlMirn4AxY
	 GsC9RRUXBA/Fo94WaEjU11uacPTcGBoa/MwyuxMrjiEU5bw0SilHJhG9JAj+OSC1wf
	 Vy3niQB0UVErFxyfOOfaG2LK/Y/QlAJs09fwOIqMjFLxRvn1tTl3EOr4lpJeDhigCk
	 xB9X9frEqS29BfTS4NLLo5hlBqaamLzjGbMTbb396aRyboI6NuvFFdltIvPMQ67GFt
	 fa3WatczZyRAL8dy0PDiTN5Jy1MizBvnGv5VPZ/RTyTUx0nY78y/mNLRdi3LgYJ+/v
	 OAedMn2CLOtVg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v3 5/6] thermal: core: Allocate thermal_class statically
Date: Mon, 06 Apr 2026 18:14:17 +0200
Message-ID: <23090660.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5119690.31r3eYUQgx@rafael.j.wysocki>
References: <5119690.31r3eYUQgx@rafael.j.wysocki>
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
and to simplify thermal class availability checks that will need to
be carried out during the suspend and resume of thermal zones after
subsequent changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Use static variable thermal_class_unavailable (instead of a function)
     for checking if thermal_class is available.

v1 -> v2:
   * Reorder with respect to the next patch to allow the latter to be simpler
   * Add thermal_class_unavailable() (the next patch uses it too)

---
 drivers/thermal/thermal_core.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -977,7 +977,11 @@ static void thermal_release(struct devic
 	}
 }
 
-static struct class *thermal_class;
+static const struct class thermal_class = {
+	.name = "thermal",
+	.dev_release = thermal_release,
+};
+static bool thermal_class_unavailable __ro_after_init = true;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -1070,7 +1074,7 @@ __thermal_cooling_device_register(struct
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1093,7 +1097,7 @@ __thermal_cooling_device_register(struct
 	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
-	cdev->device.class = thermal_class;
+	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
@@ -1541,7 +1545,7 @@ thermal_zone_device_register_with_trips(
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1577,7 +1581,7 @@ thermal_zone_device_register_with_trips(
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = thermal_class;
+	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
@@ -1929,21 +1933,11 @@ static int __init thermal_init(void)
 	if (result)
 		goto destroy_workqueue;
 
-	thermal_class = kzalloc_obj(*thermal_class);
-	if (!thermal_class) {
-		result = -ENOMEM;
+	result = class_register(&thermal_class);
+	if (result)
 		goto unregister_governors;
-	}
 
-	thermal_class->name = "thermal";
-	thermal_class->dev_release = thermal_release;
-
-	result = class_register(thermal_class);
-	if (result) {
-		kfree(thermal_class);
-		thermal_class = NULL;
-		goto unregister_governors;
-	}
+	thermal_class_unavailable = false;
 
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)




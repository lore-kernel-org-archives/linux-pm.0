Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A073B38AF;
	Tue,  7 Apr 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571046; cv=none; b=AZz1+wdHEW7VPCmRMzfs/Q7qv1xAicCZ8oKqOLu12DQoeiYvGN3XbhVLyBkD2l1pWK6omGpnPwFrekC/eO3wglFkLQtZc0knsxTg9PtD4jUVPOvc9iAxut6ZS5ay0/GyP6dOl9Im6A6t7KOt3cAmKtCupQCtuRRZzfe2DlJWigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571046; c=relaxed/simple;
	bh=80NsqOZRmQxc9G8exRRYDZ9lBUFkq2ErbDwruhyv/TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeWHIbxDdCf62Pg6Ww/94O9cIWdd8BEX3jUgynZ1v9hDF4UbGiDW42IFBNmEtnP9VS776NlU2uYJzLo1IyCAwsGiMNdvakHMBQstsm0wKQAIJYvt+wMw9UvKztdrablwtLqDin8z/fuOpYOr9EtRUTxsA0GUtzUAUPmP824FAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk5Tq1jp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk5Tq1jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18441C116C6;
	Tue,  7 Apr 2026 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775571046;
	bh=80NsqOZRmQxc9G8exRRYDZ9lBUFkq2ErbDwruhyv/TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yk5Tq1jpvF5jGCxVFi9pvmiriW5bFJlQpv9wTgd9ggWh/D1Ri9KgMWIcbJO4yyAz4
	 Jq/6sfJBvvnYwGKLm/1d6JF5Nrh15Dy+jn8TyvxcZh5+sst1DoZ8V39GwjIFkNzCU0
	 jK4C2t+THRK+V7ugjcKPj1ZSe9EiBAbqlXLIIeJ69ZZIv1JerMFILCoS+HIiaCeIuJ
	 AcT2CRNG1C5UBJXtcUWXaSGkU0SvRI5teL0/yC0q4afuNSWEwzC+IlJom8k0hk64ZA
	 zCzCVYuL1TdIiGY8X9dbvrk+6yvp6Pd5Kd0kzI9G8Ew0iHGi1ND3r7ER5lY0sFsm3y
	 5O7RYDrGEZuoA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v4 5/6] thermal: core: Allocate thermal_class statically
Date: Tue, 07 Apr 2026 16:07:51 +0200
Message-ID: <10831981.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12871778.O9o76ZdvQC@rafael.j.wysocki>
References: <12871778.O9o76ZdvQC@rafael.j.wysocki>
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

v3 -> v4: No changes

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
@@ -979,7 +979,11 @@ static void thermal_release(struct devic
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
@@ -1072,7 +1076,7 @@ __thermal_cooling_device_register(struct
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1095,7 +1099,7 @@ __thermal_cooling_device_register(struct
 	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
-	cdev->device.class = thermal_class;
+	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
@@ -1543,7 +1547,7 @@ thermal_zone_device_register_with_trips(
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (thermal_class_unavailable)
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1579,7 +1583,7 @@ thermal_zone_device_register_with_trips(
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = thermal_class;
+	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
@@ -1928,21 +1932,11 @@ static int __init thermal_init(void)
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




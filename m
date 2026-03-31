Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F85223DE9;
	Tue, 31 Mar 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984784; cv=none; b=DsXfvyoyQgUm8X0tCWtJqWX0M3AkSa6N/JPPEdDBFampxAxzQWNYPk/bvaswqat/lCLc9Gx8CcZFJTThbOzZ6OEyLFI6d9xH12qZbYbdRj8g+b7cWlK9bauRnugNVDhfUvUhPHKgpxZwjKcoYQ5rof0hy6TMCHq5mbzJdq+CNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984784; c=relaxed/simple;
	bh=89u1sDi155+FGDfGF1Eq332TTmXb5lRvJsvSLEiSOgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6HhLtWTalk5BCuKnsgzkIrQvY8qFUukLns4pYnDfcvYNGqffMmxxgcoudaENjf4mr/JNL62tM74NErrjnmCg3MeKXsRWYdH/DSEh5jll0Boyy6sYSi7gJK655aQ9mznoOqlLSe9H1u5NxZBYvxLQdsP3HsHriqGYyXHfJlbPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHo91JQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHo91JQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1783EC19423;
	Tue, 31 Mar 2026 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984784;
	bh=89u1sDi155+FGDfGF1Eq332TTmXb5lRvJsvSLEiSOgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHo91JQJebX6EZ8xJfZcJdvk51TfGTO5on2ej3A2iPBSZVJq4BNvnvjhWLJF8cM7I
	 JdxCf2mx4tTq95nJzeTjQamgd19ayXTeJxvElCe5ldMmbm0GlLUsNE0UCfZcGyJG38
	 QLFDhDAN4tws7KOH+oRDXncos4OxzwUf9NiG4hqlFUVrHlAGvKJl3zSDndwV+hmYPI
	 /LYQXqxmFntRjvjiE047N5Lm9TBJqWyrqU+VM/RiKiTn6pJ7py139DyOooGBM3JEOV
	 dnEOFvdGlrkKIY+c675Huyrv2LyRlHWpu9oE6iT2cEj7BlnMy6ov02IYcZ7XG3xMyV
	 PxC9gGyGkmKkg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 4/4] thermal: core: Allocate thermal_class statically
Date: Tue, 31 Mar 2026 21:19:17 +0200
Message-ID: <3431854.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4745677.LvFx2qVVIh@rafael.j.wysocki>
References: <4745677.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define thermal_class as a static structure to simplify thermal_init().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -977,7 +977,10 @@ static void thermal_release(struct devic
 	}
 }
 
-static struct class *thermal_class;
+static const struct class thermal_class = {
+	.name = "thermal",
+	.dev_release = thermal_release,
+};
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
@@ -1070,7 +1073,7 @@ __thermal_cooling_device_register(struct
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (!class_is_registered(&thermal_class))
 		return ERR_PTR(-ENODEV);
 
 	cdev = kzalloc_obj(*cdev);
@@ -1094,7 +1097,7 @@ __thermal_cooling_device_register(struct
 	cdev->np = np;
 	cdev->ops = ops;
 	cdev->updated = false;
-	cdev->device.class = thermal_class;
+	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
@@ -1542,7 +1545,7 @@ thermal_zone_device_register_with_trips(
 	if (polling_delay && passive_delay > polling_delay)
 		return ERR_PTR(-EINVAL);
 
-	if (!thermal_class)
+	if (!class_is_registered(&thermal_class))
 		return ERR_PTR(-ENODEV);
 
 	tz = kzalloc_flex(*tz, trips, num_trips);
@@ -1578,7 +1581,7 @@ thermal_zone_device_register_with_trips(
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = thermal_class;
+	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
 	for_each_trip_desc(tz, td) {
@@ -1900,21 +1903,9 @@ static int __init thermal_init(void)
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
 
 	return 0;
 




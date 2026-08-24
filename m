Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647537C0FD;
	Mon, 24 Aug 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594003; cv=none; b=p2jZ1bcVGeD8NK0aajTyNDJKaR1x9YzUL2baqBhR3yPcboM+bitEXCkm9IJ8m0CjyhdZ8IpedNkWrhp15XI0/LpkfAzBGkLhVdhNDeQSASbrHXLRI4JgmjutSGhJLfL2tSJSHkvpyS6t1dj+fFW0mUhYnnv+8dayy+ixamjQ9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594003; c=relaxed/simple;
	bh=GRDPyGJmFQSjeGdiV3edsAOmBKKtu0raMpZkVG+cn3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnIpZnfTi0/lACp0Id/Pb6MANsHiqlveOT8FHLyd3PmciJEnP4gG7JlcGsBr3V52q068sVTMmuiZTGxTpLsFZpRVIoFhdE2K5kikLCJCR7Vs50getL6csQL7slssJqWX9j2nAEqhR9ID6JhiloFqv6Tz4NJZPhjSMGG/VxQ5wTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytd+dQ+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytd+dQ+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0C01F000E9;
	Mon, 24 Aug 2026 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594001;
	bh=WTkAfBdmKUZP00QvDZJnnmTAH2RKjZorIKzDQ3I0sQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ytd+dQ+gHuAoQuwbe9fL4vQQQ1OMU/YfR37+Hk4LCNv5qmdHDrGgaDHiQgUpXc0lJ
	 9OBnVOhShG3Ngvrk1DpEstcD596Sr5xXd4hNVmiGycZVRQR+vux5LEccW/mBfDptiO
	 yk36h0EZZ7oC6Vx/mFDQAWUc6nmzQ877yuCn++UDwzQvlGeAlpwiDTsbJ0sl/JE6TO
	 JbS0nmRzD9VfbOa4Plxvfqxi6YRwm4mPtI2Pv/gw0aq3nkj8cmmagGphPkoF0PvNuL
	 JRJ6x3I+EE/go0qL+bp1csmQEmjopRisv4Y5WuUJtbUUpnYGxVDOf8GtUfzW6x29No
	 YI3cIImLkPXFg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject:
 [PATCH v1 2/2] Revert "thermal/core: Allocate the thermal class dynamically"
Date: Mon, 24 Aug 2026 19:53:00 +0200
Message-ID: <4761117.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12960456.O9o76ZdvQC@rafael.j.wysocki>
References: <12960456.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

This reverts commit 34f54003643e ("thermal/core: Allocate the thermal
class dynamically") that went against driver core changes aiming at the
elimination of class_create() [1].

No intentional functional impact.

Link: https://lore.kernel.org/linux-pm/2026082411-flask-rewire-434f@gregkh/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2d9d8740491f..82e2f0d8a26d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -889,7 +889,9 @@ static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 	kfree(pos);
 }
 
-static struct class *thermal_class __ro_after_init;
+static const struct class thermal_class = {
+	.name = "thermal",
+};
 static bool thermal_class_unavailable __ro_after_init = true;
 
 static inline
@@ -1011,7 +1013,7 @@ int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdat
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->updated = false;
-	cdev->device.class = thermal_class;
+	cdev->device.class = &thermal_class;
 	cdev->device.release = thermal_cdev_release;
 	device_initialize(&cdev->device);
 	cdev->devdata = devdata;
@@ -1484,7 +1486,7 @@ thermal_zone_device_register_with_trips(const char *type,
 	if (!tz->ops.critical)
 		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->device.class = thermal_class;
+	tz->device.class = &thermal_class;
 	tz->device.release = thermal_zone_device_release;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
@@ -1790,7 +1792,6 @@ void thermal_pm_complete(void)
 
 static int __init thermal_init(void)
 {
-	struct class *tc;
 	int result;
 
 	thermal_debug_init();
@@ -1809,13 +1810,10 @@ static int __init thermal_init(void)
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
 	thermal_class_unavailable = false;
 
 	return 0;
-- 
2.51.0





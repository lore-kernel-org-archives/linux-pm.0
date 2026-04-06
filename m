Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B9388E6C;
	Mon,  6 Apr 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492218; cv=none; b=ITLcBrTQWO++NdNDwUjA3d/o1HXTr+iOGjr5o6MC62Uk4k5aA75euREwrvExCE0zka89Xkyt7pQA4eZ67ixoQQgnklNyp3liZejPx9INkwWivkA+FaVVPjlmht4DeXYJ1LbK1dGivB9CEtovy49+i44ZmG00kE/rAVt5XrcTrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492218; c=relaxed/simple;
	bh=xjCmK3YgGkdtdMkj1Kf551RrR4OGHA6SND2pBAh9lww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG6F1V7QccEi79YMtU+j8okIXMLwuyUa1KsXVqfv2Fqm6ujctwv5VlikHcZYxy37ldmCsTongSFPYhxeJzVHt73p4LIL2cUetrEniq4F1HwcZgdHk5dv3ceUzpKo9bT9KMvhslYGEpqFN7gvO9/kP8v+QsMSewsyUboe5DgmuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2/ZPfw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2/ZPfw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4385C4CEF7;
	Mon,  6 Apr 2026 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492218;
	bh=xjCmK3YgGkdtdMkj1Kf551RrR4OGHA6SND2pBAh9lww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2/ZPfw6FvxZ7TdJPgNCCKFQkv2Ljqsyr5U/qy+a5rXkt/3hfTaYSvhUIdp/GJM0t
	 r02o1QP4vgXDpmr4nBkN2kVBnquOx8M0dk9n19siLEskK/lsXYJpMViEpDTTBSFDmV
	 +K0yGREgsT30aK9yVnCnfHVffnRB9fEIF9bqQ1H3nJKQojFbVlDcuzEDj869O4563r
	 cI/h+pMoBypahaO2YkrZkHoT7/QImI7cFYbAjaAsQul6RkEKg5sj6rUPrD5O6e87JC
	 EYludlaqU7YQk1pexqkiuNhB8hOVr+sKVfFvIlzkyeL4wqZdMo2Va/f3HhvsaLmBCN
	 mHemSs/aQdvnw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v3 6/6] thermal: core: Suspend thermal zones later and resume them
 earlier
Date: Mon, 06 Apr 2026 18:16:24 +0200
Message-ID: <3715915.iIbC2pHGDl@rafael.j.wysocki>
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

To avoid some undesirable interactions between thermal zone suspend
and resume with user space that is running when those operations are
carried out, move them closer to the suspend and resume of devices,
respectively, by updating dpm_prepare() to carry out thermal zone
suspend and dpm_complete() to start thermal zone resume (that will
continue asynchronously).

This also makes the code easier to follow by removing one, arguably
redundant, level of indirection represented by the thermal PM notifier.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Rebase on top of the v3 of the previous patch

v1 -> v2:
   * Reorder with respect to the previous patch
   * Use thermal_class_unavailable() to avoid running code that should
     not run without the thermal class
   * Suspend thermal zones after disabling device probing and resume
     them before enabling device probing for better synchronization

---
 drivers/base/power/main.c      |    5 +++
 drivers/thermal/thermal_core.c |   60 ++++++++++++-----------------------------
 include/linux/thermal.h        |    6 ++++
 3 files changed, 29 insertions(+), 42 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -33,6 +33,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/devfreq.h>
+#include <linux/thermal.h>
 #include <linux/timer.h>
 #include <linux/nmi.h>
 
@@ -1282,6 +1283,8 @@ void dpm_complete(pm_message_t state)
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 
+	/* Start resuming thermal control */
+	thermal_pm_complete();
 	/* Allow device probing and trigger re-probing of deferred devices */
 	device_unblock_probing();
 	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
@@ -2225,6 +2228,8 @@ int dpm_prepare(pm_message_t state)
 	 * instead. The normal behavior will be restored in dpm_complete().
 	 */
 	device_block_probing();
+	/* Suspend thermal control. */
+	thermal_pm_prepare();
 
 	mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_list) && !error) {
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1838,7 +1838,7 @@ static void thermal_zone_pm_prepare(stru
 	cancel_delayed_work(&tz->poll_queue);
 }
 
-static void thermal_pm_notify_prepare(void)
+static void __thermal_pm_prepare(void)
 {
 	struct thermal_zone_device *tz;
 
@@ -1850,6 +1850,19 @@ static void thermal_pm_notify_prepare(vo
 		thermal_zone_pm_prepare(tz);
 }
 
+void thermal_pm_prepare(void)
+{
+	if (thermal_class_unavailable)
+		return;
+
+	__thermal_pm_prepare();
+	/*
+	 * Allow any leftover thermal work items already on the worqueue to
+	 * complete so they don't get in the way later.
+	 */
+	flush_workqueue(thermal_wq);
+}
+
 static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 {
 	guard(thermal_zone)(tz);
@@ -1866,10 +1879,13 @@ static void thermal_zone_pm_complete(str
 	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
 }
 
-static void thermal_pm_notify_complete(void)
+void thermal_pm_complete(void)
 {
 	struct thermal_zone_device *tz;
 
+	if (thermal_class_unavailable)
+		return;
+
 	guard(mutex)(&thermal_list_lock);
 
 	thermal_pm_suspended = false;
@@ -1878,41 +1894,6 @@ static void thermal_pm_notify_complete(v
 		thermal_zone_pm_complete(tz);
 }
 
-static int thermal_pm_notify(struct notifier_block *nb,
-			     unsigned long mode, void *_unused)
-{
-	switch (mode) {
-	case PM_HIBERNATION_PREPARE:
-	case PM_RESTORE_PREPARE:
-	case PM_SUSPEND_PREPARE:
-		thermal_pm_notify_prepare();
-		/*
-		 * Allow any leftover thermal work items already on the
-		 * worqueue to complete so they don't get in the way later.
-		 */
-		flush_workqueue(thermal_wq);
-		break;
-	case PM_POST_HIBERNATION:
-	case PM_POST_RESTORE:
-	case PM_POST_SUSPEND:
-		thermal_pm_notify_complete();
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static struct notifier_block thermal_pm_nb = {
-	.notifier_call = thermal_pm_notify,
-	/*
-	 * Run at the lowest priority to avoid interference between the thermal
-	 * zone resume work items spawned by thermal_pm_notify() and the other
-	 * PM notifiers.
-	 */
-	.priority = INT_MIN,
-};
-
 static int __init thermal_init(void)
 {
 	int result;
@@ -1939,11 +1920,6 @@ static int __init thermal_init(void)
 
 	thermal_class_unavailable = false;
 
-	result = register_pm_notifier(&thermal_pm_nb);
-	if (result)
-		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
-			result);
-
 	return 0;
 
 unregister_governors:
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -273,6 +273,9 @@ bool thermal_trip_is_bound_to_cdev(struc
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
+
+void thermal_pm_prepare(void);
+void thermal_pm_complete(void);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
@@ -350,6 +353,9 @@ static inline int thermal_zone_device_en
 
 static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return -ENODEV; }
+
+static inline void thermal_pm_prepare(void) {}
+static inline void thermal_pm_complete(void) {}
 #endif /* CONFIG_THERMAL */
 
 #endif /* __THERMAL_H__ */




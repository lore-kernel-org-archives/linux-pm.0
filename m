Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597691E1E12;
	Wed,  1 Apr 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055091; cv=none; b=GZ5wYdmbKXhA6pnDkHiufUNUA4dZbzF/eMn8/dVNkwpjMaefW88quIriMTU5v+d0D/hG5qXlgb76KyjqXAmQnkN31SS61G6mAcsH+nPcmknGWAYKC86b5xfmCtTIAVJqcHzjFbDLQJJg74s2FYa8A2BGyDbAiqiaEerQA015iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055091; c=relaxed/simple;
	bh=+xEGYC27pVRLV420VX5cpLnXRpjgY9rI5H26vVeXytU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+jE5dCuoZoMemNavsgeDphaoc+ybyy4lHI1MZ/42FiYTCsT1oWHVHFhyjJMcxz3EUGyD7i/N/JROKAvIXLV2Gn/bSbq3QtZQVKt4oXs80aVfuRDSdqwp0lVj3AzS4XKWE1R09aycY5Wg6d+gHFR4ISSTOTxnZk4JctCykdyI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKlVp7jC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKlVp7jC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501CDC4CEF7;
	Wed,  1 Apr 2026 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775055090;
	bh=+xEGYC27pVRLV420VX5cpLnXRpjgY9rI5H26vVeXytU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKlVp7jCBWVQi7lq1zieiOFWV/4606V4abnjQyi1rKqAdj3YoOWk2e2fu6v5kAuEj
	 svccBAm4SPttQZuBE0vPxHFfwHNVtn/Io8hD/b9/qJ1yf3yu+tP4FY+qg9d7U2X2hh
	 mpfbLdrv5vxxSaIuN4e7/zk5ZlTSfSBWgcm6MwMbGt1Q/vxMP8VjbZR+zHPDBhCMDA
	 2bprT0Ig+6WxCL0ihIKaWZmFhlkXtpH430Rh2UA7ZvB6ojTPf4tUsGvWyNAPzlurFE
	 OJ+SqFS7YzVRgZzNpAb3trMsp1ClkUMoXvkmICp463aqh8SjepIzfcfn3ecIgMCe7h
	 yO4L2Iz4p4mBg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 4/4] thermal: core: Suspend thermal zones later and resume them
 earlier
Date: Wed, 01 Apr 2026 16:51:19 +0200
Message-ID: <7952143.EvYhyI6sBW@rafael.j.wysocki>
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
+	if (thermal_class_unavailable())
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
 
+	if (thermal_class_unavailable())
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
@@ -1937,11 +1918,6 @@ static int __init thermal_init(void)
 	if (result)
 		goto unregister_governors;
 
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




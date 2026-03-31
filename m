Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A03A7837;
	Tue, 31 Mar 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984787; cv=none; b=NuzMVKyLgWyvfrv8U62XEBKTNwF3Gk1coGT/MNf/IkUOr53OgcRz7EAQnV9uujZ+KbhHEqMH0YNGyAmBlTvyswMHxSdITmu3Xv/5LNd31RH/OrnLCupaNhGNKHnfkC3p+0n/KPfHV85zs4+NtwhQFBkW8XtKi/es0NaRy0QrjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984787; c=relaxed/simple;
	bh=C4eM6maAQlXInY1KrPdyLe1rRLeVRCxjgXJ9OqOz01o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRMVpu5hi9tS4c10g5O5eD7beAuWaDu8NQ239cFqu2hZNAmfrCJbomtQvTq3iMI8CRn+CMNbyxFlp4tbd6bKeLKLSfdELbDBca1KOe6GzjVZRhbCXobXzV4BRUKY/4R5fsm7PyBOVxOywoCnV0z0k/hYlAW/mEhSRCe8/o00mr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiBGTk2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiBGTk2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8982AC19423;
	Tue, 31 Mar 2026 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984787;
	bh=C4eM6maAQlXInY1KrPdyLe1rRLeVRCxjgXJ9OqOz01o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiBGTk2pFtmUICHGNv+b3yPInsrP33uiCCzKzJiGqyUIsTUThb0cB0LuwQoLrJDyj
	 nmNexqejRld4iDOx3jpuUKt3Oqwi5JIFGItRyRmcqRDPLiY3tu6qPaqOA94iaUMBk8
	 Ni17oiLfYkzVtn3SQQaHDQnz81irY4EpwB/8yMzBC9sozHTdVEwiqFYZ3dpuYs3IFl
	 n6wPvONH8+cYPXd6S807dvzcGyudGxwR9aCxtwU1nTTmLJbsfwB3hRvoGZgra1e2w7
	 EU3qBT5JYtoImjmjxnVl1ESeMD8yvYlzwCSVHvMP//nAEWOhIeT0p8XA3K8E7qF6cx
	 fiYZkQ06ylSwg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 3/4] thermal: core: Suspend thermal zones later and resume them
 earlier
Date: Tue, 31 Mar 2026 21:18:20 +0200
Message-ID: <3059135.e9J7NaK4W3@rafael.j.wysocki>
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
 drivers/base/power/main.c      |    6 ++++
 drivers/thermal/thermal_core.c |   54 +++++++++--------------------------------
 include/linux/thermal.h        |    6 ++++
 3 files changed, 24 insertions(+), 42 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -33,6 +33,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/devfreq.h>
+#include <linux/thermal.h>
 #include <linux/timer.h>
 #include <linux/nmi.h>
 
@@ -1284,6 +1285,8 @@ void dpm_complete(pm_message_t state)
 
 	/* Allow device probing and trigger re-probing of deferred devices */
 	device_unblock_probing();
+	/* Start resuming thermal control */
+	thermal_pm_complete();
 	trace_suspend_resume(TPS("dpm_complete"), state.event, false);
 }
 
@@ -2212,6 +2215,9 @@ int dpm_prepare(pm_message_t state)
 
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
 
+	/* Suspend thermal control. */
+	thermal_pm_prepare();
+
 	/*
 	 * Give a chance for the known devices to complete their probes, before
 	 * disable probing of devices. This sync point is important at least
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1830,7 +1830,7 @@ static void thermal_zone_pm_prepare(stru
 	cancel_delayed_work(&tz->poll_queue);
 }
 
-static void thermal_pm_notify_prepare(void)
+static void __thermal_pm_prepare(void)
 {
 	struct thermal_zone_device *tz;
 
@@ -1842,6 +1842,16 @@ static void thermal_pm_notify_prepare(vo
 		thermal_zone_pm_prepare(tz);
 }
 
+void thermal_pm_prepare(void)
+{
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
@@ -1858,7 +1868,7 @@ static void thermal_zone_pm_complete(str
 	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
 }
 
-static void thermal_pm_notify_complete(void)
+void thermal_pm_complete(void)
 {
 	struct thermal_zone_device *tz;
 
@@ -1870,41 +1880,6 @@ static void thermal_pm_notify_complete(v
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
@@ -1941,11 +1916,6 @@ static int __init thermal_init(void)
 		goto unregister_governors;
 	}
 
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




Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857343F0A84;
	Thu, 26 Mar 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525537; cv=none; b=H7wa7JjshHVsbNaT7xcBG6re6OyHiz+koKA5nS6HlRNcUaO/U5YLaxUz2d5VMMLvYYg7CXXpq6AgfxlXSZOyhWRTtESJ6MS8PnIfST7K2O9qVz22LUUfGOLgylSO/NxsnwrShyTc4GBUl4JpOkfRCZw/6QtQspQbxFiniYOoB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525537; c=relaxed/simple;
	bh=RpTFMTOr9sCeTCfxlIDHoXnahzTjsBmNTYiF7UakJyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zh4S9ydVlHzsDizMSqbbWrB5L7DRrMXDfQAG9mqY+tuJD9T4TPXHj88oh4QWyaABYWbkFQCRgg1oGpa2G4G4y4yrd3F3kSfLIyvZ/7W2+DRzjNSceIubl/bqO2KYD9QCUrLH17p5oINz5/O2M+cF0WsJHhmwADlolEIBwnG7DlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmLB3BOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmLB3BOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123B6C116C6;
	Thu, 26 Mar 2026 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774525537;
	bh=RpTFMTOr9sCeTCfxlIDHoXnahzTjsBmNTYiF7UakJyU=;
	h=From:To:Cc:Subject:Date:From;
	b=MmLB3BOWXzl5Sp+CBVCRk4OBgH0NsiEqDI5dDdBis6vcGlJ813u3nBQzLsBZOauvM
	 D0KDRcOXgTmaxHsmcuk0tozU8FCF92yTcIk6iErwlUmHH2/5vjZTNuyH/3qsD8vMjS
	 OPgidN0c+6gJl5ej5Tx92YCBW8MbRJ5j5gl3OKL8zJpAkQiBfHGTQHb1WLG4QI+PyR
	 L6UbRafQztma6KWsf/MDpPHXvdFPuNweQHPEtfmbJK0HVE763Dcxs5xOhEegzMzqHm
	 thpVYaf1HFGh1wJ1fsqwe6kZviTbH/s7Qv4NQr1iNrR1K7tcBjD5coh2kOtIXjUyPk
	 mMq5ZnCtKSVpg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1] thermal: core: Address thermal zone removal races with resume
Date: Thu, 26 Mar 2026 12:45:33 +0100
Message-ID: <12876512.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since thermal_zone_pm_complete() and thermal_zone_device_resume()
reinitialize the poll_queue delayed work for the given thermal zone,
the cancel_delayed_work_sync() in thermal_zone_device_unregister()
may miss some already running work items and the thermal zone may
be freed prematurely [1].

There are two failing scenarios that both start with
running thermal_pm_notify_complete() right before invoking
thermal_zone_device_unregister() for one of the thermal zones.

In the first scenario, there is a work item already running for
the given thermal zone when thermal_pm_notify_complete() calls
thermal_zone_pm_complete() for that thermal zone and it continues to
run when thermal_zone_device_unregister() starts.  Since the poll_queue
delayed work has been reinitialized by thermal_pm_notify_complete(), the
running work item will be missed by the cancel_delayed_work_sync() in
thermal_zone_device_unregister() and if it continues to run past the
freeing of the thermal zone object, a use-after-free will occur.

In the second scenario, thermal_zone_device_resume() queued up by
thermal_pm_notify_complete() runs right after the thermal_zone_exit()
called by thermal_zone_device_unregister() has returned.  The poll_queue
delayed work is reinitialized by it before cancel_delayed_work_sync() is
called by thermal_zone_device_unregister(), so it may continue to run
after the freeing of the thermal zone object, which also leads to a
use-after-free.

Address the first failing scenario by ensuring that no thermal work
items will be running when thermal_pm_notify_complete() is called.
For this purpose, first move the cancel_delayed_work() call from
thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
new work from entering the workqueue going forward.  Next, switch
over to using a dedicated workqueue for thermal events and update
the code in thermal_pm_notify() to flush that workqueue after
thermal_pm_notify_prepare() has returned which will take care of
all leftover thermal work already on the workqueue (that leftover
work would do nothing useful anyway because all of the thermal zones
have been flagged as suspended).

The second failing scenario is addressed by adding a tz->state check
to thermal_zone_device_resume() to prevent it from reinitializing
the poll_queue delayed work if the thermal zone is going away.

Note that the above changes will also facilitate relocating the suspend
and resume of thermal zones closer to the suspend and resume of devices,
respectively.

Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
Reported-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Closes: https://lore.kernel.org/linux-pm/20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b7d706ed7ed9..248bd0a82a08 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -41,6 +41,8 @@ static struct thermal_governor *def_governor;
 
 static bool thermal_pm_suspended;
 
+static struct workqueue_struct *thermal_wq __ro_after_init;
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -313,7 +315,7 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 	if (delay > HZ)
 		delay = round_jiffies_relative(delay);
 
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
+	mod_delayed_work(thermal_wq, &tz->poll_queue, delay);
 }
 
 static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
@@ -1785,6 +1787,10 @@ static void thermal_zone_device_resume(struct work_struct *work)
 
 	guard(thermal_zone)(tz);
 
+	/* If the thermal zone is going away, there's nothing to do. */
+	if (tz->state & TZ_STATE_FLAG_EXIT)
+		return;
+
 	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
 
 	thermal_debug_tz_resume(tz);
@@ -1811,6 +1817,9 @@ static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
 	}
 
 	tz->state |= TZ_STATE_FLAG_SUSPENDED;
+
+	/* Prevent new work from getting to the workqueue subsequently. */
+	cancel_delayed_work(&tz->poll_queue);
 }
 
 static void thermal_pm_notify_prepare(void)
@@ -1829,8 +1838,6 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 {
 	guard(thermal_zone)(tz);
 
-	cancel_delayed_work(&tz->poll_queue);
-
 	reinit_completion(&tz->resume);
 	tz->state |= TZ_STATE_FLAG_RESUMING;
 
@@ -1840,7 +1847,7 @@ static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 	 */
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
 	/* Queue up the work without a delay. */
-	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
+	mod_delayed_work(thermal_wq, &tz->poll_queue, 0);
 }
 
 static void thermal_pm_notify_complete(void)
@@ -1863,6 +1870,11 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_RESTORE_PREPARE:
 	case PM_SUSPEND_PREPARE:
 		thermal_pm_notify_prepare();
+		/*
+		 * Allow any leftover thermal work items already on the
+		 * worqueue to complete so they don't get in the way later.
+		 */
+		flush_workqueue(thermal_wq);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
@@ -1895,9 +1907,14 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
+	thermal_wq = alloc_workqueue("thermal_events",
+				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	if (!thermal_wq)
+		goto unregister_netlink;
+
 	result = thermal_register_governors();
 	if (result)
-		goto unregister_netlink;
+		goto destroy_workqueue;
 
 	thermal_class = kzalloc_obj(*thermal_class);
 	if (!thermal_class) {
@@ -1924,6 +1941,8 @@ static int __init thermal_init(void)
 
 unregister_governors:
 	thermal_unregister_governors();
+destroy_workqueue:
+	destroy_workqueue(thermal_wq);
 unregister_netlink:
 	thermal_netlink_exit();
 error:
-- 
2.51.0





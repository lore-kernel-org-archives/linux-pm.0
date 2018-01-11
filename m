From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v5] PM / wakeup: Print warn if device gets enabled as wakeup source during sleep
Date: Thu, 11 Jan 2018 09:18:59 +0100
Message-ID: <1515658739-24833-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33751 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeAKITI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 03:19:08 -0500
Received: by mail-lf0-f67.google.com with SMTP id j143so1776958lfg.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2018 00:19:07 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>

In general, wakeup settings are not supposed to be changed during any of
the system wide PM phases. The reason is simply that it would break
guarantees provided by the PM core, to properly act on active wakeup
sources.

However, there are exceptions to when, in particular, disabling a device as
wakeup source makes sense. For example, in cases when a driver realizes
that its device is dead during system suspend. For these scenarios, we
don't need to care about acting on the wakeup source correctly, because a
dead device shouldn't deliver wakeup signals.

To this reasoning and to help users to properly manage wakeup settings,
let's print a warning in cases someone calls device_wakeup_enable() during
system sleep.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v5:
	- Fix build error when CONFIG_SUSPEND is unset and CONFIG_PM_SLEEP is
	set.

Changes in v4:
	- Send this as a separate change.
	- Changed from dev_warn() to dev_dbg().

---
 drivers/base/power/wakeup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index e73a081..c9dc468 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -19,6 +19,11 @@
 
 #include "power.h"
 
+#ifndef CONFIG_SUSPEND
+suspend_state_t pm_suspend_target_state;
+#define pm_suspend_target_state	(PM_SUSPEND_ON)
+#endif
+
 /*
  * If set, the suspend/hibernate code will abort transitions to a sleep state
  * if wakeup events are registered during or immediately before the transition.
@@ -268,6 +273,9 @@ int device_wakeup_enable(struct device *dev)
 	if (!dev || !dev->power.can_wakeup)
 		return -EINVAL;
 
+	if (pm_suspend_target_state != PM_SUSPEND_ON)
+		dev_dbg(dev, "don't enable as wakup source during sleep!\n");
+
 	ws = wakeup_source_register(dev_name(dev));
 	if (!ws)
 		return -ENOMEM;
-- 
2.7.4

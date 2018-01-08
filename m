From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4] PM / wakeup: Print warn if device gets enabled as wakeup source during sleep
Date: Mon,  8 Jan 2018 12:44:43 +0100
Message-ID: <1515411883-12626-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40229 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756014AbeAHLou (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jan 2018 06:44:50 -0500
Received: by mail-lf0-f68.google.com with SMTP id u84so11777521lff.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2018 03:44:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

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

Changes in v4:
	- Send this as a separate change.
	- Changed from dev_warn() to dev_dbg().

---
 drivers/base/power/wakeup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index e73a081..f30c233 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -268,6 +268,9 @@ int device_wakeup_enable(struct device *dev)
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

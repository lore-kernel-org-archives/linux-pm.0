From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 4/4] PM / wakeup: Print warn if device gets enabled as wakeup source during sleep
Date: Tue,  2 Jan 2018 17:08:53 +0100
Message-ID: <1514909333-4450-5-git-send-email-ulf.hansson@linaro.org>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
 drivers/base/power/wakeup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index b7b8b2f..272c44b 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -268,6 +268,9 @@ int device_wakeup_enable(struct device *dev)
 	if (!dev || !dev->power.can_wakeup)
 		return -EINVAL;
 
+	if (pm_suspend_target_state != PM_SUSPEND_ON)
+		dev_warn(dev, "don't enable as wakup source during sleep!\n");
+
 	ws = wakeup_source_register(dev_name(dev));
 	if (!ws)
 		return -ENOMEM;
-- 
2.7.4

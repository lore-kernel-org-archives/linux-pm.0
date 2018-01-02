From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 3/4] PM / wakeup: Add device_set_wakeup_path() helper to control wakeup path
Date: Tue,  2 Jan 2018 17:08:52 +0100
Message-ID: <1514909333-4450-4-git-send-email-ulf.hansson@linaro.org>
References: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1514909333-4450-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

During system suspend, a driver may find that the wakeup setting is enabled
for its device and therefore configures it to deliver system wakeup
signals.

Additionally, sometimes the driver and its device, relies on some further
consumed resource, like an irqchip or a phy for example, to stay powered
on, as to be able to deliver system wakeup signals.

In general the driver deals with this, via raising an "enable count" of the
consumed resource or via a subsystem specific API, like irq_set_irq_wake()
or enable|disable_irq_wake() for an irqchip. However, this may not be
sufficient in cases when the resource's device may be attached to a PM
domain (genpd for example) or is attached to a non-trivial middle layer
(PCI for example).

To address cases like these, the existing ->dev.power.wakeup_path status
flag is there to help. As a matter of fact, genpd already monitors the flag
during system suspend and acts accordingly.

However, so far it has not been clear, if anybody else but the PM core is
allowed to set the ->dev.power.wakeup_path status flag, which is required
to make this work. For this reason, let's introduce a new helper function,
device_set_wakeup_path().

Typically a driver that manages a resource needed in the wakeup path,
should call device_set_wakeup_path() from its ->suspend() or
->suspend_late() callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_wakeup.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 4c2cba7..4238dde 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -88,6 +88,11 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && !!dev->power.wakeup;
 }
 
+static inline void device_set_wakeup_path(struct device *dev)
+{
+	dev->power.wakeup_path = true;
+}
+
 /* drivers/base/power/wakeup.c */
 extern void wakeup_source_prepare(struct wakeup_source *ws, const char *name);
 extern struct wakeup_source *wakeup_source_create(const char *name);
@@ -174,6 +179,8 @@ static inline bool device_may_wakeup(struct device *dev)
 	return dev->power.can_wakeup && dev->power.should_wakeup;
 }
 
+static inline void device_set_wakeup_path(struct device *dev) {}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}
-- 
2.7.4

From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/6] PM / Wakeup: Add wakeup_source_available()
Date: Mon, 20 Feb 2017 21:33:25 +0100
Message-ID: <1487622809-25127-3-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a helper function to find out if any wake-up sources have been
registered.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/wakeup.c | 8 ++++++++
 include/linux/pm_wakeup.h   | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index f546f8f107b06a45..1cf8320ed1a67dc4 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -232,6 +232,14 @@ void wakeup_source_unregister(struct wakeup_source *ws)
 EXPORT_SYMBOL_GPL(wakeup_source_unregister);
 
 /**
+ * wakeup_source_available - Check if any wakeup sources have been registered
+ */
+bool wakeup_source_available(void)
+{
+	return !list_empty(&wakeup_sources);
+}
+
+/**
  * device_wakeup_attach - Attach a wakeup source object to a device object.
  * @dev: Device to handle.
  * @ws: Wakeup source object to attach to @dev.
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index a3447932df1ff0a0..c5eaa8dbf27033df 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -97,6 +97,7 @@ extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
 extern struct wakeup_source *wakeup_source_register(const char *name);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
+extern bool wakeup_source_available(void);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
 extern void device_set_wakeup_capable(struct device *dev, bool capable);
@@ -144,6 +145,8 @@ static inline struct wakeup_source *wakeup_source_register(const char *name)
 
 static inline void wakeup_source_unregister(struct wakeup_source *ws) {}
 
+static inline bool wakeup_source_available(void) { return false; }
+
 static inline int device_wakeup_enable(struct device *dev)
 {
 	dev->power.should_wakeup = true;
-- 
2.7.4

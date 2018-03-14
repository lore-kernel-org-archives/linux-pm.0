From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Wed, 14 Mar 2018 12:26:24 +0100
Message-ID: <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a callback to inform a device that his wake-up setting has been
changed.  This allows a device to synchronize device configuration with
an external user action.

E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
switch, the system suspend procedure is:
  1. Configure PMIC for DDR backup mode, which changes the role of the
     accessory power switch from a power to a wake-up switch,
  2. Switch accessory power switch off, to prepare for system suspend,
  3. Suspend system.

Hence step 1 cannot be done in the PMIC's suspend callback, but it can
be done in the new callback, in response to the user writing "enabled"
to the PMIC's wakeup virtual file in sysfs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Is there a better way to handle this?
---
 drivers/base/power/wakeup.c | 4 ++++
 include/linux/pm.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621ed769ab26..40bda13d4dcd36f3 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -256,6 +256,8 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 	if (dev->power.wakeirq)
 		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
+	if (dev->power.wakeup_change_notify)
+		dev->power.wakeup_change_notify(dev, true);
 	return 0;
 }
 
@@ -373,6 +375,8 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
 {
 	struct wakeup_source *ws;
 
+	if (dev->power.wakeup_change_notify)
+		dev->power.wakeup_change_notify(dev, false);
 	spin_lock_irq(&dev->power.lock);
 	ws = dev->power.wakeup;
 	dev->power.wakeup = NULL;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d835706f2..3dec274bffffc6f8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -599,6 +599,7 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	void (*wakeup_change_notify)(struct device *dev, bool enable);
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-- 
2.7.4

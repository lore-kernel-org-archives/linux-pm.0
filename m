From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Tue, 19 Jun 2018 15:55:17 +0200
Message-ID: <20180619135518.8990-2-geert+renesas@glider.be>
References: <20180619135518.8990-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619135518.8990-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a callback to inform a device that its wake-up setting has been
changed.  This allows a device to synchronize device configuration with
an external user action.

E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
switch, the system suspend/resume procedure is:
  1. Configure PMIC for DDR backup mode (by software), which changes the
     role of the accessory power switch from a power to a wake-up
     switch,
  2. Switch accessory power switch off (manually), to prepare for system
     suspend,
  3. Suspend system (by software),
  4. Switch accessory power switch on (manually), to wake up the system.

As step 2 involves a manual operation, step 1 cannot be combined
with step 3 and performed in the PMIC's suspend callback (unlike on
systems with a momentary power switch).

Adding the new callback allows to move step 1 to the new callback, to be
performed in response to the user writing "enabled" to the PMIC's
"wakeup" virtual file in sysfs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Is there a better way to handle this?

Currently step 1 is done in userspace using i2set, which is very
user-unfriendly
(https://elinux.org/R-Car/Boards/Salvator-XS#PSCI_System_Suspend).

v2:
  - Improve patch description.
---
 drivers/base/power/wakeup.c | 4 ++++
 include/linux/pm.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5fa1898755a34878..933560d658692fe3 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -255,6 +255,8 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 	if (dev->power.wakeirq)
 		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
+	if (dev->power.wakeup_change_notify)
+		dev->power.wakeup_change_notify(dev, true);
 	return 0;
 }
 
@@ -372,6 +374,8 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
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
2.17.1

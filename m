From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mfd: axp20x: Add a 500ms delay at the end of axp20x_power_off
Date: Sun,  5 Jun 2016 15:50:48 +0200
Message-ID: <1465134648-27113-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The kernel expects the power_off function to not return, and if it does
it panics. At a slight delay after the i2c write which turns off power
through the pmic, to give capacitors etc. some time to drain.

Without this the kernel lives on long enough after the poweroff to
print the following on the serial console on my Mele A1000G quad:

[  248.583588] reboot: Power down
[  248.600490] Kernel pa

With the delay the start of printing "Kernel panic" is gone.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mfd/axp20x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 6364dab..fd80b09 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -677,6 +678,9 @@ static void axp20x_power_off(void)
 
 	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
 		     AXP20X_OFF);
+
+	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
+	msleep(500);
 }
 
 int axp20x_match_device(struct axp20x_dev *axp20x)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

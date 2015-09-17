From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 09/26] ARM: pxa: magician: Optimize powerup delays for
 Samsung LCD
Date: Thu, 17 Sep 2015 06:57:35 +0200
Message-ID: <55FA483F.1040202@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:37068 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbbIQE5n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 00:57:43 -0400
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Delays for the Samsung LCD are greater than needed. These values were
extracted from a datasheet.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index d78fc3a..14d1f55 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -366,21 +366,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
 		else
 			gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
-		mdelay(10);
+		mdelay(6);
 		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
-		mdelay(10);
+		mdelay(6);	/* Avdd -> Voff >5ms */
 		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
-		mdelay(30);
+		mdelay(16);	/* Voff -> Von >(5+10)ms */
 		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
-		mdelay(10);
 	} else {
-		mdelay(10);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
-		mdelay(30);
+		mdelay(16);
 		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
-		mdelay(10);
+		mdelay(6);
 		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
-		mdelay(10);
+		mdelay(6);
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
 		else
-- 
1.7.12.1


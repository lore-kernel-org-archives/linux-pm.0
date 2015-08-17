From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 15/21] ARM: pxa: magician: Fix PWM backlight regulator
Date: Tue, 18 Aug 2015 00:03:54 +0200
Message-ID: <55D25A4A.4070409@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Fix PWM backlight regulator. It is requested from pwm_backlight_probe().

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index d17125e..2ec630e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -542,6 +542,14 @@ static struct platform_device pwm_backlight = {
 };
 
 /*
+ * fixed regulator for pwm_backlight
+ */
+
+static struct regulator_consumer_supply pwm_backlight_supply[] = {
+	REGULATOR_SUPPLY("power", "pwm_backlight"),
+};
+
+/*
  * LEDs
  */
 
@@ -1352,6 +1360,9 @@ static void __init magician_init(void)
 	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
 
 	pxa_set_camera_info(&magician_pxacamera_pdata);
+
+	regulator_register_always_on(0, "power", pwm_backlight_supply,
+		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1

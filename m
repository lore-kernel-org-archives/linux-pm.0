From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 11/26] ARM: pxa: magician: Optimize EGPIO initial values
Date: Thu, 17 Sep 2015 06:58:24 +0200
Message-ID: <55FA4870.7040907@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch optimizes initial values of the EGPIO chip driver.

GSM and sound should be powered off during boot. A weak accumulator and
a powered GSM sometimes cause a system reboot. A charging current should be
as high as possible during boot.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 2c487ae..bf0760e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -263,9 +263,12 @@ static struct htc_egpio_chip egpio_chips[] = {
 		.num_gpios	= 24,
 		.direction	= HTC_EGPIO_OUTPUT,
 		/*
-		 * Depends on modules configuration
+		 * NOTICE LCD valid power on sequence
+		 * Disable GSM and sound
+		 * Low accu can cause reboot, set 500mA charging
+		 * OR 0x8000 for LCD backlight (debug printks)
 		 */
-		.initial_values	= 0x40,
+		.initial_values	= 0x2020c0,
 	},
 	[1] = {
 		.reg_start	= 4,
-- 
1.7.12.1

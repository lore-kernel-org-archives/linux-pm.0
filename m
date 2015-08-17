From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 21/21] ARM: pxa: magician: Move platform_add_devices() to
 the end of magician_init()
Date: Tue, 18 Aug 2015 00:07:03 +0200
Message-ID: <55D25B07.1080703@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50676 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbbHQWEK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 18:04:10 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move platform_add_devices() to the end of magician_init() for better
clarity of code.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 5f02ce4..af86350 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -1355,9 +1355,8 @@ static void __init magician_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	platform_add_devices(ARRAY_AND_SIZE(devices));
-
 	pxa_set_ficp_info(&magician_ficp_info);
+
 	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
 	i2c_register_board_info(0,
@@ -1394,6 +1393,8 @@ static void __init magician_init(void)
 
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
+
+	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1


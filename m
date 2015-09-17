From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 05/26] ARM: pxa: magician: Change description of LCD power
 GPIO
Date: Thu, 17 Sep 2015 06:55:50 +0200
Message-ID: <55FA47D6.1020309@tul.cz>
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

This patch changes the description of the LCD power GPIO to be more
specific.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 1bac785..a93ed14 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -773,7 +773,7 @@ static void __init magician_init(void)
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
 		if (lcd_select && (system_rev < 3))
 			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
-				GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
+				GPIOF_OUT_INIT_LOW, "Samsung LCD Power");
 		pxa_set_fb_info(NULL,
 			lcd_select ? &samsung_info : &toppoly_info);
 	} else
-- 
1.7.12.1

From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 03/26] ARM: pxa: magician: Print more specific error
 message for global GPIOs
Date: Thu, 17 Sep 2015 06:55:21 +0200
Message-ID: <55FA47B9.8070009@tul.cz>
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

Print more specific error message for global GPIOs.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index c8fa379..29d8146 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -752,7 +752,7 @@ static void __init magician_init(void)
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(magician_pin_config));
 	err = gpio_request_array(ARRAY_AND_SIZE(magician_global_gpios));
 	if (err)
-		pr_err("magician: Failed to request GPIOs: %d\n", err);
+		pr_err("magician: Failed to request global GPIOs: %d\n", err);
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
-- 
1.7.12.1

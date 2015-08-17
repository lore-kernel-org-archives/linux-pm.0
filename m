From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 14/21] ARM: pxa: magician: Fix PXA USB OHCI port enable
 flags
Date: Tue, 18 Aug 2015 00:03:28 +0200
Message-ID: <55D25A30.9000002@tul.cz>
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

Fix PXA USB OHCI port enable flags.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 50c5325..d17125e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -1065,8 +1065,10 @@ static struct platform_device magician_audio_device = {
 
 static struct pxaohci_platform_data magician_ohci_info = {
 	.port_mode	= PMM_PERPORT_MODE,
-	.flags		= ENABLE_PORT1 | ENABLE_PORT3 | POWER_CONTROL_LOW,
+	/* port1: CSR Bluetooth, port2: OTG with UDC */
+	.flags		= ENABLE_PORT1 | ENABLE_PORT2 | POWER_CONTROL_LOW,
 	.power_budget	= 0,
+	.power_on_delay = 100,
 };
 
 /*
-- 
1.7.12.1

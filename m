From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 06/26] ARM: pxa: magician: Add new discovered EGPIO pins
Date: Thu, 17 Sep 2015 06:56:28 +0200
Message-ID: <55FA47FC.30808@tul.cz>
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

This patch adds EGPIO pins: Infra transceiver power, NiCD charging and
inserted charger cable.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/include/mach/magician.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index a88f551..88da10e 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -98,10 +98,11 @@
 #define EGPIO_MAGICIAN_BL_POWER	MAGICIAN_EGPIO(1, 7)
 #define EGPIO_MAGICIAN_SD_POWER	MAGICIAN_EGPIO(2, 0)
 #define EGPIO_MAGICIAN_CARKIT_MIC	MAGICIAN_EGPIO(2, 1)
-#define EGPIO_MAGICIAN_UNKNOWN_WAVEDEV_DLL	MAGICIAN_EGPIO(2, 2)
+#define EGPIO_MAGICIAN_IR_RX_SHUTDOWN	MAGICIAN_EGPIO(2, 2)
 #define EGPIO_MAGICIAN_FLASH_VPP	MAGICIAN_EGPIO(2, 3)
 #define EGPIO_MAGICIAN_BL_POWER2	MAGICIAN_EGPIO(2, 4)
 #define EGPIO_MAGICIAN_BQ24022_ISET2	MAGICIAN_EGPIO(2, 5)
+#define EGPIO_MAGICIAN_NICD_CHARGE	MAGICIAN_EGPIO(2, 6)
 #define EGPIO_MAGICIAN_GSM_POWER	MAGICIAN_EGPIO(2, 7)
 
 /* input */
@@ -116,5 +117,7 @@
 #define EGPIO_MAGICIAN_nSD_READONLY	MAGICIAN_EGPIO(5, 4)
 
 #define EGPIO_MAGICIAN_EP_INSERT	MAGICIAN_EGPIO(6, 1)
+/* FIXME behaves like (4,1), may differ for host/device */
+#define EGPIO_MAGICIAN_CABLE_INSERTED	MAGICIAN_EGPIO(6, 4)
 
 #endif /* _MAGICIAN_H_ */
-- 
1.7.12.1

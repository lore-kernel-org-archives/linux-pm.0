From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] thermal: imx_thermal: add module device table
Date: Wed, 30 Oct 2013 23:56:03 +0000
Message-ID: <E1VbfcJ-0003g5-SK@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the module device table declaration so the module can be loaded
automatically at boot time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/thermal/imx_thermal.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1d6c801c1eb9..ab31552f0360 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -539,3 +539,4 @@ MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("Thermal driver for Freescale i.MX SoCs");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:imx-thermal");
+MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
-- 
1.7.4.4

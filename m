From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] thermal: imx_thermal: add module device table
Date: Mon, 16 Dec 2013 21:50:04 +0000
Message-ID: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
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
To: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the module device table declaration so the module can be loaded
automatically at boot time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/thermal/imx_thermal.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1d6c801c1eb9..230864886775 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -522,6 +522,7 @@ static const struct of_device_id of_imx_thermal_match[] = {
 	{ .compatible = "fsl,imx6q-tempmon", },
 	{ /* end */ }
 };
+MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 
 static struct platform_driver imx_thermal = {
 	.driver = {
-- 
1.7.4.4

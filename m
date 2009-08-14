From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/05] i2c: Runtime PM for SuperH Mobile I2C
Date: Fri, 14 Aug 2009 19:48:59 +0900
Message-ID: <20090814104859.32396.79162.sendpatchset__9696.70958952538$1250247261$gmane$org@rx1.opensource.se>
References: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies the SuperH Mobile I2C driver to support
Runtime PM. These changes is all that is needed for proper
Runtime PM support in this driver. Driver callbacks for
Runtime PM are empty because the device registers are always
re-initialized after pm_runtime_get_sync().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes from V2:
 - none

 Changes from V1:
 - use pm_runtime_get_sync() and pm_runtime_put_sync()
 - use pm_runtime_disable()
 - implement nop runtime pm functions for dev_pm_ops
 - no need for pm_runtime_set_suspended()

 drivers/i2c/busses/i2c-sh_mobile.c |   39 ++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2009-07-31 00:55:42.000000000 +0900
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -165,7 +166,8 @@ static void activate_ch(struct sh_mobile
 	u_int32_t denom;
 	u_int32_t tmp;
 
-	/* Make sure the clock is enabled */
+	/* Wake up device and enable clock */
+	pm_runtime_get_sync(pd->dev);
 	clk_enable(pd->clk);
 
 	/* Get clock rate after clock is enabled */
@@ -213,8 +215,9 @@ static void deactivate_ch(struct sh_mobi
 	/* Disable channel */
 	iowrite8(ioread8(ICCR(pd)) & ~ICCR_ICE, ICCR(pd));
 
-	/* Disable clock */
+	/* Disable clock and mark device as idle */
 	clk_disable(pd->clk);
+	pm_runtime_put_sync(pd->dev);
 }
 
 static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
@@ -572,6 +575,19 @@ static int sh_mobile_i2c_probe(struct pl
 		goto err_irq;
 	}
 
+	/* Enable Runtime PM for this device.
+	 *
+	 * Also tell the Runtime PM core to ignore children
+	 * for this device since it is valid for us to suspend
+	 * this I2C master driver even though the slave devices
+	 * on the I2C bus may not be suspended.
+	 *
+	 * The state of the I2C hardware bus is unaffected by
+	 * the Runtime PM state.
+	 */
+	pm_suspend_ignore_children(&dev->dev, true);
+	pm_runtime_enable(&dev->dev);
+
 	/* setup the private data */
 	adap = &pd->adap;
 	i2c_set_adapdata(adap, pd);
@@ -614,14 +630,33 @@ static int sh_mobile_i2c_remove(struct p
 	iounmap(pd->reg);
 	sh_mobile_i2c_hook_irqs(dev, 0);
 	clk_put(pd->clk);
+	pm_runtime_disable(&dev->dev);
 	kfree(pd);
 	return 0;
 }
 
+static int sh_mobile_i2c_runtime_nop(struct device *dev)
+{
+	/* Runtime PM callback shared between ->runtime_suspend()
+	 * and ->runtime_resume(). Simply returns success.
+	 *
+	 * This driver re-initializes all registers after
+	 * pm_runtime_get_sync() anyway so there is no need
+	 * to save and restore registers here.
+	 */
+	return 0;
+}
+
+static struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
+	.runtime_suspend = sh_mobile_i2c_runtime_nop,
+	.runtime_resume = sh_mobile_i2c_runtime_nop,
+};
+
 static struct platform_driver sh_mobile_i2c_driver = {
 	.driver		= {
 		.name		= "i2c-sh_mobile",
 		.owner		= THIS_MODULE,
+		.pm		= &sh_mobile_i2c_dev_pm_ops,
 	},
 	.probe		= sh_mobile_i2c_probe,
 	.remove		= sh_mobile_i2c_remove,

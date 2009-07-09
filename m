From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/06] i2c: Runtime PM for i2c-sh_mobile.c
Date: Fri, 10 Jul 2009 00:20:11 +0900
Message-ID: <20090709152011.8385.40046.sendpatchset__17157.7315930792$1247153095$gmane$org@rx1.opensource.se>
References: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
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

This patch modifies the SuperH Mobile i2c driver to support
Runtime PM. These changes should be all that is needed for
proper Runtime PM support in this driver. Driver callbacks
for Runtime PM are not needed becuase the registers are
always re-initialized.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/i2c/busses/i2c-sh_mobile.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2009-07-07 18:50:53.000000000 +0900
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -165,6 +166,9 @@ static void activate_ch(struct sh_mobile
 	u_int32_t denom;
 	u_int32_t tmp;
 
+	/* Runtime PM must wake up device */
+	pm_runtime_resume(pd->dev);
+
 	/* Make sure the clock is enabled */
 	clk_enable(pd->clk);
 
@@ -215,6 +219,9 @@ static void deactivate_ch(struct sh_mobi
 
 	/* Disable clock */
 	clk_disable(pd->clk);
+
+	/* Runtime PM code may suspend now */
+	pm_runtime_suspend(pd->dev);
 }
 
 static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
@@ -572,6 +579,20 @@ static int sh_mobile_i2c_probe(struct pl
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
+	pm_runtime_set_suspended(&dev->dev);
+	pm_runtime_enable(&dev->dev);
+
 	/* setup the private data */
 	adap = &pd->adap;
 	i2c_set_adapdata(adap, pd);

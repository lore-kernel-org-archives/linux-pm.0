From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/07] i2c: rework i2c-pxa
	suspend_late()/resume_early()
Date: Wed, 24 Jun 2009 18:23:42 +0900
Message-ID: <20090624092342.14276.2946.sendpatchset__13350.8326056928$1245836116$gmane$org@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, akpm@linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for i2c-pxa from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- 0001/drivers/i2c/busses/i2c-pxa.c
+++ work/drivers/i2c/busses/i2c-pxa.c	2009-06-01 15:26:06.000000000 +0900
@@ -1135,35 +1135,44 @@ static int __exit i2c_pxa_remove(struct 
 }
 
 #ifdef CONFIG_PM
-static int i2c_pxa_suspend_late(struct platform_device *dev, pm_message_t state)
+static int i2c_pxa_suspend_noirq(struct device *dev)
 {
-	struct pxa_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
+
 	clk_disable(i2c->clk);
+
 	return 0;
 }
 
-static int i2c_pxa_resume_early(struct platform_device *dev)
+static int i2c_pxa_resume_noirq(struct device *dev)
 {
-	struct pxa_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
 	clk_enable(i2c->clk);
 	i2c_pxa_reset(i2c);
 
 	return 0;
 }
+
+static struct dev_pm_ops i2c_pxa_dev_pm_ops = {
+	.suspend_noirq = i2c_pxa_suspend_noirq,
+	.resume_noirq = i2c_pxa_resume_noirq,
+};
+
+#define I2C_PXA_DEV_PM_OPS (&i2c_pxa_dev_pm_ops)
 #else
-#define i2c_pxa_suspend_late NULL
-#define i2c_pxa_resume_early NULL
+#define I2C_PXA_DEV_PM_OPS NULL
 #endif
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
 	.remove		= __exit_p(i2c_pxa_remove),
-	.suspend_late	= i2c_pxa_suspend_late,
-	.resume_early	= i2c_pxa_resume_early,
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
+		.pm	= I2C_PXA_DEV_PM_OPS,
 	},
 	.id_table	= i2c_pxa_id_table,
 };

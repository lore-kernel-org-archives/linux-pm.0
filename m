From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/07] dma: rework txx9dmac
	suspend_late()/resume_early()
Date: Fri, 05 Jun 2009 16:55:04 +0900
Message-ID: <20090605075504.14756.68449.sendpatchset__36377.6729246185$1244189196$gmane$org@rx1.opensource.se>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
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
Cc: hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, gregkh@suse.de, ben-linux@fluff.org, felipe.balbi@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for txx9dmac from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles fine.

 drivers/dma/txx9dmac.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- 0001/drivers/dma/txx9dmac.c
+++ work/drivers/dma/txx9dmac.c	2009-06-01 16:34:23.000000000 +0900
@@ -1287,17 +1287,18 @@ static void txx9dmac_shutdown(struct pla
 	txx9dmac_off(ddev);
 }
 
-static int txx9dmac_suspend_late(struct platform_device *pdev,
-				 pm_message_t mesg)
+static int txx9dmac_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 
 	txx9dmac_off(ddev);
 	return 0;
 }
 
-static int txx9dmac_resume_early(struct platform_device *pdev)
+static int txx9dmac_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 	struct txx9dmac_platform_data *pdata = pdev->dev.platform_data;
 	u32 mcr;
@@ -1310,6 +1311,11 @@ static int txx9dmac_resume_early(struct 
 
 }
 
+static struct dev_pm_ops txx9dmac_dev_pm_ops = {
+	.suspend_noirq = txx9dmac_suspend_noirq,
+	.resume_noirq = txx9dmac_resume_noirq,
+};
+
 static struct platform_driver txx9dmac_chan_driver = {
 	.remove		= __exit_p(txx9dmac_chan_remove),
 	.driver = {
@@ -1320,10 +1326,9 @@ static struct platform_driver txx9dmac_c
 static struct platform_driver txx9dmac_driver = {
 	.remove		= __exit_p(txx9dmac_remove),
 	.shutdown	= txx9dmac_shutdown,
-	.suspend_late	= txx9dmac_suspend_late,
-	.resume_early	= txx9dmac_resume_early,
 	.driver = {
 		.name	= "txx9dmac",
+		.pm	= &txx9dmac_dev_pm_ops,
 	},
 };
 

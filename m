From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [RFC/PATCH 3/3] usb/xhci-plat: remove unnecessary #ifdef checks for CONFIG_PM_SLEEP
Date: Thu, 12 Dec 2013 21:18:25 -0800
Message-ID: <1386911905-2366-4-git-send-email-david.a.cohen@linux.intel.com>
References: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, rjw@rjwysocki.net, len.brown@intel.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, santosh.shilimkar@ti.com, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Drivers using SET_*_PM_OPS() no longer need to #ifdef for CONFIG_PM_*
So, let's remove the unnecessary #ifdef's.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
---
 drivers/usb/host/xhci-plat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d9c169f470d3..b1d93c344e04 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -197,7 +197,6 @@ static int xhci_plat_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int xhci_plat_suspend(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
@@ -217,10 +216,6 @@ static int xhci_plat_resume(struct device *dev)
 static const struct dev_pm_ops xhci_plat_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
 };
-#define DEV_PM_OPS	(&xhci_plat_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
 
 #ifdef CONFIG_OF
 static const struct of_device_id usb_xhci_of_match[] = {
@@ -235,7 +230,7 @@ static struct platform_driver usb_xhci_driver = {
 	.remove	= xhci_plat_remove,
 	.driver	= {
 		.name = "xhci-hcd",
-		.pm = DEV_PM_OPS,
+		.pm = &xhci_plat_pm_ops,
 		.of_match_table = of_match_ptr(usb_xhci_of_match),
 	},
 };
-- 
1.8.4.2

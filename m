From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] PM: kill dev_pm_ops platform warning for now
Date: Fri, 07 Aug 2009 17:34:30 +0900
Message-ID: <20090807083430.31389.98825.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove the platform device runtime dev_pm_ops warning
for now. No point in upsetting users of non-rc kernels.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Suitable for 2.6.31-rc.

 drivers/base/platform.c |    3 ---
 1 file changed, 3 deletions(-)

--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-08-07 12:37:04.000000000 +0900
@@ -483,9 +483,6 @@ int platform_driver_register(struct plat
 		drv->driver.remove = platform_drv_remove;
 	if (drv->shutdown)
 		drv->driver.shutdown = platform_drv_shutdown;
-	if (drv->suspend || drv->resume)
-		pr_warning("Platform driver '%s' needs updating - please use "
-			"dev_pm_ops\n", drv->driver.name);
 
 	return driver_register(&drv->driver);
 }

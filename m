From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: kill dev_pm_ops platform warning for now
Date: Sat, 8 Aug 2009 15:16:23 +0200
Message-ID: <200908081516.24018.rjw__29413.5490469218$1249737446$gmane$org@sisk.pl>
References: <20090807083430.31389.98825.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807083430.31389.98825.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>, Greg KH <gregkh@suse.de>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 07 August 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Remove the platform device runtime dev_pm_ops warning
> for now. No point in upsetting users of non-rc kernels.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Thanks for the patch, I modified the changelog a bit.

Greg, do you agree with the patch below?

Rafael

---
From: Magnus Damm <damm@igel.co.jp>
Subject: PM / Driver Core: Kill dev_pm_ops platform warning for now

Commit 783ea7d4eeefe895f2731fe73ac951e94418927b
(Driver Core: Rework platform suspend/resume, print warning)
added a warning message printed for platform drivers that use the
legacy PM callbacks rather than struct dev_pm_ops.  Unfortunately,
this resulted in some confusion and made some people try to convert
drivers by replacing the old callbacks with struct dev_pm_ops in
automatic way, which generally is not a good idea.

Remove the platform device runtime dev_pm_ops warning for now,
because it's annoying to users and it's not really necessary right
now.

[rjw: Modified the changelog to be more informative.]

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/platform.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/drivers/base/platform.c
===================================================================
--- linux-2.6.orig/drivers/base/platform.c
+++ linux-2.6/drivers/base/platform.c
@@ -483,9 +483,6 @@ int platform_driver_register(struct plat
 		drv->driver.remove = platform_drv_remove;
 	if (drv->shutdown)
 		drv->driver.shutdown = platform_drv_shutdown;
-	if (drv->suspend || drv->resume)
-		pr_warning("Platform driver '%s' needs updating - please use "
-			"dev_pm_ops\n", drv->driver.name);
 
 	return driver_register(&drv->driver);
 }

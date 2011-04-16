From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/9] PM / Platform: Use generic runtime PM
	callbacks directly
Date: Sun, 17 Apr 2011 01:38:53 +0200
Message-ID: <201104170138.54163.rjw__14018.9157719307$1302997556$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104170135.19388.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Once shmobile platforms have been converted to using power domains
for overriding the platform bus type's PM callbacks, it isn't
necessary to use the __weakly defined wrappers around the generinc
runtime PM callbacks in the platform bus type any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/platform.c |   31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/base/platform.c
===================================================================
--- linux-2.6.orig/drivers/base/platform.c
+++ linux-2.6/drivers/base/platform.c
@@ -900,36 +900,11 @@ int platform_pm_restore_noirq(struct dev
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
-#ifdef CONFIG_PM_RUNTIME
-
-int __weak platform_pm_runtime_suspend(struct device *dev)
-{
-	return pm_generic_runtime_suspend(dev);
-};
-
-int __weak platform_pm_runtime_resume(struct device *dev)
-{
-	return pm_generic_runtime_resume(dev);
-};
-
-int __weak platform_pm_runtime_idle(struct device *dev)
-{
-	return pm_generic_runtime_idle(dev);
-};
-
-#else /* !CONFIG_PM_RUNTIME */
-
-#define platform_pm_runtime_suspend NULL
-#define platform_pm_runtime_resume NULL
-#define platform_pm_runtime_idle NULL
-
-#endif /* !CONFIG_PM_RUNTIME */
-
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	USE_PLATFORM_PM_SLEEP_OPS,
-	.runtime_suspend = platform_pm_runtime_suspend,
-	.runtime_resume = platform_pm_runtime_resume,
-	.runtime_idle = platform_pm_runtime_idle,
+	.runtime_suspend = pm_generic_runtime_suspend,
+	.runtime_resume = pm_generic_runtime_resume,
+	.runtime_idle = pm_generic_runtime_idle,
 };
 
 struct bus_type platform_bus_type = {

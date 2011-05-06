From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Wakeup: Fix build warning related to the
	"wakeup" sysfs file
Date: Sat, 7 May 2011 00:50:55 +0200
Message-ID: <201105070050.55235.rjw__40688.4487405934$1304722268$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The "wakeup" device sysfs file is only created if CONFIG_PM_SLEEP
is set, so put it under CONFIG_PM_SLEEP and make a build warning
related to it go away.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/sysfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/base/power/sysfs.c
+++ linux-2.6/drivers/base/power/sysfs.c
@@ -212,8 +212,9 @@ static ssize_t autosuspend_delay_ms_stor
 static DEVICE_ATTR(autosuspend_delay_ms, 0644, autosuspend_delay_ms_show,
 		autosuspend_delay_ms_store);
 
-#endif
+#endif /* CONFIG_PM_RUNTIME */
 
+#ifdef CONFIG_PM_SLEEP
 static ssize_t
 wake_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
@@ -248,7 +249,6 @@ wake_store(struct device * dev, struct d
 
 static DEVICE_ATTR(wakeup, 0644, wake_show, wake_store);
 
-#ifdef CONFIG_PM_SLEEP
 static ssize_t wakeup_count_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {

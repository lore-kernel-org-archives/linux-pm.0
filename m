From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM / Wakeup: Make pm_save_wakeup_count()
	work as documented
Date: Tue, 25 Jan 2011 01:15:33 +0100
Message-ID: <201101250115.34088.rjw__33083.1482810483$1295914681$gmane$org@sisk.pl>
References: <201101250112.40350.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101250112.40350.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

According to Documentation/ABI/testing/sysfs-power, the
/sys/power/wakeup_count interface should only make the kernel react
to wakeup events during suspend if the last write to it has been
successful.  However, if /sys/power/wakeup_count is written to two
times in a row, where the first write is successful and the second
is not, the kernel will still react to wakeup events during suspend
due to a bug in pm_save_wakeup_count().

Fix the bug by making pm_save_wakeup_count() clear
events_check_enabled unconditionally before checking if there are
any new wakeup events registered since the previous read from
/sys/power/wakeup_count.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/wakeup.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/base/power/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/base/power/wakeup.c
+++ linux-2.6/drivers/base/power/wakeup.c
@@ -644,23 +644,22 @@ bool pm_get_wakeup_count(unsigned int *c
  *
  * If @count is equal to the current number of registered wakeup events and the
  * current number of wakeup events being processed is zero, store @count as the
- * old number of registered wakeup events to be used by pm_check_wakeup_events()
- * and return true.  Otherwise return false.
+ * old number of registered wakeup events for pm_check_wakeup_events(), enable
+ * wakeup events detection and return 'true'.  Otherwise disable wakeup events
+ * detection and return 'false'.
  */
 bool pm_save_wakeup_count(unsigned int count)
 {
-	bool ret = false;
-
+	events_check_enabled = false;
 	spin_lock_irq(&events_lock);
 	if (!__pm_wakeup_pending(count)) {
 		saved_count = count;
 		events_check_enabled = true;
-		ret = true;
 	}
 	spin_unlock_irq(&events_lock);
-	if (!ret)
+	if (!events_check_enabled)
 		pm_wakeup_update_hit_counts();
-	return ret;
+	return events_check_enabled;
 }
 
 static struct dentry *wakeup_sources_stats_dentry;

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] PM / Wakeup: Don't update
	events_check_enabled in pm_get_wakeup_count()
Date: Tue, 25 Jan 2011 01:16:27 +0100
Message-ID: <201101250116.27679.rjw__28660.2430548102$1295914758$gmane$org@sisk.pl>
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

Since pm_save_wakeup_count() has just been changed to clear
events_check_enabled unconditionally before checking if there are
any new wakeup events registered since the last read from
/sys/power/wakeup_count, the detection of wakeup events during
suspend may be disabled, after it's been enabled, by writing a
"wrong" value back to /sys/power/wakeup_count.  For this reason,
it is not necessary to update events_check_enabled in
pm_get_wakeup_count() any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/wakeup.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/base/power/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/base/power/wakeup.c
+++ linux-2.6/drivers/base/power/wakeup.c
@@ -616,17 +616,14 @@ bool pm_wakeup_pending(void)
  * Store the number of registered wakeup events at the address in @count.  Block
  * if the current number of wakeup events being processed is nonzero.
  *
- * Return false if the wait for the number of wakeup events being processed to
+ * Return 'false' if the wait for the number of wakeup events being processed to
  * drop down to zero has been interrupted by a signal (and the current number
- * of wakeup events being processed is still nonzero).  Otherwise return true.
+ * of wakeup events being processed is still nonzero).  Otherwise return 'true'.
  */
 bool pm_get_wakeup_count(unsigned int *count)
 {
 	bool ret;
 
-	if (capable(CAP_SYS_ADMIN))
-		events_check_enabled = false;
-
 	while (atomic_read(&events_in_progress) && !signal_pending(current)) {
 		pm_wakeup_update_hit_counts();
 		schedule_timeout_interruptible(msecs_to_jiffies(TIMEOUT));

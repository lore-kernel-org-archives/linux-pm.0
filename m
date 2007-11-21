From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] Freezer: Fix APM emulation breakage
Date: Wed, 21 Nov 2007 02:53:14 +0100
Message-ID: <200711210253.15539.rjw@sisk.pl>
References: <200711210244.37965.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711210244.37965.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The APM emulation is currently broken as a result of commit
831441862956fffa17b9801db37e6ea1650b0f69
"Freezer: make kernel threads nonfreezable by default"
that removed the PF_NOFREEZE annotations from apm_ioctl() without adding
the appropriate freezer hooks.  Fix it and remove the unnecessary variable flags
from apm_ioctl().

Special thanks to Franck Bui-Huu <vagabon.xyz@gmail.com> for pointing out the
problem.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>
---
 drivers/char/apm-emulation.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/char/apm-emulation.c
===================================================================
--- linux-2.6.orig/drivers/char/apm-emulation.c
+++ linux-2.6/drivers/char/apm-emulation.c
@@ -295,7 +295,6 @@ static int
 apm_ioctl(struct inode * inode, struct file *filp, u_int cmd, u_long arg)
 {
 	struct apm_user *as = filp->private_data;
-	unsigned long flags;
 	int err = -EINVAL;
 
 	if (!as->suser || !as->writer)
@@ -331,10 +330,16 @@ apm_ioctl(struct inode * inode, struct f
 			 * Wait for the suspend/resume to complete.  If there
 			 * are pending acknowledges, we wait here for them.
 			 */
-			flags = current->flags;
+			freezer_do_not_count();
 
 			wait_event(apm_suspend_waitqueue,
 				   as->suspend_state == SUSPEND_DONE);
+
+			/*
+			 * Since we are waiting until the suspend is done, the
+			 * try_to_freeze() in freezer_count() will not trigger
+			 */
+			freezer_count();
 		} else {
 			as->suspend_state = SUSPEND_WAIT;
 			mutex_unlock(&state_lock);
@@ -362,14 +367,10 @@ apm_ioctl(struct inode * inode, struct f
 			 * Wait for the suspend/resume to complete.  If there
 			 * are pending acknowledges, we wait here for them.
 			 */
-			flags = current->flags;
-
-			wait_event_interruptible(apm_suspend_waitqueue,
+			wait_event_freezable(apm_suspend_waitqueue,
 					 as->suspend_state == SUSPEND_DONE);
 		}
 
-		current->flags = flags;
-
 		mutex_lock(&state_lock);
 		err = as->suspend_result;
 		as->suspend_state = SUSPEND_NONE;

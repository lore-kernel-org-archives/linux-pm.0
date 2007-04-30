From: akpm@linux-foundation.org
Subject: [patch 6/8] power management: force pm_ops.valid
	callback to be assigned
Date: Mon, 30 Apr 2007 15:09:55 -0700
Message-ID: <200704302209.l3UM9tSx016074@shell0.pdx.osdl.net>
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
To: torvalds@linux-foundation.org
Cc: pavel@ucw.cz, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, johannes@sipsolutions.net
List-Id: linux-pm@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

This patch changes the docs and behaviour from "all states valid" to "no
states valid" if no .valid callback is assigned.  Users of pm_ops that only
need mem sleep can assign pm_valid_only_mem without any overhead, others
will require more elaborate callbacks.

Now that all users of pm_ops have a .valid callback this is a safe thing to
do and prevents things from getting messy again as they were before.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
Looks-okay-to: Rafael J. Wysocki <rjw@sisk.pl>
Cc: <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/pm.h  |   12 ++++++------
 kernel/power/main.c |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -puN include/linux/pm.h~power-management-force-pm_opsvalid-callback-to-be include/linux/pm.h
--- a/include/linux/pm.h~power-management-force-pm_opsvalid-callback-to-be
+++ a/include/linux/pm.h
@@ -125,12 +125,12 @@ typedef int __bitwise suspend_disk_metho
  * struct pm_ops - Callbacks for managing platform dependent suspend states.
  * @valid: Callback to determine whether the given state can be entered.
  * 	If %CONFIG_SOFTWARE_SUSPEND is set then %PM_SUSPEND_DISK is
- *	always valid and never passed to this call.
- *	If not assigned, all suspend states are advertised as valid
- *	in /sys/power/state (but can still be rejected by prepare or enter.)
- *	Since new states can be added for other platforms, you should
- *	assign this callback. There is a %pm_valid_only_mem function
- *	available if you only implemented mem sleep.
+ *	always valid and never passed to this call. If not assigned,
+ *	no suspend states are valid.
+ *	Valid states are advertised in /sys/power/state but can still
+ *	be rejected by prepare or enter if the conditions aren't right.
+ *	There is a %pm_valid_only_mem function available that can be assigned
+ *	to this if you only implement mem sleep.
  *
  * @prepare: Prepare the platform for the given suspend state. Can return a
  *	negative error code if necessary.
diff -puN kernel/power/main.c~power-management-force-pm_opsvalid-callback-to-be kernel/power/main.c
--- a/kernel/power/main.c~power-management-force-pm_opsvalid-callback-to-be
+++ a/kernel/power/main.c
@@ -198,8 +198,8 @@ static inline int valid_state(suspend_st
 
 	/* all other states need lowlevel support and need to be
 	 * valid to the lowlevel implementation, no valid callback
-	 * implies that all are valid. */
-	if (!pm_ops || (pm_ops->valid && !pm_ops->valid(state)))
+	 * implies that none are valid. */
+	if (!pm_ops || !pm_ops->valid || !pm_ops->valid(state))
 		return 0;
 	return 1;
 }
_

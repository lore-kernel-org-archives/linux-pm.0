From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] power management: force pm_ops.valid callback to
	be	assigned
Date: Thu, 22 Mar 2007 14:44:02 +0100
Message-ID: <1174571042.32051.2.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This patch changes the docs and behaviour from "all states valid" to
"no states valid" if no .valid callback is assigned. Users of pm_ops
that only need mem sleep can assign pm_valid_only_mem without any
overhead, others will require more elaborate callbacks.

Now that all users of pm_ops have a .valid callback this is a safe
thing to do and prevents things from getting messy again as they
were before.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org

---
 include/linux/pm.h  |   12 ++++++------
 kernel/power/main.c |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.orig/include/linux/pm.h	2007-03-22 14:35:14.764654656 +0100
+++ linux-2.6/include/linux/pm.h	2007-03-22 14:36:38.784654656 +0100
@@ -125,12 +125,12 @@ typedef int __bitwise suspend_disk_metho
  * struct pm_ops - Callbacks for managing platform dependent suspend state=
s.
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
--- linux-2.6.orig/kernel/power/main.c	2007-03-22 14:36:46.044654656 +0100
+++ linux-2.6/kernel/power/main.c	2007-03-22 14:40:29.664654656 +0100
@@ -186,8 +186,8 @@ static inline int valid_state(suspend_st
 =

 	/* all other states need lowlevel support and need to be
 	 * valid to the lowlevel implementation, no valid callback
-	 * implies that all are valid. */
-	if (!pm_ops || (pm_ops->valid && !pm_ops->valid(state)))
+	 * implies that none are valid. */
+	if (!pm_ops || !pm_ops->valid || !pm_ops->valid(state))
 		return 0;
 	return 1;
 }

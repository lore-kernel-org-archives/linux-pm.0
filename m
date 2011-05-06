From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PM: Fix warning in pm_restrict_gfp_mask()
	during SNAPSHOT_S2RAM ioctl
Date: Sat, 7 May 2011 00:30:30 +0200
Message-ID: <201105070030.30849.rjw__44222.7374217056$1304721498$gmane$org@sisk.pl>
References: <201105070029.44623.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105070029.44623.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

A warning is printed by pm_restrict_gfp_mask() while the
SNAPSHOT_S2RAM ioctl is being executed after creating a hibernation
image, because pm_restrict_gfp_mask() has been called once already
before the image creation and suspend_devices_and_enter() calls it
once again.  This happens after commit 452aa6999e6703ffbddd7f6ea124d3
(mm/pm: force GFP_NOIO during suspend/hibernation and resume).

To avoid this issue, move pm_restrict_gfp_mask() and
pm_restore_gfp_mask() from suspend_devices_and_enter() to its caller
in kernel/power/suspend.c.

Reported-by: Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/suspend.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/suspend.c
===================================================================
--- linux-2.6.orig/kernel/power/suspend.c
+++ linux-2.6/kernel/power/suspend.c
@@ -210,7 +210,6 @@ int suspend_devices_and_enter(suspend_st
 			goto Close;
 	}
 	suspend_console();
-	pm_restrict_gfp_mask();
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
@@ -227,7 +226,6 @@ int suspend_devices_and_enter(suspend_st
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
-	pm_restore_gfp_mask();
 	resume_console();
  Close:
 	if (suspend_ops->end)
@@ -288,7 +286,9 @@ int enter_state(suspend_state_t state)
 		goto Finish;
 
 	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
+	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
+	pm_restore_gfp_mask();
 
  Finish:
 	pr_debug("PM: Finishing wakeup.\n");

From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] freezer: restructure __refrigerator()
Date: Sat,  3 Sep 2011 03:27:47 +0900
Message-ID: <1314988070-12244-4-git-send-email-tj__34232.0769480013$1314988198$gmane$org@kernel.org>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314988070-12244-1-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oleg@redhat.com, matthltc@us.ibm.com, rjw@sisk.pl, paul@paulmenage.org
Cc: Tejun Heo <tj@kernel.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If another freeze happens before all tasks leave FROZEN state after
being thawed, the freezer can see the existing FROZEN and consider the
tasks to be frozen but they can clear FROZEN without checking the new
freezing().

Oleg suggested restructuring __refrigerator() such that there's single
condition check section inside freezer_lock and sigpending is cleared
afterwards, which fixes the problem and simplifies the code.
Restructure accordingly.

-v2: Frozen loop exited without releasing freezer_lock.  Fixed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/freezer.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 466ea6b..ebee1ab 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -52,36 +52,29 @@ bool __refrigerator(bool check_kthr_stop)
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	bool was_frozen = false;
-	long save;
+	long save = current->state;
 
-	/*
-	 * No point in checking freezing() again - the caller already did.
-	 * Proceed to enter FROZEN.
-	 */
-	spin_lock_irq(&freezer_lock);
-	current->flags |= PF_FROZEN;
-	spin_unlock_irq(&freezer_lock);
-
-	save = current->state;
 	pr_debug("%s entered refrigerator\n", current->comm);
 
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* We sent fake signal, clean it up */
-	spin_unlock_irq(&current->sighand->siglock);
-
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
+
+		spin_lock_irq(&freezer_lock);
+		current->flags |= PF_FROZEN;
 		if (!freezing(current) ||
 		    (check_kthr_stop && kthread_should_stop()))
+			current->flags &= ~PF_FROZEN;
+		spin_unlock_irq(&freezer_lock);
+
+		if (!(current->flags & PF_FROZEN))
 			break;
 		was_frozen = true;
 		schedule();
 	}
 
-	/* leave FROZEN */
-	spin_lock_irq(&freezer_lock);
-	current->flags &= ~PF_FROZEN;
-	spin_unlock_irq(&freezer_lock);
+	spin_lock_irq(&current->sighand->siglock);
+	recalc_sigpending(); /* We sent fake signal, clean it up */
+	spin_unlock_irq(&current->sighand->siglock);
 
 	pr_debug("%s left refrigerator\n", current->comm);
 
-- 
1.7.6

From: Tejun Heo <tj@kernel.org>
Subject: [PATCH pm-freezer 3/4] freezer: restructure
	__refrigerator()
Date: Wed, 31 Aug 2011 12:22:10 +0200
Message-ID: <20110831102210.GC2828__5047.76339880681$1314909593$gmane$org@mtj.dyndns.org>
References: <20110831102100.GA2828@mtj.dyndns.org>
	<20110831102143.GB2828@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110831102143.GB2828@mtj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@redhat.com>, Paul Menage <paul@paulmenage.org>
Cc: containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


If another freeze happens before all tasks leave FROZEN state after
being thawed, the freezer can see the existing FROZEN and consider the
tasks to be frozen but they can clear FROZEN without checking the new
freezing().

Oleg suggested restructuring __refrigerator() such that there's single
condition check section inside freezer_lock and sigpending is cleared
afterwards, which fixes the problem and simplifies the code.
Restructure accordingly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 kernel/freezer.c |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

Index: work/kernel/freezer.c
===================================================================
--- work.orig/kernel/freezer.c
+++ work/kernel/freezer.c
@@ -52,36 +52,31 @@ bool __refrigerator(bool check_kthr_stop
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
-		    (check_kthr_stop && kthread_should_stop()))
+		    (check_kthr_stop && kthread_should_stop())) {
+			current->flags &= ~PF_FROZEN;
+			break;
+		}
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
 

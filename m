From: "tip-bot for Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [tip:sched/urgent] sched: Make wakeup side and atomic
	variants of completion API irq safe
Date: Sun, 13 Dec 2009 07:36:42 GMT
Message-ID: <tip-7539a3b3d1f892dd97eaf094134d7de55c13befe@git.kernel.org>
References: <200912130007.30541.rjw@sisk.pl>
Reply-To: mingo@redhat.com, hpa@zytor.com, linux-pm@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
        rui.zhang@intel.com, lachlan@sgi.com, tglx@linutronix.de,
        david@fromorbit.com, rjw@sisk.pl, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912130007.30541.rjw@sisk.pl>
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
To: linux-tip-commits@vger.kernel.org
Cc: tglx@linutronix.de, a.p.zijlstra@chello.nl, mingo@elte.hu, david@fromorbit.com, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, lachlan@sgi.com, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Commit-ID:  7539a3b3d1f892dd97eaf094134d7de55c13befe
Gitweb:     http://git.kernel.org/tip/7539a3b3d1f892dd97eaf094134d7de55c13befe
Author:     Rafael J. Wysocki <rjw@sisk.pl>
AuthorDate: Sun, 13 Dec 2009 00:07:30 +0100
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Sun, 13 Dec 2009 08:12:46 +0100

sched: Make wakeup side and atomic variants of completion API irq safe

Alan Stern noticed that all the wakeup side (and atomic) variants of the
completion APIs should be irq safe, but the newly introduced
completion_done() and try_wait_for_completion() aren't. The use of the
irq unsafe variants in IRQ contexts can cause crashes/hangs.

Fix the problem by making them use spin_lock_irqsave() and
spin_lock_irqrestore().

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Chinner <david@fromorbit.com>
Cc: Lachlan McIlroy <lachlan@sgi.com>
LKML-Reference: <200912130007.30541.rjw@sisk.pl>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sched.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index ff39cad..8b3532f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5908,14 +5908,15 @@ EXPORT_SYMBOL(wait_for_completion_killable);
  */
 bool try_wait_for_completion(struct completion *x)
 {
+	unsigned long flags;
 	int ret = 1;
 
-	spin_lock_irq(&x->wait.lock);
+	spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = 0;
 	else
 		x->done--;
-	spin_unlock_irq(&x->wait.lock);
+	spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(try_wait_for_completion);
@@ -5930,12 +5931,13 @@ EXPORT_SYMBOL(try_wait_for_completion);
  */
 bool completion_done(struct completion *x)
 {
+	unsigned long flags;
 	int ret = 1;
 
-	spin_lock_irq(&x->wait.lock);
+	spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = 0;
-	spin_unlock_irq(&x->wait.lock);
+	spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(completion_done);

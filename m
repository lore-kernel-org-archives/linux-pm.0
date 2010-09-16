From: <gregkh@suse.de>
Subject: Patch "sched: Make wakeup side and atomic variants of
	completion API irq safe" has been added to the 2.6.32-stable tree
Date: Thu, 16 Sep 2010 14:07:12 -0700
Message-ID: <12846712323040@site>
References: <09c3ea5b3483bec5c4181b9dfd61b5da6b15969b.1283514306.git.efault@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <09c3ea5b3483bec5c4181b9dfd61b5da6b15969b.1283514306.git.efault@gmx.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl, a.p.zijlstra@chello.nl, david@fromorbit.com, efault@gmx.de, gregkh@suse.de, greg@kroah.com, lachlan@sgi.com, linux-pm@lists.linux-foundation.org, mingo@elte.
Cc: stable@kernel.org, stable-commits@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    sched: Make wakeup side and atomic variants of completion API irq safe

to the 2.6.32-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     sched-make-wakeup-side-and-atomic-variants-of-completion-api-irq-safe.patch
and it can be found in the queue-2.6.32 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@kernel.org> know about it.


>From rjw@sisk.pl  Thu Sep 16 14:03:08 2010
From: Rafael J.Wysocki <rjw@sisk.pl>
Date: Sun, 13 Dec 2009 00:07:30 +0100
Subject: sched: Make wakeup side and atomic variants of completion API irq safe
To: stable <stable@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Greg KH <greg@kroah.com>
Message-ID: <09c3ea5b3483bec5c4181b9dfd61b5da6b15969b.1283514306.git.efault@gmx.de>

From: Rafael J.Wysocki <rjw@sisk.pl>

commit 7539a3b3d1f892dd97eaf094134d7de55c13befe upstream

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
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/sched.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5947,14 +5947,15 @@ EXPORT_SYMBOL(wait_for_completion_killab
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
@@ -5969,12 +5970,13 @@ EXPORT_SYMBOL(try_wait_for_completion);
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


Patches currently in stable-queue which might be from rjw@sisk.pl are

queue-2.6.32/sched-make-wakeup-side-and-atomic-variants-of-completion-api-irq-safe.patch
queue-2.6.32/x86-tsc-fix-a-preemption-leak-in-restore_sched_clock_state.patch

From: Greg KH <gregkh@suse.de>
Subject: [072/123] sched: Make wakeup side and atomic variants of
	completion API irq safe
Date: Sat, 18 Sep 2010 11:58:36 -0700
Message-ID: <20100918185958.963057726@clark.site>
References: <20100918185724.290702750@clark.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=sched-make-wakeup-side-and-atomic-variants-of-completion-api-irq-safe.patch
In-Reply-To: <20100918190024.GA14388@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Mike Galbraith <efault@gmx.de>, David Chinner <david@fromorbit.com>, stable-review@kernel.org, Lachlan McIlroy <lachlan@sgi.com>, pm list <linux-pm@lists.linux-foundation.org>, akpm@linux-foundation.org, torvalds@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

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

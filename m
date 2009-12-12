From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] sched: Make wakeup side variants of completion
	API irq safe (was: Re: spinlock in completion_done())
Date: Sun, 13 Dec 2009 00:07:30 +0100
Message-ID: <200912130007.30541.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912081633540.3046-100000@iolanthe.rowland.org>
	<200912092337.52492.rjw@sisk.pl> <20091210075947.GD25549@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091210075947.GD25549@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, David Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lachlan McIlroy <lachlan@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 10 December 2009, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > On Wednesday 09 December 2009, Ingo Molnar wrote:
> > > 
> > > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > 
> > > > On Tuesday 08 December 2009, Alan Stern wrote:
> > > > > On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> > > > > 
> > > > > > BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
> > > > > > and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
> > > > > > here?
> > > > > 
> > > > > And likewise in try_wait_for_completion().  It looks like a bug.  Maybe 
> > > > > these routines were not intended to be called with interrupts disabled, 
> > > > > but that requirement doesn't seem to be documented.  And it isn't a 
> > > > > natural requirement anyway.
> > > > 
> > > > OK, let's ask Ingo about that.
> > > > 
> > > > Ingo, is there any particular reason why completion_done() and
> > > > try_wait_for_completion() don't use spin_lock_irqsave() and
> > > > spin_unlock_irqrestore()?
> > > 
> > > that's a bug that should be fixed - all the wakeup side (and atomic) 
> > > variants of completetion API should be irq safe.
> > > 
> > > It appears that these new completion APIs were added via the XFS tree 
> > > about a year ago:
> > > 
> > >   39d2f1a: [XFS] extend completions to provide XFS object flush requirements
> > > 
> > > Please Cc: scheduler folks to all scheduler patches.
> > 
> > If you haven't fixed it locally yet, would you mind me posting a fix?
> 
> I wouldnt mind it at all.

Is appended.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: sched: Make wakeup side variants of completion API irq safe

All the wakeup side variants of the completion API shoild be irq
safe, but completion_done() and try_wait_for_completion() aren't.
Fix the problem by making them use spin_lock_irqsave() and
spin_lock_irqrestore().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/sched.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -5931,14 +5931,15 @@ EXPORT_SYMBOL(wait_for_completion_killab
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
@@ -5953,12 +5954,13 @@ EXPORT_SYMBOL(try_wait_for_completion);
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

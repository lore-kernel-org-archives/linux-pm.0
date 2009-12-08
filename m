From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 10:41:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081024530.3560__6958.06385851956$1260297838$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912081234030.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081234030.3046-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 8 Dec 2009, Alan Stern wrote:
> > 
> > So we actually _want_ the full rwlock semantics. 
> 
> I'm not convinced.  Condense the description a little farther:
> 
> 	Suspend:  Children lock the parent first.  When they are
> 		finished they unlock the parent, allowing it to
> 		proceed.
> 
> 	Resume:  Parent locks itself first.  When it is finished
> 		it unlocks itself, allowing the children to proceed.

Yes. You can implement it with a simple lock with a count. Nobody debates 
that.

But a simple counting lock _is_ a rwlock. Really. They are 100% 
semantically equivalent. There is no difference.

> The whole readers vs. writers thing is a non-sequitur.

No it's not.

It's a 100% equivalent problem. It's purely a change of wording. The end 
result is the same.

> The simplest generalization is to allow both multiple lockers and
> multiple waiters.  Call it a waitlock, for want of a better name:

But we have that. It _has_ a better name: rwlocks.

And the reason the name is better is because now the name describes all 
the semantics to anybody who has ever taken a course in operating systems 
or in parallelism.

It's also a better implementation, because it actually _works_.

> 	wait_lock(wl)
> 	{
> 		atomic_inc(&wl->count);
> 	}
> 
> 	wait_unlock(wl)
> 	{
> 		if (atomic_dec_and_test(&wl->count)) {
> 			smp_mb__after_atomic_dec();
> 			wake_up_all(wl->wqh);
> 		}
> 	}
> 
> 	wait_for_lock(wl)
> 	{
> 		wait_event(wl->wqh, atomic_read(&wl->count) == 0);
> 		smp_rmb();
> 	}
> 
> Note that both wait_lock() and wait_unlock() can be called 
> in_interrupt.

And note how even though you sprinkled random memory barriers around, you 
still got it wrong. 

So you just implemented a buggy lock, and for what gain? Tell me exactly 
why your buggy lock (assuming you'd know enough about memory ordering to 
actually fix it) is better than just using the existing one?

It's certainly not smaller. It's not faster. It doesn't have support for 
lockdep. And it's BUGGY.

Really. Tell me why you want to re-implement an existing lock - badly.

[ Hint: you need a smp_mb() *before* the atomic_dec() in wait-unlock, so 
  that anybody else who sees the new value will be guaranteed to have seen 
  anything else the unlocker did.

  You also need a smp_mb() in the wait_for_lock(), not a smp_rmb(). Can't 
  allow writes to migrate up either.  'atomic_read()' does not imply any
  barriers.

  But most architectures can optimize these things for their particular 
  memory ordering model, and do so in their rwsem implementation. ]

> This becomes:
> 
> 	usb_node_resume(node)
> 	{
> 		// Wait for parent to finish resume
> 		wait_for_lock(node->parent->lock);
> 		// .. before resuming outselves
>                 node->resume(node)
> 
> 		// Now we're all done
> 		wait_unlock(node->lock);
> 	}
> 
> 	/* caller: */
> 	..
> 	// This can't block, because wait_lock() is non-blocking.
> 	wait_lock(node->lock);
> 	// Do the blocking part asynchronously
> 	async_schedule(usb_node_resume, leaf);
> 	..

Umm? Same thing, different words?

That "wait_for_lock()" is equivalent to a 'read_lock()+read_unlock()'. We 
_could_ expose such a mechanism for rwsem's too, but why do it? It's 
actually nicer to use a real read-lock - and do it _around_ the operation, 
because now the locking also automatically gets things like overlapping 
suspends and resumes right.

(Which you'd obviously hope never happens, but it's nice from a conceptual 
standpoint to know that the locking is robust).

> Aren't waitlocks simpler than rwsems?  Not as generally useful,
> perhaps.  But just as correct in this situation.

NO!

Dammit. I started this whole rant with this comment to Rafael:

 "The fact is, any time anybody makes up a new locking mechanism, THEY 
  ALWAYS GET IT WRONG. Don't do it."

Take heed. You got it wrong. Admit it. Locking is _hard_. SMP memory 
ordering is HARD.

So leave locking to the pro's. They _also_ got it wrong, but they got it 
wrong several years ago, and fixed up their sh*t.

This is why you use generic locking. ALWAYS.

		Linus

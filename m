From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 13:08:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912081234030.3046-100000__41247.0409450636$1260295803$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912080833170.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912080833170.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Linus Torvalds wrote:

> On Tue, 8 Dec 2009, Alan Stern wrote:
> > 
> > The semantics needed for this kind of lock aren't really the same as
> > for an rwsem (although obviously an rwsem will do the job).  Basically
> > it needs to have the capability for multiple users to lock it (no
> > blocking when acquiring a lock) and the capability for a user to wait
> > until it is totally unlocked.  It could be implemented trivially using
> > an atomic_t counter and a waitqueue head.
> > 
> > Is this a standard sort of lock?
> 
> Yes it is.
> 
> It's called a rwlock. The counter is for readers, the exclusion is for 
> writers.
> 
> Really.
> 
> And the thing is, you actually do want the rwlock semantics, because on 
> the resume side you want the parent to lock it for writing first (so that 
> the children can wait for the parent to have completed its resume.
> 
> So we actually _want_ the full rwlock semantics. 

I'm not convinced.  Condense the description a little farther:

	Suspend:  Children lock the parent first.  When they are
		finished they unlock the parent, allowing it to
		proceed.

	Resume:  Parent locks itself first.  When it is finished
		it unlocks itself, allowing the children to proceed.

The whole readers vs. writers thing is a non-sequitur.  (For instance,
this never uses the fact that writers exclude each other.)  In each
case a lock is taken and eventually released, allowing someone else to
stop waiting and move forward.  In the suspend case we have multiple
lockers and one waiter, whereas in the resume case we have one locker
and multiple waiters.

The simplest generalization is to allow both multiple lockers and
multiple waiters.  Call it a waitlock, for want of a better name:

	wait_lock(wl)
	{
		atomic_inc(&wl->count);
	}

	wait_unlock(wl)
	{
		if (atomic_dec_and_test(&wl->count)) {
			smp_mb__after_atomic_dec();
			wake_up_all(wl->wqh);
		}
	}

	wait_for_lock(wl)
	{
		wait_event(wl->wqh, atomic_read(&wl->count) == 0);
		smp_rmb();
	}

Note that both wait_lock() and wait_unlock() can be called 
in_interrupt.

> See the code I posted earlier. Here condensed into one email:
> 
>  - resume:
> 
>         usb_node_resume(node)
>         {
> 		// Wait for parent to finish resume
>                 down_read(node->parent->lock);
> 		// .. before resuming outselves
>                 node->resume(node)
> 
> 		// Now we're all done
>                 up_read(node->parent->lock);
>                 up_write(node->lock);
>         }
> 
> 	/* caller: */
> 	..
> 	// This won't block, because we resume parents before children,
> 	// and the children will take the read lock. 
>         down_write(leaf->lock);
> 	// Do the blocking part asynchronously
>         async_schedule(usb_node_resume, leaf);
> 	..

This becomes:

	usb_node_resume(node)
	{
		// Wait for parent to finish resume
		wait_for_lock(node->parent->lock);
		// .. before resuming outselves
                node->resume(node)

		// Now we're all done
		wait_unlock(node->lock);
	}

	/* caller: */
	..
	// This can't block, because wait_lock() is non-blocking.
	wait_lock(node->lock);
	// Do the blocking part asynchronously
	async_schedule(usb_node_resume, leaf);
	..

>  - suspend:
> 
>         usb_node_suspend(node)
>         {
>                 // Start our suspend. This will block if we have any
>                 // children that are still busy suspending (they will
>                 // have done a down_read() in their suspend).
>                 down_write(node->lock);
>                 node->suspend(node);
>                 up_write(node->lock);
> 
>                 // This lets our parent continue
>                 up_read(node->parent->lock);
>         }
> 
> 	/* caller: */
> 
> 	// This won't block, because we suspend nodes before parents
>         down_read(node->parent->lock);
> 	// Do the part that may block asynchronously
> 	async_schedule(do_usb_node_suspend, node);

	usb_node_suspend(node)
	{
		// Start our suspend.  This will block if we have any
		// children that are still busy suspending (they will
		// have done a wait_lock() in their suspend).
		wait_for_lock(node->lock);
		node->suspend(node);

		// This lets our parent continue
		wait_unlock(node->parent->lock);
	}

	/* caller: */
	..
	// This can't block, because wait_lock is non-blocking.
	wait_lock(node->parent->lock);
	// Do the part that may block asynchronously
	async_schedule(do_usb_node_suspend, node);
	..

> It really should be that simple. Nothing more, nothing less. And with the 
> above, finishing the suspend (or resume) from interrupts is fine, and you 
> don't have any new lock that has undefined memory ordering issues etc.

Aren't waitlocks simpler than rwsems?  Not as generally useful,
perhaps.  But just as correct in this situation.

Alan Stern

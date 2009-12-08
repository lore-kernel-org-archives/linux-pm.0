From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 08:42:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912080833170.3560__42021.4618709453$1260290678$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912081049010.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081049010.3046-100000@iolanthe.rowland.org>
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
> 
> The semantics needed for this kind of lock aren't really the same as
> for an rwsem (although obviously an rwsem will do the job).  Basically
> it needs to have the capability for multiple users to lock it (no
> blocking when acquiring a lock) and the capability for a user to wait
> until it is totally unlocked.  It could be implemented trivially using
> an atomic_t counter and a waitqueue head.
> 
> Is this a standard sort of lock?

Yes it is.

It's called a rwlock. The counter is for readers, the exclusion is for 
writers.

Really.

And the thing is, you actually do want the rwlock semantics, because on 
the resume side you want the parent to lock it for writing first (so that 
the children can wait for the parent to have completed its resume.

So we actually _want_ the full rwlock semantics. 

See the code I posted earlier. Here condensed into one email:

 - resume:

        usb_node_resume(node)
        {
		// Wait for parent to finish resume
                down_read(node->parent->lock);
		// .. before resuming outselves
                node->resume(node)

		// Now we're all done
                up_read(node->parent->lock);
                up_write(node->lock);
        }

	/* caller: */
	..
	// This won't block, because we resume parents before children,
	// and the children will take the read lock. 
        down_write(leaf->lock);
	// Do the blocking part asynchronously
        async_schedule(usb_node_resume, leaf);
	..

 - suspend:

        usb_node_suspend(node)
        {
                // Start our suspend. This will block if we have any
                // children that are still busy suspending (they will
                // have done a down_read() in their suspend).
                down_write(node->lock);
                node->suspend(node);
                up_write(node->lock);

                // This lets our parent continue
                up_read(node->parent->lock);
        }

	/* caller: */

	// This won't block, because we suspend nodes before parents
        down_read(node->parent->lock);
	// Do the part that may block asynchronously
	async_schedule(do_usb_node_suspend, node);

It really should be that simple. Nothing more, nothing less. And with the 
above, finishing the suspend (or resume) from interrupts is fine, and you 
don't have any new lock that has undefined memory ordering issues etc.

		Linus

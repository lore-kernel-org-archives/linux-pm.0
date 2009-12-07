From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 16:32:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071610520.15701-100000__26978.9693331861$1260221700$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912071239270.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912071239270.3560@localhost.localdomain>
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

On Mon, 7 Dec 2009, Linus Torvalds wrote:

> > The consequence is that there's no way to hand off an entire subtree to 
> > an async thread.  And as a result, your single-pass algorithm runs into 
> > the kind of "stall" problem I described before.
> 
> No, look again. There's no stall in the thing, because all it really 
> depends on is (for the suspend path) is that it sees all children before 
> the parent (because the child will do a "down_read()" on the parent node 
> and that should not stall), and for the resume path it depends on seeing 
> the parent node before any children (because the parent node does that 
> "down_write()" on its own node).
> 
> Everything else is _entirely_ asynchronous, including all the other locks 
> it takes. So there are no stalls (except, of course, if we then hit limits 
> on numbers of outstanding async work and refuse to create too many 
> outstanding async things, but that's a separate issue, and intentional, of 
> course).

It only seems that way because you didn't take into account devices 
that suspend synchronously but whose children suspend asynchronously.

A synchronous suspend routine for a device with async child suspends
would have to look just like your usb_node_suspend():

	suspend_one_node(dev)
	{
		/* Wait until the children are suspended */
		down_write(dev->lock);
		Suspend dev
		up_write(dev->lock);

		/* Allow the parent to suspend */
		up_read(dev->parent->lock);
	}

So now suppose we've got two USB host controllers, A and B.  They are
PCI devices, so they suspend synchronously.  Each has a root hub child
(P and Q respectively) which is a USB device and therefore suspends
asynchronously.  dpm_list contains: A, P, B, Q.  (In fact A doesn't 
enter into this discussion; you can ignore it.)

In your one-pass algorithm, we start with usb_node_suspend(Q).  It does 
down_read(B->lock) and starts an async task for Q.  Then we move on to 
suspend_one_node(B).  It does down_write(B->lock) and blocks until the 
async task finishes; then it suspends B.  Finally we move on to 
usb_node_suspend(P), which does down_read(A->lock) and starts an async 
task for P.

The upshot is that P is stuck waiting for Q to suspend, even though it 
should have been able to suspend in parallel.  This is simply because P 
precedes B in the list, and B is synchronous and must wait for Q to 
finish.

With my two-pass algorithm, we start with Q.  The first loop does
down_read(B->lock) and starts an async task for Q.  We move on to B and
do down_read(B->parent->lock), nothing more.  Then we move to to P,
with down_read(A->lock) and start an async task for P.  Finally we do
down_read(A->parent->lock).  Notice that now there are two async tasks,
for P and Q, running in parallel.

The second pass waits for Q to finish before suspending B 
synchronously, and waits for P to finish before suspending A 
synchronously.  This is unavoidable.  The point is that it allows P and 
Q to suspend at the same time, not one after the other as in the 
one-pass scheme.

Alan Stern

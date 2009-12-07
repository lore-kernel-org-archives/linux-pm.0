From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 12:48:19 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071239270.3560__45258.452211465$1260219086$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912071449470.15701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912071449470.15701-100000@iolanthe.rowland.org>
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



On Mon, 7 Dec 2009, Alan Stern wrote:
> 
> Yes, I like this approach better and better.
> 
> There is still a problem.  In your code outlines, you have presented a
> classic depth-first (suspend) or depth-last (resume) tree algorithm. 

Yes, I did that because that clarifies the locking rules (ie "we traverse 
parents nodes last/first"), not because it was actually relevant to 
anything else.

And the whole pre-order vs post-order is important, and really only shows 
up when you show the pseudo-code as a tree walk. 

> But that's not how the PM core works.  Instead it maintains dpm_list, a
> list of all devices in order of registration.

Right. I did mention that in a couple of the asides, I'm well aware that 
we don't actually traverse the tree as a tree.

But the "traverse list forward" is logically the same thing as doing 
a pre-order DFS, while going backwards is equivalent to doing a post-order 
DFS, since all we really care about is the whole "parent first" or 
"children first" part of the ordering.

So I wanted to show the logic in pseudo-code using the tree walk (because 
that explains the logic _conceptually_ much better), but the actual code 
would just do the list traversal.

> The consequence is that there's no way to hand off an entire subtree to 
> an async thread.  And as a result, your single-pass algorithm runs into 
> the kind of "stall" problem I described before.

No, look again. There's no stall in the thing, because all it really 
depends on is (for the suspend path) is that it sees all children before 
the parent (because the child will do a "down_read()" on the parent node 
and that should not stall), and for the resume path it depends on seeing 
the parent node before any children (because the parent node does that 
"down_write()" on its own node).

Everything else is _entirely_ asynchronous, including all the other locks 
it takes. So there are no stalls (except, of course, if we then hit limits 
on numbers of outstanding async work and refuse to create too many 
outstanding async things, but that's a separate issue, and intentional, of 
course).

You're right that my first one (two-phase suspend) had a stall situation.

		Linus

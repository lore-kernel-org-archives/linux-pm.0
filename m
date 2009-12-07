From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 10:13:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071003270.3064-100000__17181.8361887292$1260198883$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
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

On Sun, 6 Dec 2009, Linus Torvalds wrote:

> 	# Phase one: walk the tree synchronously, starting any
> 	# async work on the leaves
> 	suspend_prepare(root)
> 	{
> 		for_each_child(root) {
> 			// This may take the parent lock for
> 			// reading if it does something async
> 			suspend_prepare(child);
> 		}
> 		suspend_prepare_one_node(root);
> 	}
> 
> 	# Phase two: walk the tree synchronously, waiting for
> 	# and finishing the suspend
> 	suspend(root)
> 	{
> 		for_each_child(root) {
> 			suspend(child);
> 		}
> 		// This serializes with any async children started in phase 1
> 		write_lock(root->lock);
> 		suspend_one_node(root);
> 		write_unlock(root->lock);
> 	}
> 
> and I really think this should work.

> No complex concepts. No change to existing tested drivers. No callbacks, 
> no flags, no nothing. And a pretty simple way for a driver to decide: I'll 
> do my suspends asynchronously (without parent drivers really ever even 
> having to know about it).
> 
> I dunno. Maybe I'm overlooking something, but the above is much closer to 
> what I think would be worth doing.

You're overlooking resume.  It's more difficult than suspend.  The
issue is that a child can't start its async part until the parent's
synchronous part is finished.

So for example, suppose the device listing contains P, C, Q, where C is
a child of P, Q is unrelated, and P has a long-lasting asynchronous
requirement.  The resume process will stall upon reaching C, waiting
for P to finish.  Thus even though P and Q might be able to resume in
parallel, they won't get the chance.

An approach that handles resume well can probably be adapted to handle 
suspend too.  The reverse isn't true, as this example shows.

Alan Stern

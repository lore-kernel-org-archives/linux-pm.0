From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 14:16:40 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071407070.3560__30455.6118011989$1260224345$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912071610520.15701-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912071337020.3560@localhost.localdomain>
	<200912072302.57318.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912072302.57318.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 7 Dec 2009, Rafael J. Wysocki wrote:
> 
> BTW, I still don't quite understand why not to put the parent's down_write
> operation into the core.  It's not going to hurt for the "synchronous" devices
> and the "asynchronous" ones will need to do it anyway.

That's what I started out doing (see the first pseudo-code with the two 
phases). But it _does_ actually hurt.

Because it will hurt exactly for the "multiple hubs" case: if you have two 
USB hubs in parallel (and the case that Alan pointed out about a USB host 
bridge is the exact same deal), then you want to be able to suspend and 
resume those two independent hubs in parallel too.

But if you do the "down_write()" synchronously in the core, that means 
that you are also stopping the whole "traverse the tree" thing - so now 
you aren't handling the hubs in parallel even if you are handling all the 
devices _behind_ them asynchronously.

This "serialize while traversing the tree" was what I was initially trying 
to avoid with the two-phase approach, but that I realized (after writing 
the resume path) that I could avoid much better by just moving the parents 
down_write into the asynchronous path.

> Also it looks like that's something to do unconditionally for all nodes
> having children, because the parent need not know if the children do async
> operations.

True, and that was (again) the first iteration. But see above: in order to 
allow way more concurrency, you don't want to introduce the false 
dependency between the write-lock and the traversal of the tree (or, as 
Alan points out - just a list - but that doesn't really change anything) 
that is introduced by taking the lock synchronously.

So by moving the write-lock to the asynchronous work that also shuts down 
the parent, you avoid that whole unnecessary serialization. But that means 
that you can't do the lock in generic code.

Unless you want to do _all_ of the async logic in generic code and 
re-introduce the "dev->async_suspend" flag. I would be ok with that now 
that the infrastructure seems so simple.

			Linus

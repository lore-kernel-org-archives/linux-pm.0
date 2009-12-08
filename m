From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 21:30:14 +0100
Message-ID: <200912082130.14634.rjw__43551.2532633313$1260304333$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912081508220.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081508220.3046-100000@iolanthe.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 December 2009, Alan Stern wrote:
> On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> 
> > Suppose we use rwsem and during suspend each child uses a down_read() on a
> > parent and then the parent uses down_write() on itself.  What if, whatever the
> > reason, the parent is a bit early and does the down_write() before one of the
> > children has a chance to do the down_read()?  Aren't we toast?
> > 
> > Do we need any direct protection against that or does it just work itself out
> > in a way I just don't see right now?
> 
> That's not the way it should be done.  Linus had children taking their
> parents' locks during suspend, which is simple but leads to
> difficulties.
> 
> Instead, the PM core should do a down_write() on each device before
> starting the device's async suspend routine, and an up_write() when the
> routine finishes.  Parents should, at the start of their async routine,
> do down_read() on each of their children plus whatever other devices
> they need to wait for.  The core can do the waiting for children part 
> and the driver's suspend routine can handle any other waiting.
> 
> This is a little more awkward because it requires the parent to iterate 
> through its children.

I can live with that.

> But it does solve the off-tree dependency  problem for suspends.

That's a plus, but I still think we're trying to create a barrier-alike
mechanism using lock.

There's one more possibility to consider, though.  What if we use a completion
instead of the flag + wait queue?  It surely is a standard synchronization
mechanism and it seems it might work here.

Rafael

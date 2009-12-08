From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 21:52:21 +0100
Message-ID: <200912082152.21910.rjw__27152.1422350363$1260305629$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912081542350.3046-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912081542350.3046-100000@iolanthe.rowland.org>
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
> > > This is a little more awkward because it requires the parent to iterate 
> > > through its children.
> > 
> > I can live with that.
> > 
> > > But it does solve the off-tree dependency  problem for suspends.
> > 
> > That's a plus, but I still think we're trying to create a barrier-alike
> > mechanism using lock.
> > 
> > There's one more possibility to consider, though.  What if we use a completion
> > instead of the flag + wait queue?  It surely is a standard synchronization
> > mechanism and it seems it might work here.
> 
> You're right.  I should have thought of that.  Linus's original
> approach couldn't use a completion because during suspend it needed to
> make one task (the parent) wait for a bunch of others (the children).
> But if you iterate through the children by hand, that objection no
> longer applies.

BTW, is there a good reason why completion_done() doesn't use spin_lock_irqsave
and spin_unlock_irqrestore?  complete() and complete_all() use them, so why not
here?

Rafael

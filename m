From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 22:56:45 +0100
Message-ID: <200912092256.45872.rjw__7711.74811893633$1260395883$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912082111360.26994-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912082111360.26994-100000@netrider.rowland.org>
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

On Wednesday 09 December 2009, Alan Stern wrote:
> On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:
> 
> > > Well, one difficulty.  It arises only because we are contemplating
> > > having the PM core fire up the async tasks, rather than having the
> > > drivers' suspend routines launch them (the way your original proposal
> > > did -- the difficulty does not arise there).
> > > 
> > > Suppose A and B are unrelated devices and we need to impose the
> > > off-tree constraint that A suspends after B.  With children taking
> > > their parent's lock, the way to prevent A from suspending too soon is
> > > by having B's suspend routine acquire A's lock.
> > > 
> > > But B's suspend routine runs entirely in an async task, because that
> > > task is started by the PM core and it does the method call.  Hence by
> > > the time B's suspend routine is called, A may already have begun
> > > suspending -- it's too late to take A's lock.  To make the locking
> > > work, B would have to acquire A's lock _before_ B's async task starts.  
> > > Since the PM core is unaware of the off-tree dependency, there's no
> > > simple way to make it work.
> > 
> > Do not set async_suspend for B and instead start your own async thread
> > from its suspend callback.  The parent-children synchronization is done by the
> > core anyway (at least I'd do it that way), so the only thing you need to worry
> > about is the extra dependency.
> 
> I don't like that because it introduces "artificial" dependencies: It 
> makes B depend on all the preceding synchronous suspends, even totally 
> unrelated ones.  But yes, it would work.

Well, unfortunately, it wouldn't, because (at least in the context of my last
patch) the core would release the rwsems as soon as your suspend had
returned.  So you'd have to make your suspend wait for the async thread and
that would make it pointless.  So scratch that, it wasn't a good idea at all.

This leaves us with basically two options, where the first one is to use
rwsems in a way that you've proposed (with iterating over children), and the
second one is to use completions.  In my opinion rwsems don't give us any
advantage in this case, so I'd very much prefer to use completions.

Rafael

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Tue, 8 Dec 2009 21:23:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912082111360.26994-100000__11121.3587843396$1260325483$gmane$org@netrider.rowland.org>
References: <200912082330.24843.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912082330.24843.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Dec 2009, Rafael J. Wysocki wrote:

> > Well, one difficulty.  It arises only because we are contemplating
> > having the PM core fire up the async tasks, rather than having the
> > drivers' suspend routines launch them (the way your original proposal
> > did -- the difficulty does not arise there).
> > 
> > Suppose A and B are unrelated devices and we need to impose the
> > off-tree constraint that A suspends after B.  With children taking
> > their parent's lock, the way to prevent A from suspending too soon is
> > by having B's suspend routine acquire A's lock.
> > 
> > But B's suspend routine runs entirely in an async task, because that
> > task is started by the PM core and it does the method call.  Hence by
> > the time B's suspend routine is called, A may already have begun
> > suspending -- it's too late to take A's lock.  To make the locking
> > work, B would have to acquire A's lock _before_ B's async task starts.  
> > Since the PM core is unaware of the off-tree dependency, there's no
> > simple way to make it work.
> 
> Do not set async_suspend for B and instead start your own async thread
> from its suspend callback.  The parent-children synchronization is done by the
> core anyway (at least I'd do it that way), so the only thing you need to worry
> about is the extra dependency.

I don't like that because it introduces "artificial" dependencies: It 
makes B depend on all the preceding synchronous suspends, even totally 
unrelated ones.  But yes, it would work.

> I would be slightly more comfortable using completions, but the rwsem-based
> approach is fine with me as well.

On the principle of making things as easy and foolproof as possible for 
driver authors, I also favor completions since it makes dealing with 
non-tree dependencies easier.

However either way would be okay.  I do have to handle some non-tree
dependencies in USB, but oddly enough they affect only resume, not
suspend.  So this "who starts the async task" issue doesn't apply.

Alan Stern

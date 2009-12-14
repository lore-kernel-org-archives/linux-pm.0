From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 00:18:11 +0100
Message-ID: <200912150018.11837.rjw__22413.6019046002$1260832701$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912142311.31658.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
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

On Monday 14 December 2009, Linus Torvalds wrote:
> 
> On Mon, 14 Dec 2009, Rafael J. Wysocki wrote:
> >
> > OK, what about a two-pass approach in which the first pass only inits the
> > completions and starts async threads for leaf "async" devices?  I think leaf
> > devices are most likely to take much time to suspend, so this will give us
> > a chance to save quite some time.
> 
> Why?
> 
> Really.

Because the PCI bridges are not the only case where it matters (I'd say they
are really a corner case).  Basically, any two async devices separeted by a
series of sync ones are likely not to be suspended (or resumed) in parallel
with each other, because the parent is usually next to its children in dpm_list.
So, if the first device suspends, its "synchronous" parent waits for it and the
suspend of the second async device won't be started until the first one's
suspend has returned.  And it doesn't matter at what level we do the async
thing, because dpm_list is there anyway.

As Alan said, the real problem is that we generally can't change the ordering
of dpm_list arbitrarily, because we don't know what's going to happen as a
result.  The async_suspend flag tells us, basically, what devices can be safely
moved to different positions in dpm_list without breaking things, as long as
they are not moved behind their parents or in front of their children.

Starting the async suspends upfront would effectively work in the same way as
moving those devices to the beginning of dpm_list without breaking the
parent-child chains, which in turn is likely to allow us to save some extra
time.

That's not only about the PCI bridges, it's more general.  As far as your
one-liner is concerned, I'm going to test it, because I think we could use it
anyway.

Rafael

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async	suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 22:40:25 -0800
Message-ID: <20091216064025.GB2699__16993.4047190056$1260945795$gmane$org@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912151203.22916.rjw@sisk.pl>
	<alpine.LFD.2.00.0912150722310.14385@localhost.localdomain>
	<200912160311.05915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912160311.05915.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 16, 2009 at 03:11:05AM +0100, Rafael J. Wysocki wrote:
> On Tuesday 15 December 2009, Linus Torvalds wrote:
> > 
> > On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> > > > 
> > > > Give a real example that matters.
> > > 
> > > I'll try.  Let -> denote child-parent relationships and assume dpm_list looks
> > > like this:
> > 
> > No. 
> > 
> > I mean something real - something like
> > 
> >  - if you run on a non-PC with two USB buses behind non-PCI controllers.
> > 
> >  - device xyz.
> > 
> > > If this applies to _resume_ only, then I agree, but the Arjan's data clearly
> > > show that serio devices take much more time to suspend than USB.
> > 
> > I mean in general - something where you actually have hard data that some 
> > device really needs anythign more than my one-liner, and really _needs_ 
> > some complex infrastructure.
> > 
> > Not "let's imagine a case like xyz".
> 
> As I said I would, I made some measurements.
> 
> I measured the total time of suspending and resuming devices as shown by the
> code added by this patch:
> http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commitdiff_plain;h=c1b8fc0a8bff7707c10f31f3d26bfa88e18ccd94;hp=087dbf5f079f1b55cbd3964c9ce71268473d5b67
> on two boxes, HP nx6325 and MSI Wind U100 (hardware-wise they are quite
> different and the HP was running 64-bit kernel and user space).
> 
> I took four cases into consideration:
> (1) synchronous suspend and resume (/sys/power/pm_async = 0)
> (2) asynchronous suspend and resume as introduced by the async branch at:
>     http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=shortlog;h=refs/heads/async
> (3) asynchronous suspend and resume like in (2), but with your one-liner setting
>     the power.async_suspend flag for PCI bridges on top
> (4) asynchronous suspend and resume like in (2), but with an extra patch that
>     is appended on top
> 
> For those tests I set power.async_suspend for all USB devices, all serio input
> devices, the ACPI battery and the USB PCI controllers (to see the impact of the
> one-liner, if any).
> 
> I carried out 5 consecutive suspend-resume cycles (started from under X) on
> each box in each case, and the raw data are here (all times in milliseconds):
> http://www.sisk.pl/kernel/data/async-suspend.pdf
> 
> The summarized data are below (the "big" numbers are averages and the +/-
> numbers are standard deviations, all in milliseconds):
> 
> 			HP nx6325		MSI Wind U100
> 
> sync suspend		1482 (+/- 40)	1180 (+/- 24)
> sync resume		2955 (+/- 2)	3597 (+/- 25)
> 
> async suspend		1553 (+/- 49)	1177 (+/- 32)
> async resume		2692 (+/- 326)	3556  (+/- 33)
> 
> async+one-liner suspend	1600 (+/- 39)	1212 (+/- 41)
> async+one-liner resume	2692 (+/- 324)	3579 (+/- 24)
> 
> async+extra suspend	1496 (+/- 37)	1217 (+/- 38)
> async+extra resume	1859 (+/- 114)	1923 (+/- 35)
> 
> So, in my opinion, with the above set of "async" devices, it doesn't
> make sense to do async suspend at all, because the sync suspend is actually
> the fastest on both machines.

I think the async suspend is not asynchronous enough then - what kind of
time do you get if you simply comment out call to psmouse_reset() in
drivers/input/mouse/psmouse-base.c:psmouse_cleanup()?  (Just for testing
purposes only, I don't think we want to do that by default.)

-- 
Dmitry

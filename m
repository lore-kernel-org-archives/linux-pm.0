From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] DRM / i915: Fix resume regression on MSI
	Wind U100 w/o KMS
Date: Tue, 12 Jan 2010 00:16:43 +0100
Message-ID: <201001120016.43959.rjw__23922.759659081$1263251934$gmane$org@sisk.pl>
References: <201001090045.33784.rjw@sisk.pl> <201001112322.14152.rjw@sisk.pl>
	<21d7e9971001111505ydf12687nbcb752e38efd493c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <21d7e9971001111505ydf12687nbcb752e38efd493c@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Julien Cristau <jcristau@debian.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 January 2010, Dave Airlie wrote:
> On Tue, Jan 12, 2010 at 8:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday 11 January 2010, Julien Cristau wrote:
> >> On Mon, Jan 11, 2010 at 22:04:36 +0100, Rafael J. Wysocki wrote:
> >>
> >> > Hmm, are you trying to say radeon is better at that?
> >> >
> >> > My experience is quite the opposite to be honest.
> >> >
> >> radeon kms is in staging, doesn't pretend to be stable and force all
> >> users to the experimental paths.  So yes, I would say radeon is better
> >> at that.
> >
> > I guess I should have been more precise.
> >
> > All of my test boxes with ATI/AMD graphics hardware regressed after upgrading
> > from openSUSE 11.1 to openSUSE 11.2, in different ways, because of the user
> > space part of the radeon driver.  Of course, you can argue that the dristro
> > picked up particularly bad release of the driver, but from the user's point of
> > view it actually doesn't matter whether the breakage is in the kernel part or
> > in the user space part of the driver.  The difference is, however, that the
> > breakage in the kernel is fixed _way_ faster than the breakage in the user
> > space, so I very much prefer the Intel people pushing new features aggressively
> > and fixing bugs related to that, then the situation where I need to deal with
> > the broken user space driver, while the KMS radeon is still not reliable
> > enough.
> >
> > IOW, if your user space driver worked 100% of the time, I'd totally agree, but
> > that's not the case, at least as far as I see it.
> >
> 
> Are you using the Novell radeonhd driver? (I think SuSE default to this for all
> cards > r500).

No I'm not.

> This isn't the driver that is developed by the opensource community and
> really your distro is where you complain about that sort of regression.

I know, I'm not using it.

> The wierd thing is we see distro picking up fixes for userspace
> drivers *much* quicker
> if their teams are the on the ball since they are only a small
> component to upgrade,
> with the kernel you find most distro fire and forget, so if 2.6.31
> doesn't work on your
> hw you'll wait 6 months to find out that 2.634 doesn't work either.

Well, openSUSE upgrades the kernel to -stable quite timely.  Which is not the
case with the Xorg drivers, so apparently it depends which distro you
are on. :-)

Rafael

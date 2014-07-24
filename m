From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC] suspend/hibernation: Fix racing timers
Date: Thu, 24 Jul 2014 08:59:55 -0700
Message-ID: <b125f213-6799-48bd-9e70-040287264948@BN1AFFO11FD033.protection.gbl>
References: <1405964152-17865-1-git-send-email-soren.brinkmann@xilinx.com>
 <53D083C5.2000501@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:36593
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932207AbaGXP77 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Jul 2014 11:59:59 -0400
Content-Disposition: inline
In-Reply-To: <53D083C5.2000501@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

Hi John,

On Wed, 2014-07-23 at 08:55PM -0700, John Stultz wrote:
> On 07/21/2014 10:35 AM, Soren Brinkmann wrote:
> > On platforms that do not power off during suspend, successfully ent=
ering
> > suspend races with timers.
> >
> > The race happening in a couple of location is:
> >
> >   1. disable IRQs 	(e.g. arch_suspend_disable_irqs())
> >      ...
> >   2. syscore_suspend()
> >         -> tick_suspend() 	(timers are turned off here)
> >      ...
> >   3. wfi		(wait for wake-IRQ here)
> >
> > Between steps 1 and 2 the timers can still generate interrupts that=
 are
> > not handled and stay pending until step 3. That pending IRQ causes =
an
> > immediate - spurious - wake.
> >
> > The solution is to remove the timekeeping suspend/resume functions =
from
> > the syscore functions and explictly call them at the appropriate ti=
me in
> > the suspend/hibernation patchs. I.e. timers are suspend _before_ IR=
Qs
> > get disabled. And accordingly in the resume path.
>=20
> So.. I sort of follow this, though from the description disabling
> timekeeping to turn off timers seems a little indirect (I do see that
> suspending timekeeping calls clockevents_suspend() which is the key
> part). Maybe this could be clarified in a future version of the patch
> description?
>=20
> I worry that moving timekeeping_suspend earlier in the suspend proces=
s
> might cause problems where things access time in the suspend path. I
> recall these orderings have been problematic in the past, and slightl=
y
> tweaking them can often destabilize things badly.

You're right. Just when I received this I started seeing some warning
from the kernel due to ktime_get() called with timekeeping being
suspended.
Though, stability-wise it seems to work.

>=20
> I wonder if it would be better just to move the clockevent_suspend()
> call to the earlier site, that way timers are halted but timekeeping
> continues until its normal suspend point.

I'll look into this and send out a patch once I have something working.

	Thanks,
	S=C3=B6ren

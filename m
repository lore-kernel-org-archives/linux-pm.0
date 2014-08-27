From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] PM / sleep: Fix racing timers
Date: Tue, 26 Aug 2014 17:35:07 -0700
Message-ID: <64c2b0ef-39e9-4194-aec1-8026b7fbe272@BY2FFO11FD014.protection.gbl>
References: <1408568109-30297-1-git-send-email-soren.brinkmann@xilinx.com>
 <19851825.qu8r5WDRRO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19851825.qu8r5WDRRO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-08-27 at 02:32AM +0200, Rafael J. Wysocki wrote:
> Hi,
>=20
> Sorry for being somewhat slow to respond to this, but I'm not sure if=
 the
> approach here is the right one.
>=20
> On Wednesday, August 20, 2014 01:55:09 PM Soren Brinkmann wrote:
> > On platforms that do not power off during suspend, successfully ent=
ering
> > suspend races with timers.
> >=20
> > The race happening in a couple of location is:
> >=20
> >   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
> >      ...
> >   2. syscore_suspend()
> >       -> timekeeping_suspend()
> >        -> clockevents_notify(SUSPEND)
> >         -> tick_suspend()   	(timers are turned off here)
> >      ...
> >   3. wfi            		(wait for wake-IRQ here)
> >=20
> > Between steps 1 and 2 the timers can still generate interrupts that=
 are
> > not handled and stay pending until step 3. That pending IRQ causes =
an
> > immediate - spurious - wake.
>=20
> Well, the problem here is that the platform is not supposed to re-ena=
ble
> interrupts after syscore_suspend().  Of course, some platforms do tha=
t, because
> they don't really support system sleep and try to emulate it with som=
ething
> along the lines of suspend-to-idle.

No, IRQs are not enabled after syscore-suspend. But the wait for
interrupt state on ARM is left even with IRQs disabled. It will prevent
the core from taking the exception, but it will "wake" it up. So, my
impressions was that the core is the appropriate location to fix this. =
I
wouldn't know where else to do it.

It is certainly an issue caused by this probably non-standard suspend
state, but if we accept this implementation as a valid suspend
implementation, I'd say it's a core issue.

	Thanks,
	S=C3=B6ren

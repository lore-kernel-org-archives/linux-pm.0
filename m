From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2] PM / sleep: Fix racing timers
Date: Tue, 29 Jul 2014 16:22:31 -0700
Message-ID: <cdd55961-e247-4385-b86e-a0a0b794ab58@BN1BFFO11FD020.protection.gbl>
References: <53D083C5.2000501@linaro.org>
 <1406322408-15408-1-git-send-email-soren.brinkmann@xilinx.com>
 <53D6A23A.6010904@codeaurora.org> <53D6A36B.1070105@linaro.org>
 <53D6A6B3.4060507@codeaurora.org>
 <d7b265bb-546f-4e86-8e81-197edd1757c5@BN1AFFO11FD007.protection.gbl>
 <53D828A0.1080408@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53D828A0.1080408@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-07-29 at 04:05PM -0700, Stephen Boyd wrote:
> On 07/28/14 13:02, S=C3=B6ren Brinkmann wrote:
> > On Mon, 2014-07-28 at 12:38PM -0700, Stephen Boyd wrote:
> >>
> >> Agreed. Perhaps I put it the wrong way. I'm worried that some time=
r
> >> needs to run just when we go into suspend. As long as that timer i=
s the
> >> scheduler tick we should be ok, but if it isn't the scheduler tick=
 then
> >> it would be good to know what it is and why it's pending. Unless t=
he
> >> idea is that if we get this far into suspend and there's a pending=
 timer
> >> we should just ignore it and go to sleep anyway?
> > Well, that is pretty much what happens currently. The IRQs are disa=
bled
> > and nobody cares about the pending timer.=20
>=20
> Yep. It sounds like we don't know what it is so let's hope it's the
> sched tick. I suspect that driver suspend paths are canceling their
> timers because their hardware has been quiesced.
Drivers probably, as well as the suspend path in general, mask all non-=
timer
and non-wakeup interrupts.

>=20
> > My problem with that is, that
> > "suspend" for Zynq is just waiting in WFI. Hence, the pending inter=
rupts
> > causes an immediate resume.
> > So, it should hopefully be more or less fine since the current
> > implementation basically ignores the timer. With this patch we just=
 shut
> > them down a little earlier to prevent this pending interrupt - at l=
east
> > that is the intention.
> >
>=20
> That sort of WFI based suspend doesn't actually sound like a memory
> suspend at all. It's really the "freeze" state where we would sit in =
the
> deepest CPU idle state waiting for some prescribed wakeup event (powe=
r
> button press, etc.) that would then trigger a wakeup_source to be
> activated and then wakeup the suspend thread.
>=20
> Unless the WFI actually triggers some power state controller? For
> example, on the ARM platforms I have we trigger suspend via a WFI, wh=
ich
> causes a power state controller to pull the power from the CPU that
> triggered the WFI and then goes ahead and turns off the rest of the S=
oC
> power and puts the ddr in self-refresh. If we have a pending irq then
> the power state controller would abort suspend and we'd come right ba=
ck
> almost immediately (similar to your situation). The thing is we don't
> see any pending irqs and we don't have this patch, so I wonder if we
> just haven't hit this case, or if there's something more fundamental
> going on that causes a difference. Or maybe we do see this pending ir=
q
> sometimes but we don't care because we'll try and go right back to
> suspend again.
On Zynq we don't have such sophisticated external helpers. The ARM core
does everything on its own and power down is pretty much impossible by
design.
So, for Zynq we enable some low power features, move execution to OCM,
shut down PLLs and DRAM as far as possible and then just sit in wfi
(which might trigger some external low power features like SCU and L2$
standby etc.), but no smart external power controller.

One thing that might make this happen on Zynq more frequently is
that we use a 16-bit timer. I guess that timer overflowing all the
time probably causes more frequent interrupts than you'd see on
platforms with wider timers. After all the window in which this
problem would occur is rather small.

	Thanks,
	S=C3=B6ren

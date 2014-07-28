From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2] PM / sleep: Fix racing timers
Date: Mon, 28 Jul 2014 13:02:25 -0700
Message-ID: <d7b265bb-546f-4e86-8e81-197edd1757c5@BN1AFFO11FD007.protection.gbl>
References: <53D083C5.2000501@linaro.org>
 <1406322408-15408-1-git-send-email-soren.brinkmann@xilinx.com>
 <53D6A23A.6010904@codeaurora.org> <53D6A36B.1070105@linaro.org>
 <53D6A6B3.4060507@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:41020
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751162AbaG1UCn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jul 2014 16:02:43 -0400
Content-Disposition: inline
In-Reply-To: <53D6A6B3.4060507@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, 2014-07-28 at 12:38PM -0700, Stephen Boyd wrote:
> On 07/28/14 12:24, John Stultz wrote:
> > On 07/28/2014 12:19 PM, Stephen Boyd wrote:
> >> On 07/25/14 14:06, Soren Brinkmann wrote:
> >>> On platforms that do not power off during suspend, successfully e=
ntering
> >>> suspend races with timers.
> >>>
> >>> The race happening in a couple of location is:
> >>>
> >>>   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
> >>>      ...
> >>>   2. syscore_suspend()
> >>>       -> timekeeping_suspend()
> >>>        -> clockevents_notify(SUSPEND)
> >>>         -> tick_suspend()   	(timers are turned off here)
> >>>      ...
> >>>   3. wfi            		(wait for wake-IRQ here)
> >>>
> >>> Between steps 1 and 2 the timers can still generate interrupts th=
at are
> >>> not handled and stay pending until step 3. That pending IRQ cause=
s an
> >>> immediate - spurious - wake.
> >>>
> >>> The solution is to move the clockevents suspend/resume notificati=
on
> >>> out of the syscore_suspend step and explictly call them at the ap=
propriate
> >>> time in the suspend/hibernation paths. I.e. timers are suspend _b=
efore_
> >>> IRQs get disabled. And accordingly in the resume path.
> >>>
> >>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >> Do we know which timer_list or hrtimer wants to run while entering
> >> suspend? I'd suspect the scheduler tick but perhaps we just forgot=
 to
> >> cancel some timer during suspend?
> > Though, canceling timers really shouldn't be necessary for
> > suspend/resume, no?
> >
> >
>=20
> Agreed. Perhaps I put it the wrong way. I'm worried that some timer
> needs to run just when we go into suspend. As long as that timer is t=
he
> scheduler tick we should be ok, but if it isn't the scheduler tick th=
en
> it would be good to know what it is and why it's pending. Unless the
> idea is that if we get this far into suspend and there's a pending ti=
mer
> we should just ignore it and go to sleep anyway?

Well, that is pretty much what happens currently. The IRQs are disabled
and nobody cares about the pending timer. My problem with that is, that
"suspend" for Zynq is just waiting in WFI. Hence, the pending interrupt=
s
causes an immediate resume.
So, it should hopefully be more or less fine since the current
implementation basically ignores the timer. With this patch we just shu=
t
them down a little earlier to prevent this pending interrupt - at least
that is the intention.

	Thanks,
	S=C3=B6ren

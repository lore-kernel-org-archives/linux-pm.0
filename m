From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2] PM / sleep: Fix racing timers
Date: Mon, 28 Jul 2014 08:51:18 -0700
Message-ID: <db9a4d35-891e-4b66-aa70-25c1f65012fd@BN1BFFO11FD021.protection.gbl>
References: <53D083C5.2000501@linaro.org>
 <1406322408-15408-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140728100538.GA16237@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0144.outbound.protection.outlook.com ([207.46.163.144]:18770
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752161AbaG1PvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jul 2014 11:51:24 -0400
Content-Disposition: inline
In-Reply-To: <20140728100538.GA16237@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, 2014-07-28 at 12:05PM +0200, Pavel Machek wrote:
> On Fri 2014-07-25 14:06:48, Soren Brinkmann wrote:
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
> >=20
> > The solution is to move the clockevents suspend/resume notification
> > out of the syscore_suspend step and explictly call them at the appr=
opriate
> > time in the suspend/hibernation paths. I.e. timers are suspend _bef=
ore_
> > IRQs get disabled. And accordingly in the resume path.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>=20
> Did you test the hibernation?
No, I don't have a system to test hibernation. Suspend seems to work
fine though.

	S=C3=B6ren

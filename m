From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: PM: knowing the system state in the device callback
Date: Tue, 17 Mar 2015 09:38:15 +0100
Message-ID: <20150317093815.360a8e79@bbrezillon>
References: <20150316191742.GI4560@piout.net>
	<20150316205245.1b66bbea@bbrezillon>
	<20150316203252.GA3821@gradator.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40644 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008AbbCQIi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 04:38:28 -0400
In-Reply-To: <20150316203252.GA3821@gradator.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org

Hi Sylvain,

On Mon, 16 Mar 2015 21:32:52 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Hi,
>=20
>=20
> On Mon, Mar 16, 2015 at 08:52:45PM +0100, Boris Brezillon wrote:
> > Hi Alexandre,
> >=20
> > On Mon, 16 Mar 2015 20:17:42 +0100
> > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> >=20
> > > Hi,
> > >=20
> > > I'm trying to get rid of at91_suspend_entering_slow_clock() which=
 is
> > > exposing the platform suspend_state_t to the devices. From what I
> > > understand, whenever suspend_state_t is PM_SUSPEND_MEM or
> > > PM_SUSPEND_STANDBY, the pm_message_t passed to the device driver =
is
> > > always PM_EVENT_SUSPEND.
> > >=20
> > > The requirement is to know whether we are going to cut the master=
 clock
> > > and in that case, avoid calling enable_irq_wake() because we will=
 not be
> > > able to wakeup from the device.
> >=20
> > Actually the master clock is never switched off, we're only changin=
g
> > its source (from PLLA to slow clk) which in turn changes its rate.
>=20
> That's more or less the same, the master clock set to 32k is unusable=
=20
> for almost all devices. I guess all except some very simple devices l=
ike=20
> GPIO, AIC and PM controller.

Okay, I thought suspend-to-ram was only implying putting the SDRAM chip
in self-refresh, and stopping everything that can be stopped.
In the existing code we're actually forcing the switch to the slow
clock even if some devices marked as wakeup sources need a fast master
clock.

>=20
>=20
> > > Is there a better way to do that? Or should I implement a similar
> > > function in the pm core (which I guess would already be there if
> > > really needed)?
> >=20
> > IMHO we should let devices (RTC/RTT, debug UART, GPIOC, ...) mark t=
heir
> > interrupt line as a wakeup interrupt, and adapt the device
> > configuration (UART baudrate, ...) according to the new master cloc=
k
> > rate instead of testing the suspend mode to check whether we can ma=
rk
> > irq lines as wakeup sources or not.
>=20
> We are using a 32k clock, 115.2 bits/s which is very common is 3.5x=20
> faster than tje 32k clock.

Right.

> And, to reduce a bit more the memory=20
> consumption we can switch of to the 32k RC and not OSC (I do!), which=
 is=20
> =C2=B110% off, that's way too much for UART.

Hm, I think we should stay focus on the mainline code for now, but I
understand your concern.

>=20
> Also, if standby target is chosen, we are able to wake up on USB Host=
=20
> wake-up events, which needs the USB PLL to be running. If mem target =
is=20
> chosen we are going to switch off the USB PLL because we are going to=
=20
> switch off the PLL source, the master clock, in this case we most ens=
ure=20
> all USB drivers switches off their controller (this is what my USBA a=
nd=20
> EHCI/OHCI PM series did).

Well, IMO we should never guess what the user want to do (and that's
what we're currently doing in the existing code).
If someone marked the USB controller as a wakeup source, then we should
keep the USB device active even when entering suspend-to-ram mode.
If this mean consuming more power when USB is a wakeup source, then
it should be fine, because in the end it's the user who chooses which
device should be a wakeup source (through sysfs), and if he really
wants to consume less, he can decide to disable wakeup on USB events.
In the other, letting the user think the system can wakeup on USB while
it actually can't is a bit broken.

>=20
>=20
> > The fact that we're disabling PLLA is not really related to
> > suspend-to-ram mode (we could leave the master clock unchanged and
> > still put the SDRAM chip in self-refresh mode).
>=20
> This is what we do in standby target.

Ok, thanks for the pointer. I though standy mode was just some kind of
cpuidle with a few devices disables (thanks to the PM ops implemented
in each drivers), but apparently I was wrong.

>=20
>=20
> > The problem here is that we need some kind of notifier infrastructu=
re
> > that would be called before the master clock source is switched to =
slow
> > clock. This notifier must be written in asm so that it can be calle=
d
> > from the asm code executed from SRAM (the SDRAM chip is placed in s=
elf
> > refresh before switching to slow clock).
>=20
> I don't think that's possible, some drivers needs to know the master=20
> clock is going to be switched off (USB).

Yep, you're right again.

Here is another approach thought about:
1/ use clock constraints in device drivers to forbid any change on the
   main clock
2/ remove this constraint when suspend is called if the device is not
   tagged as a wakeup source, or keep it if it is.
3/ call a 'clk_test_rate' function in PM code to check if we can
   switch to a 32kHz clk (clk_test_rate(mck, 32768)).
   This clk_test_rate does not exist, but it would validate all mck
   users constraint, returning an error code if the constraints does
   not allow such a rate or 0 on success.

This is just an idea.
Maybe exposing the current suspend state and testing its value in each
driver is more appropriate, but from a user point of view, I find it
weird to silently ignore the wakeup configuration on some devices when
entering suspend-to-ram.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: PM: knowing the system state in the device callback
Date: Tue, 17 Mar 2015 11:46:28 +0100
Message-ID: <20150317104627.GA4895@gradator.net>
References: <20150316191742.GI4560@piout.net>
 <20150316205245.1b66bbea@bbrezillon>
 <20150316203252.GA3821@gradator.net>
 <20150317093815.360a8e79@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:34923 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbbCQKqe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 06:46:34 -0400
Content-Disposition: inline
In-Reply-To: <20150317093815.360a8e79@bbrezillon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Mar 17, 2015 at 09:38:15AM +0100, Boris Brezillon wrote:
> On Mon, 16 Mar 2015 21:32:52 +0100
> Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> > On Mon, Mar 16, 2015 at 08:52:45PM +0100, Boris Brezillon wrote:
> > > On Mon, 16 Mar 2015 20:17:42 +0100
> > > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > > >=20
> > > > I'm trying to get rid of at91_suspend_entering_slow_clock() whi=
ch is
> > > > exposing the platform suspend_state_t to the devices. From what=
 I
> > > > understand, whenever suspend_state_t is PM_SUSPEND_MEM or
> > > > PM_SUSPEND_STANDBY, the pm_message_t passed to the device drive=
r is
> > > > always PM_EVENT_SUSPEND.
> > > >=20
> > > > The requirement is to know whether we are going to cut the mast=
er clock
> > > > and in that case, avoid calling enable_irq_wake() because we wi=
ll not be
> > > > able to wakeup from the device.
> > >=20
> > > Actually the master clock is never switched off, we're only chang=
ing
> > > its source (from PLLA to slow clk) which in turn changes its rate=
=2E
> >=20
> > That's more or less the same, the master clock set to 32k is unusab=
le=20
> > for almost all devices. I guess all except some very simple devices=
 like=20
> > GPIO, AIC and PM controller.
>=20
> Okay, I thought suspend-to-ram was only implying putting the SDRAM ch=
ip
> in self-refresh, and stopping everything that can be stopped.

That's the standby target. What we have currently in linux-next for AT9=
1=20
is:

mem target: all PLL stopped, master clock switched slow clock(32k),
            self-refresh, "all" drivers forced suspend even if wake-up
            flag is set, wait-for-interrupt

standby target: fast clocks active(PLL A, USB PLL), self-refresh,
                "all" drivers suspended but wake-up flag is respected
                (e.g. USB controller is NOT suspended if wake-up flag i=
s set),
                wait-for-interrupt


> In the existing code we're actually forcing the switch to the slow
> clock even if some devices marked as wakeup sources need a fast maste=
r
> clock.

Yes, in this case we currently discard the wakeup flag, this is bad.


> > And, to reduce a bit more the memory=20
> > consumption we can switch of to the 32k RC and not OSC (I do!), whi=
ch is=20
> > =C2=B110% off, that's way too much for UART.
>=20
> Hm, I think we should stay focus on the mainline code for now, but I
> understand your concern.

This is what mainline is doing, at least on SAMA5D3 ;-)


> > Also, if standby target is chosen, we are able to wake up on USB Ho=
st=20
> > wake-up events, which needs the USB PLL to be running. If mem targe=
t is=20
> > chosen we are going to switch off the USB PLL because we are going =
to=20
> > switch off the PLL source, the master clock, in this case we most e=
nsure=20
> > all USB drivers switches off their controller (this is what my USBA=
 and=20
> > EHCI/OHCI PM series did).
>=20
> Well, IMO we should never guess what the user want to do (and that's
> what we're currently doing in the existing code).
> If someone marked the USB controller as a wakeup source, then we shou=
ld
> keep the USB device active even when entering suspend-to-ram mode.
> If this mean consuming more power when USB is a wakeup source, then
> it should be fine, because in the end it's the user who chooses which
> device should be a wakeup source (through sysfs), and if he really
> wants to consume less, he can decide to disable wakeup on USB events.
> In the other, letting the user think the system can wakeup on USB whi=
le
> it actually can't is a bit broken.

I mostly agree. In my opinion we should just abort the mem target=20
suspend if some peripherals have wake-up bit set and need the master=20
clock (or USB PLL, or PLL B, or any clock divider/multiplier from maste=
r=20
clock) to do wake up. We are actually more or less doing that using the=
=20
at91_pm_verify_clocks() function.


> > > The fact that we're disabling PLLA is not really related to
> > > suspend-to-ram mode (we could leave the master clock unchanged an=
d
> > > still put the SDRAM chip in self-refresh mode).
> >=20
> > This is what we do in standby target.
>=20
> Ok, thanks for the pointer. I though standy mode was just some kind o=
f
> cpuidle with a few devices disables (thanks to the PM ops implemented
> in each drivers), but apparently I was wrong.

Yes, the only difference between standby and mem target is the switch t=
o=20
slow clock mode.


> > > The problem here is that we need some kind of notifier infrastruc=
ture
> > > that would be called before the master clock source is switched t=
o slow
> > > clock. This notifier must be written in asm so that it can be cal=
led
> > > from the asm code executed from SRAM (the SDRAM chip is placed in=
 self
> > > refresh before switching to slow clock).
> >=20
> > I don't think that's possible, some drivers needs to know the maste=
r=20
> > clock is going to be switched off (USB).
>=20
> Yep, you're right again.
>=20
> Here is another approach thought about:
> 1/ use clock constraints in device drivers to forbid any change on th=
e
>    main clock
> 2/ remove this constraint when suspend is called if the device is not
>    tagged as a wakeup source, or keep it if it is.
> 3/ call a 'clk_test_rate' function in PM code to check if we can
>    switch to a 32kHz clk (clk_test_rate(mck, 32768)).
>    This clk_test_rate does not exist, but it would validate all mck
>    users constraint, returning an error code if the constraints does
>    not allow such a rate or 0 on success.
>=20
> This is just an idea.
> Maybe exposing the current suspend state and testing its value in eac=
h
> driver is more appropriate,

Well, I don't know if it's more appropriate or not, but testing the=20
suspend state is much much simpler than adding a clk_test_rate() :-)


> but from a user point of view, I find it weird to silently ignore the=
=20
> wakeup configuration on some devices when entering suspend-to-ram.

I agree that's weird.


Sylvain=09

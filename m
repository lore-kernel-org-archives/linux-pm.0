From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RESEND] PM / sleep: Fix racing timers
Date: Fri, 23 Jan 2015 09:46:47 -0800
Message-ID: <5340dc237cfc4d48895a01087c3ffa4c@BL2FFO11FD015.protection.gbl>
References: <1411405623-7869-1-git-send-email-soren.brinkmann@xilinx.com>
 <1025ebd0a9984037bf15adf3ae4889d9@BN1BFFO11FD013.protection.gbl>
 <99d5bcca1d6541a49ff8a9f41f9b18af@BL2FFO11FD039.protection.gbl>
 <12360948.gSvRbI0dui@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12360948.gSvRbI0dui@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-01-12 at 12:20AM +0100, Rafael J. Wysocki wrote:
> On Friday, January 09, 2015 01:50:59 PM S=C3=B6ren Brinkmann wrote:
> > On Sat, 2014-11-08 at 03:56PM -0800, S=C3=B6ren Brinkmann wrote:
> > > Hi Rafael,
> > >=20
> > > On Thu, 2014-11-06 at 01:33AM +0100, Rafael J. Wysocki wrote:
> > > > On Thursday, October 02, 2014 09:01:15 AM S=C3=B6ren Brinkmann =
wrote:
> > > > > Hi Rafael,
> > > >=20
> > > > Hi,
> > > >=20
> > > > Sorry for the huge delay.
> > > >=20
> > > > > On Tue, 2014-09-23 at 01:01AM +0200, Rafael J. Wysocki wrote:
> > > > > > On Monday, September 22, 2014 10:07:03 AM Soren Brinkmann w=
rote:
> > > > > > > On platforms that do not power off during suspend, succes=
sfully entering
> > > > > > > suspend races with timers.
> > > > > > >=20
> > > > > > > The race happening in a couple of location is:
> > > > > > >=20
> > > > > > >   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
> > > > > > >      ...
> > > > > > >   2. syscore_suspend()
> > > > > > >       -> timekeeping_suspend()
> > > > > > >        -> clockevents_notify(SUSPEND)
> > > > > > >         -> tick_suspend()   	(timers are turned off here)
> > > > > > >      ...
> > > > > > >   3. wfi            		(wait for wake-IRQ here)
> > > > > > >=20
> > > > > > > Between steps 1 and 2 the timers can still generate inter=
rupts that are
> > > > > > > not handled and stay pending until step 3. That pending I=
RQ causes an
> > > > > > > immediate - spurious - wake.
> > > > > > >=20
> > > > > > > The solution is to move the clockevents suspend/resume no=
tification
> > > > > > > out of the syscore_suspend step and explictly call them a=
t the appropriate
> > > > > > > time in the suspend/hibernation paths. I.e. timers are su=
spend _before_
> > > > > > > IRQs get disabled. And accordingly in the resume path.
> > > > > > >=20
> > > > > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.co=
m>
> > > > > > > ---
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > there was not a lot of discussion on the last submission.=
 Just one comment from
> > > > > > > Rafael (https://lkml.org/lkml/2014/8/26/780), which - as =
I outlined in my
> > > > > > > response, does not apply, IMHO, since the platform does n=
ot re-enable
> > > > > > > interrupts.
> > > > > >=20
> > > > > > Well, you just don't agree with it.
> > > > > >=20
> > > > > > The problem with your approach is that timer interrupts are=
n't actually as
> > > > > > special as you think and any other IRQF_NO_SUSPEND interrup=
ts would have caused
> > > > > > similar issues to appear under specific conditions.
> > > > > >=20
> > > > > > The solution I would suggest and that actually covers all I=
RQF_NO_SUSPEND
> > > > > > interrupts would be to use a wait_event() loop like the one=
 in freeze_enter()
> > > > > > (on top of the current linux-next or the pm-genirq branch o=
f linux-pm.git),
> > > > > > but wait for pm_abort_suspend to become true, to implement =
system suspend.
> > > > >=20
> > > > > sorry, it took me a while since I needed to get some dependen=
cies ported
> > > > > to the pm-genirq base. Once I had that, it reproduced my orig=
inal issue.
> > > > > So far so good. I then looked into finding a solution followi=
ng your
> > > > > guidance. I'm not sure I really found what you had in mind, b=
ut below is
> > > > > what I came up with, which seems to do it.
> > > > > Please let me know how far off I am.
> > > > >=20
> > > > > 	Thanks,
> > > > > 	S=C3=B6ren
> > > > >=20
> > > > > -------8<------------------8<----------------8<--------------=
--8<---------------
> > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power=
/wakeup.c
> > > > > index c2744b30d5d9..a4f9914571f1 100644
> > > > > --- a/drivers/base/power/wakeup.c
> > > > > +++ b/drivers/base/power/wakeup.c
> > > > > @@ -25,7 +25,7 @@
> > > > >  bool events_check_enabled __read_mostly;
> > > > > =20
> > > > >  /* If set and the system is suspending, terminate the suspen=
d. */
> > > > > -static bool pm_abort_suspend __read_mostly;
> > > > > +bool pm_abort_suspend __read_mostly;
> > > > > =20
> > > > >  /*
> > > > >   * Combined counters of registered wakeup events and wakeup =
events in progress.
> > > > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > > > index 6dadb25cb0d8..e6a6de8f76d0 100644
> > > > > --- a/kernel/power/suspend.c
> > > > > +++ b/kernel/power/suspend.c
> > > > > @@ -33,6 +33,7 @@
> > > > > =20
> > > > >  static const char *pm_labels[] =3D { "mem", "standby", "free=
ze", };
> > > > >  const char *pm_states[PM_SUSPEND_MAX];
> > > > > +extern bool pm_abort_suspend;
> > > > > =20
> > > > >  static const struct platform_suspend_ops *suspend_ops;
> > > > >  static const struct platform_freeze_ops *freeze_ops;
> > > > > @@ -294,25 +295,27 @@ static int suspend_enter(suspend_state_=
t state, bool *wakeup)
> > > > >  	if (error || suspend_test(TEST_CPUS))
> > > > >  		goto Enable_cpus;
> > > > > =20
> > > > > -	arch_suspend_disable_irqs();
> > > > > -	BUG_ON(!irqs_disabled());
> > > > > -
> > > > > -	error =3D syscore_suspend();
> > > > > -	if (!error) {
> > > > > -		*wakeup =3D pm_wakeup_pending();
> > > > > -		if (!(suspend_test(TEST_CORE) || *wakeup)) {
> > > > > -			trace_suspend_resume(TPS("machine_suspend"),
> > > > > -				state, true);
> > > > > -			error =3D suspend_ops->enter(state);
> > > > > -			trace_suspend_resume(TPS("machine_suspend"),
> > > > > -				state, false);
> > > > > -			events_check_enabled =3D false;
> > > > > +	while (!pm_abort_suspend) {
> > > >=20
> > > > That won't work in general, because pm_abort_suspend may not be=
 set on some
> > > > platforms on wakeup.  It is only set if a wakeup interrupt trig=
gers which
> > > > may not be the case on ACPI systems if the BIOS has woken up th=
e system.
> > > >=20
> > > > But that could be addressed by making those platforms simply se=
t pm_wakeup_pending
> > > > in their BIOS exit path.
> > > >=20
> > > > > +		arch_suspend_disable_irqs();
> > > > > +		BUG_ON(!irqs_disabled());
> > > > > +
> > > > > +		error =3D syscore_suspend();
> > > >=20
> > > > Also it shouldn't be necessary to do syscore_suspend()/syscore_=
resume() in
> > > > every iteration of the loop.
> > > >=20
> > > > > +		if (!error) {
> > > > > +			*wakeup =3D pm_wakeup_pending();
> > > >=20
> > > > Plus pm_wakeup_pending() returns true if pm_abort_suspend is se=
t
> > > >=20
> > > > > +			if (!(suspend_test(TEST_CORE) || *wakeup)) {
> > > > > +				trace_suspend_resume(TPS("machine_suspend"),
> > > > > +					state, true);
> > > >=20
> > > > Did you try to add the loop here instead of above?  Like:
> > > >=20
> > > > 			for (;;) {
> > > > 				*wakeup =3D pm_wakeup_pending();
> > > > 				if (*wakeup)
> > > > 					break;
> > >=20
> > > I think, that doesn't work. I chose the start/end points of the l=
oop
> > > to include the IRQ enable/disable calls. AFAICT, pm_abort_suspend=
 is
> > > set in an ISR. Without enabling interrupts the abort condition of
> > > this loop never becomes true.
> >=20
> > Any further ideas how to resolve this?
>=20
> Sorry about the delay, lost track of this.
>=20
> You're right, the IRQ disabling/enabling needs to happen in the loop.
>=20
> So the direction of the patch looks OK, but it needs to ensure that p=
m_wakeup_pending
> is set properly by all platforms.  Also it should be sufficient to ch=
eck
> pm_wakeup_pending() to detect wakeup.
>=20
> Have you tested the patch?=20

I have to look into this, rebase my stuff and test again. May take a
while, but I'll stay on it.
Regarding testing: I don't have platforms to really test this on other
than my Zynq platforms where I see this issue on. It worked for me
there, but rebasing just broke something.

	Thanks,
	S=C3=B6ren

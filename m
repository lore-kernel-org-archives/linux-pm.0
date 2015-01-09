From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RESEND] PM / sleep: Fix racing timers
Date: Fri, 9 Jan 2015 13:50:59 -0800
Message-ID: <99d5bcca1d6541a49ff8a9f41f9b18af@BL2FFO11FD039.protection.gbl>
References: <1411405623-7869-1-git-send-email-soren.brinkmann@xilinx.com>
 <1860362.OyoLA3GxVJ@vostro.rjw.lan>
 <fadb1f7b-82bf-4dbd-bfd4-ca24daca0a8f@BN1AFFO11FD060.protection.gbl>
 <1803639.rQE0urO8Tr@vostro.rjw.lan>
 <1025ebd0a9984037bf15adf3ae4889d9@BN1BFFO11FD013.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1025ebd0a9984037bf15adf3ae4889d9@BN1BFFO11FD013.protection.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2014-11-08 at 03:56PM -0800, S=C3=B6ren Brinkmann wrote:
> Hi Rafael,
>=20
> On Thu, 2014-11-06 at 01:33AM +0100, Rafael J. Wysocki wrote:
> > On Thursday, October 02, 2014 09:01:15 AM S=C3=B6ren Brinkmann wrot=
e:
> > > Hi Rafael,
> >=20
> > Hi,
> >=20
> > Sorry for the huge delay.
> >=20
> > > On Tue, 2014-09-23 at 01:01AM +0200, Rafael J. Wysocki wrote:
> > > > On Monday, September 22, 2014 10:07:03 AM Soren Brinkmann wrote=
:
> > > > > On platforms that do not power off during suspend, successful=
ly entering
> > > > > suspend races with timers.
> > > > >=20
> > > > > The race happening in a couple of location is:
> > > > >=20
> > > > >   1. disable IRQs   		(e.g. arch_suspend_disable_irqs())
> > > > >      ...
> > > > >   2. syscore_suspend()
> > > > >       -> timekeeping_suspend()
> > > > >        -> clockevents_notify(SUSPEND)
> > > > >         -> tick_suspend()   	(timers are turned off here)
> > > > >      ...
> > > > >   3. wfi            		(wait for wake-IRQ here)
> > > > >=20
> > > > > Between steps 1 and 2 the timers can still generate interrupt=
s that are
> > > > > not handled and stay pending until step 3. That pending IRQ c=
auses an
> > > > > immediate - spurious - wake.
> > > > >=20
> > > > > The solution is to move the clockevents suspend/resume notifi=
cation
> > > > > out of the syscore_suspend step and explictly call them at th=
e appropriate
> > > > > time in the suspend/hibernation paths. I.e. timers are suspen=
d _before_
> > > > > IRQs get disabled. And accordingly in the resume path.
> > > > >=20
> > > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > > ---
> > > > > Hi,
> > > > >=20
> > > > > there was not a lot of discussion on the last submission. Jus=
t one comment from
> > > > > Rafael (https://lkml.org/lkml/2014/8/26/780), which - as I ou=
tlined in my
> > > > > response, does not apply, IMHO, since the platform does not r=
e-enable
> > > > > interrupts.
> > > >=20
> > > > Well, you just don't agree with it.
> > > >=20
> > > > The problem with your approach is that timer interrupts aren't =
actually as
> > > > special as you think and any other IRQF_NO_SUSPEND interrupts w=
ould have caused
> > > > similar issues to appear under specific conditions.
> > > >=20
> > > > The solution I would suggest and that actually covers all IRQF_=
NO_SUSPEND
> > > > interrupts would be to use a wait_event() loop like the one in =
freeze_enter()
> > > > (on top of the current linux-next or the pm-genirq branch of li=
nux-pm.git),
> > > > but wait for pm_abort_suspend to become true, to implement syst=
em suspend.
> > >=20
> > > sorry, it took me a while since I needed to get some dependencies=
 ported
> > > to the pm-genirq base. Once I had that, it reproduced my original=
 issue.
> > > So far so good. I then looked into finding a solution following y=
our
> > > guidance. I'm not sure I really found what you had in mind, but b=
elow is
> > > what I came up with, which seems to do it.
> > > Please let me know how far off I am.
> > >=20
> > > 	Thanks,
> > > 	S=C3=B6ren
> > >=20
> > > -------8<------------------8<----------------8<----------------8<=
---------------
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wak=
eup.c
> > > index c2744b30d5d9..a4f9914571f1 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -25,7 +25,7 @@
> > >  bool events_check_enabled __read_mostly;
> > > =20
> > >  /* If set and the system is suspending, terminate the suspend. *=
/
> > > -static bool pm_abort_suspend __read_mostly;
> > > +bool pm_abort_suspend __read_mostly;
> > > =20
> > >  /*
> > >   * Combined counters of registered wakeup events and wakeup even=
ts in progress.
> > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > index 6dadb25cb0d8..e6a6de8f76d0 100644
> > > --- a/kernel/power/suspend.c
> > > +++ b/kernel/power/suspend.c
> > > @@ -33,6 +33,7 @@
> > > =20
> > >  static const char *pm_labels[] =3D { "mem", "standby", "freeze",=
 };
> > >  const char *pm_states[PM_SUSPEND_MAX];
> > > +extern bool pm_abort_suspend;
> > > =20
> > >  static const struct platform_suspend_ops *suspend_ops;
> > >  static const struct platform_freeze_ops *freeze_ops;
> > > @@ -294,25 +295,27 @@ static int suspend_enter(suspend_state_t st=
ate, bool *wakeup)
> > >  	if (error || suspend_test(TEST_CPUS))
> > >  		goto Enable_cpus;
> > > =20
> > > -	arch_suspend_disable_irqs();
> > > -	BUG_ON(!irqs_disabled());
> > > -
> > > -	error =3D syscore_suspend();
> > > -	if (!error) {
> > > -		*wakeup =3D pm_wakeup_pending();
> > > -		if (!(suspend_test(TEST_CORE) || *wakeup)) {
> > > -			trace_suspend_resume(TPS("machine_suspend"),
> > > -				state, true);
> > > -			error =3D suspend_ops->enter(state);
> > > -			trace_suspend_resume(TPS("machine_suspend"),
> > > -				state, false);
> > > -			events_check_enabled =3D false;
> > > +	while (!pm_abort_suspend) {
> >=20
> > That won't work in general, because pm_abort_suspend may not be set=
 on some
> > platforms on wakeup.  It is only set if a wakeup interrupt triggers=
 which
> > may not be the case on ACPI systems if the BIOS has woken up the sy=
stem.
> >=20
> > But that could be addressed by making those platforms simply set pm=
_wakeup_pending
> > in their BIOS exit path.
> >=20
> > > +		arch_suspend_disable_irqs();
> > > +		BUG_ON(!irqs_disabled());
> > > +
> > > +		error =3D syscore_suspend();
> >=20
> > Also it shouldn't be necessary to do syscore_suspend()/syscore_resu=
me() in
> > every iteration of the loop.
> >=20
> > > +		if (!error) {
> > > +			*wakeup =3D pm_wakeup_pending();
> >=20
> > Plus pm_wakeup_pending() returns true if pm_abort_suspend is set
> >=20
> > > +			if (!(suspend_test(TEST_CORE) || *wakeup)) {
> > > +				trace_suspend_resume(TPS("machine_suspend"),
> > > +					state, true);
> >=20
> > Did you try to add the loop here instead of above?  Like:
> >=20
> > 			for (;;) {
> > 				*wakeup =3D pm_wakeup_pending();
> > 				if (*wakeup)
> > 					break;
>=20
> I think, that doesn't work. I chose the start/end points of the loop
> to include the IRQ enable/disable calls. AFAICT, pm_abort_suspend is
> set in an ISR. Without enabling interrupts the abort condition of
> this loop never becomes true.

Any further ideas how to resolve this?

	S=C3=B6ren

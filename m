From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RESEND] PM / sleep: Fix racing timers
Date: Mon, 12 Jan 2015 16:14:53 +0000
Message-ID: <20150112161453.GA25281@red-moon>
References: <1411405623-7869-1-git-send-email-soren.brinkmann@xilinx.com>
 <1025ebd0a9984037bf15adf3ae4889d9@BN1BFFO11FD013.protection.gbl>
 <99d5bcca1d6541a49ff8a9f41f9b18af@BL2FFO11FD039.protection.gbl>
 <12360948.gSvRbI0dui@vostro.rjw.lan>
 <20150112154347.GA23297@red-moon>
 <2313f65696c04c48867a3e8ce65ceb0b@BL2FFO11FD015.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2313f65696c04c48867a3e8ce65ceb0b@BL2FFO11FD015.protection.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 12, 2015 at 03:55:05PM +0000, S=F6ren Brinkmann wrote:
> On Mon, 2015-01-12 at 03:43PM +0000, Lorenzo Pieralisi wrote:
> > Hi Rafael, Soren,
> >
> > On Sun, Jan 11, 2015 at 11:20:36PM +0000, Rafael J. Wysocki wrote:
> > > On Friday, January 09, 2015 01:50:59 PM S=F6ren Brinkmann wrote:
> > > > On Sat, 2014-11-08 at 03:56PM -0800, S=F6ren Brinkmann wrote:
> > > > > Hi Rafael,
> > > > >
> > > > > On Thu, 2014-11-06 at 01:33AM +0100, Rafael J. Wysocki wrote:
> > > > > > On Thursday, October 02, 2014 09:01:15 AM S=F6ren Brinkmann=
 wrote:
> > > > > > > Hi Rafael,
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Sorry for the huge delay.
> > > > > >
> > > > > > > On Tue, 2014-09-23 at 01:01AM +0200, Rafael J. Wysocki wr=
ote:
> > > > > > > > On Monday, September 22, 2014 10:07:03 AM Soren Brinkma=
nn wrote:
> > > > > > > > > On platforms that do not power off during suspend, su=
ccessfully entering
> > > > > > > > > suspend races with timers.
> > > > > > > > >
> > > > > > > > > The race happening in a couple of location is:
> > > > > > > > >
> > > > > > > > >   1. disable IRQs               (e.g. arch_suspend_di=
sable_irqs())
> > > > > > > > >      ...
> > > > > > > > >   2. syscore_suspend()
> > > > > > > > >       -> timekeeping_suspend()
> > > > > > > > >        -> clockevents_notify(SUSPEND)
> > > > > > > > >         -> tick_suspend()       (timers are turned of=
f here)
> > > > > > > > >      ...
> > > > > > > > >   3. wfi                        (wait for wake-IRQ he=
re)
> > > > > > > > >
> > > > > > > > > Between steps 1 and 2 the timers can still generate i=
nterrupts that are
> > > > > > > > > not handled and stay pending until step 3. That pendi=
ng IRQ causes an
> > > > > > > > > immediate - spurious - wake.
> > > > > > > > >
> > > > > > > > > The solution is to move the clockevents suspend/resum=
e notification
> > > > > > > > > out of the syscore_suspend step and explictly call th=
em at the appropriate
> > > > > > > > > time in the suspend/hibernation paths. I.e. timers ar=
e suspend _before_
> > > > > > > > > IRQs get disabled. And accordingly in the resume path=
=2E
> > > > > > > > >
> > > > > > > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilin=
x.com>
> > > > > > > > > ---
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > there was not a lot of discussion on the last submiss=
ion. Just one comment from
> > > > > > > > > Rafael (https://lkml.org/lkml/2014/8/26/780), which -=
 as I outlined in my
> > > > > > > > > response, does not apply, IMHO, since the platform do=
es not re-enable
> > > > > > > > > interrupts.
> > > > > > > >
> > > > > > > > Well, you just don't agree with it.
> > > > > > > >
> > > > > > > > The problem with your approach is that timer interrupts=
 aren't actually as
> > > > > > > > special as you think and any other IRQF_NO_SUSPEND inte=
rrupts would have caused
> > > > > > > > similar issues to appear under specific conditions.
> > > > > > > >
> > > > > > > > The solution I would suggest and that actually covers a=
ll IRQF_NO_SUSPEND
> > > > > > > > interrupts would be to use a wait_event() loop like the=
 one in freeze_enter()
> > > > > > > > (on top of the current linux-next or the pm-genirq bran=
ch of linux-pm.git),
> > > > > > > > but wait for pm_abort_suspend to become true, to implem=
ent system suspend.
> > > > > > >
> > > > > > > sorry, it took me a while since I needed to get some depe=
ndencies ported
> > > > > > > to the pm-genirq base. Once I had that, it reproduced my =
original issue.
> > > > > > > So far so good. I then looked into finding a solution fol=
lowing your
> > > > > > > guidance. I'm not sure I really found what you had in min=
d, but below is
> > > > > > > what I came up with, which seems to do it.
> > > > > > > Please let me know how far off I am.
> > > > > > >
> > > > > > >     Thanks,
> > > > > > >     S=F6ren
> > > > > > >
> > > > > > > -------8<------------------8<----------------8<----------=
------8<---------------
> > > > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/p=
ower/wakeup.c
> > > > > > > index c2744b30d5d9..a4f9914571f1 100644
> > > > > > > --- a/drivers/base/power/wakeup.c
> > > > > > > +++ b/drivers/base/power/wakeup.c
> > > > > > > @@ -25,7 +25,7 @@
> > > > > > >  bool events_check_enabled __read_mostly;
> > > > > > >
> > > > > > >  /* If set and the system is suspending, terminate the su=
spend. */
> > > > > > > -static bool pm_abort_suspend __read_mostly;
> > > > > > > +bool pm_abort_suspend __read_mostly;
> > > > > > >
> > > > > > >  /*
> > > > > > >   * Combined counters of registered wakeup events and wak=
eup events in progress.
> > > > > > > diff --git a/kernel/power/suspend.c b/kernel/power/suspen=
d.c
> > > > > > > index 6dadb25cb0d8..e6a6de8f76d0 100644
> > > > > > > --- a/kernel/power/suspend.c
> > > > > > > +++ b/kernel/power/suspend.c
> > > > > > > @@ -33,6 +33,7 @@
> > > > > > >
> > > > > > >  static const char *pm_labels[] =3D { "mem", "standby", "=
freeze", };
> > > > > > >  const char *pm_states[PM_SUSPEND_MAX];
> > > > > > > +extern bool pm_abort_suspend;
> > > > > > >
> > > > > > >  static const struct platform_suspend_ops *suspend_ops;
> > > > > > >  static const struct platform_freeze_ops *freeze_ops;
> > > > > > > @@ -294,25 +295,27 @@ static int suspend_enter(suspend_st=
ate_t state, bool *wakeup)
> > > > > > >     if (error || suspend_test(TEST_CPUS))
> > > > > > >             goto Enable_cpus;
> > > > > > >
> > > > > > > -   arch_suspend_disable_irqs();
> > > > > > > -   BUG_ON(!irqs_disabled());
> > > > > > > -
> > > > > > > -   error =3D syscore_suspend();
> > > > > > > -   if (!error) {
> > > > > > > -           *wakeup =3D pm_wakeup_pending();
> > > > > > > -           if (!(suspend_test(TEST_CORE) || *wakeup)) {
> > > > > > > -                   trace_suspend_resume(TPS("machine_sus=
pend"),
> > > > > > > -                           state, true);
> > > > > > > -                   error =3D suspend_ops->enter(state);
> > > > > > > -                   trace_suspend_resume(TPS("machine_sus=
pend"),
> > > > > > > -                           state, false);
> > > > > > > -                   events_check_enabled =3D false;
> > > > > > > +   while (!pm_abort_suspend) {
> > > > > >
> > > > > > That won't work in general, because pm_abort_suspend may no=
t be set on some
> > > > > > platforms on wakeup.  It is only set if a wakeup interrupt =
triggers which
> > > > > > may not be the case on ACPI systems if the BIOS has woken u=
p the system.
> > > > > >
> > > > > > But that could be addressed by making those platforms simpl=
y set pm_wakeup_pending
> > > > > > in their BIOS exit path.
> > > > > >
> > > > > > > +           arch_suspend_disable_irqs();
> > > > > > > +           BUG_ON(!irqs_disabled());
> > > > > > > +
> > > > > > > +           error =3D syscore_suspend();
> > > > > >
> > > > > > Also it shouldn't be necessary to do syscore_suspend()/sysc=
ore_resume() in
> > > > > > every iteration of the loop.
> > > > > >
> > > > > > > +           if (!error) {
> > > > > > > +                   *wakeup =3D pm_wakeup_pending();
> > > > > >
> > > > > > Plus pm_wakeup_pending() returns true if pm_abort_suspend i=
s set
> > > > > >
> > > > > > > +                   if (!(suspend_test(TEST_CORE) || *wak=
eup)) {
> > > > > > > +                           trace_suspend_resume(TPS("mac=
hine_suspend"),
> > > > > > > +                                   state, true);
> > > > > >
> > > > > > Did you try to add the loop here instead of above?  Like:
> > > > > >
> > > > > >                       for (;;) {
> > > > > >                               *wakeup =3D pm_wakeup_pending=
();
> > > > > >                               if (*wakeup)
> > > > > >                                       break;
> > > > >
> > > > > I think, that doesn't work. I chose the start/end points of t=
he loop
> > > > > to include the IRQ enable/disable calls. AFAICT, pm_abort_sus=
pend is
> > > > > set in an ISR. Without enabling interrupts the abort conditio=
n of
> > > > > this loop never becomes true.
> > > >
> > > > Any further ideas how to resolve this?
> > >
> > > Sorry about the delay, lost track of this.
> > >
> > > You're right, the IRQ disabling/enabling needs to happen in the l=
oop.
> > >
> > > So the direction of the patch looks OK, but it needs to ensure th=
at pm_wakeup_pending
> > > is set properly by all platforms.  Also it should be sufficient t=
o check
> > > pm_wakeup_pending() to detect wakeup.
> > >
> > > Have you tested the patch?
> >
> > Before considering this patch a solution, can I ask you to rewind
> > the discussion a bit since I have a question.
> >
> > I thought that "suspending" the tick through syscore meant shutting=
 down
> > the respective clock_event_device, and that's how it is implemented=
 in the
> > kernel.
> >
> > Now, do we expect a shutdown clock_event_device to still signal pen=
ding
> > IRQs ? I do not think that should be the case, at least that's not =
what
> > happens for eg arm arch timers - ie disabling them implicitly gates
> > the signal connected to the IRQ line.
> >
> > So the question is more related to the zynq platform and how their =
clock
> > event device (which is ?) is shutdown, and what's the correct behav=
iour we
> > are expecting.
>=20
> As outlined in the commit message, there is a race condition in the c=
ore
> code. Looking at the timers is just fighting the symptoms.

I gathered there is a race condition between 1 and 2 in your code path.
What I am asking you is why are we getting a pending IRQ at step 3 when=
 the
clock event device is supposed to be shutdown. My question is:

Should a clock event device in shutdown mode (ie disabled) still signal
IRQs to the interrupt controller (and consequently to the core) ?

It is for me to understand if that's the behaviour we are expecting.

> > FWIW, the problem here is not related to the simple wfi state on zy=
nq,
> > even some other ARM platforms with power management capabilities wo=
uld wake
> > up from the state entered by executing wfi (ie possibly through res=
et) if
> > there is a pending timer IRQ, the question is more "should the IRQ =
be
> > allowed to be there" instead IMHO.
> >
> > I still think that Stephen's query related to what timer is causing
> > the wake-up is worth investigating.
>=20
> As I reported earlier, I see these spurious wakes with the cadence_tt=
c
> as well as the ARM twd timers.

I thought that a shutdown clock event device explicitly disables IRQ
assertion, that's why I am inquiring, I do not understand how this
can happen - how can you have a pending timer IRQ at step 3 above.

Thanks,
Lorenzo

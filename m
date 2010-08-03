From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 08:41:12 -0700
Message-ID: <20100803154112.GE2407__41327.0298777663$1280861595$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<AANLkTi=hoGF7egpyB9sLKJoXv5aiGrxfa9_5iH-96SA=@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=hoGF7egpyB9sLKJoXv5aiGrxfa9_5iH-96SA=@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 02, 2010 at 09:18:27PM -0700, Arve Hj=F8nnev=E5g wrote:
> On Sat, Jul 31, 2010 at 10:58 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> ...

First, thank you very much for your review and feedback!

> > REQUIREMENTS
> >
> > o =A0 =A0 =A0 Reduce the system's power consumption in order to (1) ext=
end
> > =A0 =A0 =A0 =A0battery life and (2) preserve state until AC power can b=
e obtained.
> >
> > o =A0 =A0 =A0 It is necessary to be able to use power-naive application=
s.
> > =A0 =A0 =A0 =A0Many of these applications were designed for use in PC p=
latforms
> > =A0 =A0 =A0 =A0where power consumption has historically not been of gre=
at
> > =A0 =A0 =A0 =A0concern, due to either (1) the availability of AC power =
or (2)
> > =A0 =A0 =A0 =A0relatively undemanding laptop battery-lifetime expectati=
ons. =A0The
> > =A0 =A0 =A0 =A0system must be capable of running these power-naive appl=
ications
> > =A0 =A0 =A0 =A0without requiring that these applications be modified, a=
nd must
> > =A0 =A0 =A0 =A0be capable of reasonable power efficiency even when powe=
r-naive
> > =A0 =A0 =A0 =A0applications are available.
> >
> > o =A0 =A0 =A0 If the display is powered off, there is no need to run any
> > =A0 =A0 =A0 =A0application whose only effect is to update the display.
> >
> > =A0 =A0 =A0 =A0Although one could simply block such an application when=
 it next
> > =A0 =A0 =A0 =A0tries to access the display, it appears that it is highly
> > =A0 =A0 =A0 =A0desirable that the application also be prevented from
> > =A0 =A0 =A0 =A0consuming power computing anything that will not be disp=
layed.
> > =A0 =A0 =A0 =A0Furthermore, whatever mechanism is used must operate on
> > =A0 =A0 =A0 =A0power-naive applications that do not use blocking system=
 calls.
> >
> > o =A0 =A0 =A0 In order to avoid overrunning hardware and/or kernel buff=
ers,
> > =A0 =A0 =A0 =A0input events must be delivered to the corresponding appl=
ication
> > =A0 =A0 =A0 =A0in a timely fashion. =A0The application might or might n=
ot be
> > =A0 =A0 =A0 =A0required to actually process the events in a timely fash=
ion,
> > =A0 =A0 =A0 =A0depending on the specific application.
> >
> > =A0 =A0 =A0 =A0In particular, if user input that would prevent the syst=
em
> > =A0 =A0 =A0 =A0from entering a low-power state is received while the sy=
stem is
> > =A0 =A0 =A0 =A0transitioning into a low-power state, the system must tr=
ansition
> > =A0 =A0 =A0 =A0back out of the low-power state so that it can hand the =
user
> > =A0 =A0 =A0 =A0input off to the corresponding application.
> >
> > o =A0 =A0 =A0 If a power-aware application receives user input, then th=
at
> > =A0 =A0 =A0 =A0application must be given the opportunity to process that
> > =A0 =A0 =A0 =A0input.
> >
> > o =A0 =A0 =A0 A power-aware application must be able to efficiently com=
municate
> > =A0 =A0 =A0 =A0its needs to the system, so that such communication can =
be
> > =A0 =A0 =A0 =A0performed on hot code paths. =A0Communication via open()=
 and
> > =A0 =A0 =A0 =A0close() is considered too slow, but communication via io=
ctl()
> > =A0 =A0 =A0 =A0is acceptable.
> =

> The problem with using open and close to prevent an allow suspend is
> not that it is too slow but that it interferes with collecting stats.
> The wakelock code has a sysfs interface that allow you to use a
> open/write/close sequence to block or unblock suspend. There is no
> limit to the amount of kernel memory that a process can consume with
> this interface, so the suspend blocker patchset uses a /dev interface
> with ioctls to block or unblock suspend and it destroys the kernel
> object when the file descriptor is closed.

Ah, I missed this point.  What I am doing to adjust is to strike the
above requirement, and to add verbiage to the "statistics" requirement
about using ioctl() to implement suspend-blocker operations, so that the
statistics can be tracked based on the device being open throughout the
application's lifetime.

> > o =A0 =A0 =A0 Power-naive applications must be prohibited from controll=
ing
> > =A0 =A0 =A0 =A0the system power state. =A0One acceptable approach is th=
rough
> > =A0 =A0 =A0 =A0use of group permissions on a special power-control devi=
ce.
> >
> > o =A0 =A0 =A0 Statistics of the power-control actions taken by power-aw=
are
> > =A0 =A0 =A0 =A0applications must be provided, and must be keyed off of =
program
> > =A0 =A0 =A0 =A0name.
> =

> We don't key the stats off the program name, but having useful
> statistics is critical too us. The current code in linux-next does not
> appear to allow this (I'm referring to pm_stay_awake here, etc not
> pm-qos.)

OK, maybe I was confused earlier.  So you do not track statistics via
the device being open throughout the application's lifetime?

I am not familiar with pm_stay_awake(), but will take a look at it.

> > o =A0 =A0 =A0 Power-aware applications can make use of power-naive infr=
astructure.
> > =A0 =A0 =A0 =A0This means that a power-aware application must have some=
 way,
> > =A0 =A0 =A0 =A0whether explicit or implicit, to ensure that any power-n=
aive
> > =A0 =A0 =A0 =A0infrastructure is permitted to run when a power-aware ap=
plication
> > =A0 =A0 =A0 =A0needs it to run.
> >
> > o =A0 =A0 =A0 When a power-aware application is preventing the system f=
rom
> > =A0 =A0 =A0 =A0shutting down, and is also waiting on a power-naive appl=
ication,
> > =A0 =A0 =A0 =A0the power-aware application must set a timeout to handle
> > =A0 =A0 =A0 =A0the possibility that the power-naive application might h=
alt
> > =A0 =A0 =A0 =A0or otherwise fail. =A0(Such timeouts are also used to li=
mit the
> > =A0 =A0 =A0 =A0number of kernel modifications required.)
> =

> wake-lock/suspend-blocker timeouts have nothing to do with the timeout
> used by applications when waiting for a response from a less trusted
> application.

OK, I moved this to a new "SUGGESTED USAGE" section and removed the
last (parenthesized) sentence.

> > o =A0 =A0 =A0 If no power-aware or power-optimized application are indi=
cating
> > =A0 =A0 =A0 =A0a need for the system to remain operating, the system is=
 permitted
> > =A0 =A0 =A0 =A0(even encouraged!) to suspend all execution, even if pow=
er-naive
> > =A0 =A0 =A0 =A0applications are runnable. =A0(This requirement did appe=
ar to be
> > =A0 =A0 =A0 =A0somewhat controversial.)
> =

> I would say it should suspend even if power aware applications are
> runnable. Most applications do not exclusively perform critical work.

The point being that a power-aware application does not block suspend
-unless- it holds a suspend blocker, correct?

Or am I missing some other subtlety?

> > o =A0 =A0 =A0 Transition to low-power state must be efficient. =A0In pa=
rticular,
> > =A0 =A0 =A0 =A0methods based on repeated attempts to suspend are consid=
ered to
> > =A0 =A0 =A0 =A0be too inefficient to be useful.
> =

> It must be power-efficient. Repeated attempts to suspend will kill the
> idle battery life.

Good point!  I changed "Transition to low-power state must be efficient"
to instead read "Transition to low-power state must be power-efficient."

> > o =A0 =A0 =A0 Individual peripherals and CPUs must still use standard
> > =A0 =A0 =A0 =A0power-conservation measures, for example, transitioning =
CPUs into
> > =A0 =A0 =A0 =A0low-power states on idle and powering down peripheral de=
vices
> > =A0 =A0 =A0 =A0and hardware accelerators that have not been recently us=
ed.
> >
> > o =A0 =A0 =A0 The API that controls the system power state must be
> > =A0 =A0 =A0 =A0accessible both from Android's Java replacement, from
> > =A0 =A0 =A0 =A0userland C code, and from kernel C code (both process
> > =A0 =A0 =A0 =A0level and irq code, but not NMI handlers).
> >
> > o =A0 =A0 =A0 Any initialization of the API that controls the system po=
wer
> > =A0 =A0 =A0 =A0state must be unconditional, so as to be free from failu=
re.
> > =A0 =A0 =A0 =A0(I don't currently understand how this relates, probably=
 due to
> > =A0 =A0 =A0 =A0my current insufficient understanding of the proposed pa=
tch set.)
> =

> Unconditional initialization makes it easier to add suspend blockers
> to existing kernel code since you don't have to add new failure exit
> paths. It is not a strong requirement.

Ah, that makes more sense!  I moved this to a new "NICE-TO-HAVES"
section.  I also changed the last parenthesized sentence to read
"Such unconditional initialization reduces the intrusiveness of the
the Android patchset."  Does that work?

> > o =A0 =A0 =A0 The API that controls the system power state must operate
> > =A0 =A0 =A0 =A0correctly on SMP systems of modest size. =A0(My guess is=
 that
> > =A0 =A0 =A0 =A0"modest" means up to four CPUs, maybe up to eight CPUs.)
> >
> > o =A0 =A0 =A0 Any QoS-based solution must take display and user-input
> > =A0 =A0 =A0 =A0state into account. =A0In other words, the QoS must be
> > =A0 =A0 =A0 =A0expressed as a function of the display and the user-input
> > =A0 =A0 =A0 =A0states.
> >
> > o =A0 =A0 =A0 Transitioning to extremely low power states requires savi=
ng
> > =A0 =A0 =A0 =A0and restoring DRAM and/or cache SRAM state, which in its=
elf
> > =A0 =A0 =A0 =A0consumes significant energy. =A0The power savings must t=
herefore
> > =A0 =A0 =A0 =A0be balanced against the energy consumed in the state
> > =A0 =A0 =A0 =A0transitions.
> >
> > o =A0 =A0 =A0 The current Android userspace API must be supported in or=
der
> > =A0 =A0 =A0 =A0to support existing device software.

Thank you again for looking this over and for your comments!!!

							Thanx, Paul

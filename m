From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 21:18:27 -0700
Message-ID: <AANLkTi=hoGF7egpyB9sLKJoXv5aiGrxfa9_5iH-96SA=__41930.9386438274$1280809157$gmane$org@mail.gmail.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100731175841.GA9367@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 31, 2010 at 10:58 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
...
> REQUIREMENTS
>
> o =A0 =A0 =A0 Reduce the system's power consumption in order to (1) extend
> =A0 =A0 =A0 =A0battery life and (2) preserve state until AC power can be =
obtained.
>
> o =A0 =A0 =A0 It is necessary to be able to use power-naive applications.
> =A0 =A0 =A0 =A0Many of these applications were designed for use in PC pla=
tforms
> =A0 =A0 =A0 =A0where power consumption has historically not been of great
> =A0 =A0 =A0 =A0concern, due to either (1) the availability of AC power or=
 (2)
> =A0 =A0 =A0 =A0relatively undemanding laptop battery-lifetime expectation=
s. =A0The
> =A0 =A0 =A0 =A0system must be capable of running these power-naive applic=
ations
> =A0 =A0 =A0 =A0without requiring that these applications be modified, and=
 must
> =A0 =A0 =A0 =A0be capable of reasonable power efficiency even when power-=
naive
> =A0 =A0 =A0 =A0applications are available.
>
> o =A0 =A0 =A0 If the display is powered off, there is no need to run any
> =A0 =A0 =A0 =A0application whose only effect is to update the display.
>
> =A0 =A0 =A0 =A0Although one could simply block such an application when i=
t next
> =A0 =A0 =A0 =A0tries to access the display, it appears that it is highly
> =A0 =A0 =A0 =A0desirable that the application also be prevented from
> =A0 =A0 =A0 =A0consuming power computing anything that will not be displa=
yed.
> =A0 =A0 =A0 =A0Furthermore, whatever mechanism is used must operate on
> =A0 =A0 =A0 =A0power-naive applications that do not use blocking system c=
alls.
>
> o =A0 =A0 =A0 In order to avoid overrunning hardware and/or kernel buffer=
s,
> =A0 =A0 =A0 =A0input events must be delivered to the corresponding applic=
ation
> =A0 =A0 =A0 =A0in a timely fashion. =A0The application might or might not=
 be
> =A0 =A0 =A0 =A0required to actually process the events in a timely fashio=
n,
> =A0 =A0 =A0 =A0depending on the specific application.
>
> =A0 =A0 =A0 =A0In particular, if user input that would prevent the system
> =A0 =A0 =A0 =A0from entering a low-power state is received while the syst=
em is
> =A0 =A0 =A0 =A0transitioning into a low-power state, the system must tran=
sition
> =A0 =A0 =A0 =A0back out of the low-power state so that it can hand the us=
er
> =A0 =A0 =A0 =A0input off to the corresponding application.
>
> o =A0 =A0 =A0 If a power-aware application receives user input, then that
> =A0 =A0 =A0 =A0application must be given the opportunity to process that
> =A0 =A0 =A0 =A0input.
>
> o =A0 =A0 =A0 A power-aware application must be able to efficiently commu=
nicate
> =A0 =A0 =A0 =A0its needs to the system, so that such communication can be
> =A0 =A0 =A0 =A0performed on hot code paths. =A0Communication via open() a=
nd
> =A0 =A0 =A0 =A0close() is considered too slow, but communication via ioct=
l()
> =A0 =A0 =A0 =A0is acceptable.
>

The problem with using open and close to prevent an allow suspend is
not that it is too slow but that it interferes with collecting stats.
The wakelock code has a sysfs interface that allow you to use a
open/write/close sequence to block or unblock suspend. There is no
limit to the amount of kernel memory that a process can consume with
this interface, so the suspend blocker patchset uses a /dev interface
with ioctls to block or unblock suspend and it destroys the kernel
object when the file descriptor is closed.

> o =A0 =A0 =A0 Power-naive applications must be prohibited from controlling
> =A0 =A0 =A0 =A0the system power state. =A0One acceptable approach is thro=
ugh
> =A0 =A0 =A0 =A0use of group permissions on a special power-control device.
>
> o =A0 =A0 =A0 Statistics of the power-control actions taken by power-aware
> =A0 =A0 =A0 =A0applications must be provided, and must be keyed off of pr=
ogram
> =A0 =A0 =A0 =A0name.
>

We don't key the stats off the program name, but having useful
statistics is critical too us. The current code in linux-next does not
appear to allow this (I'm referring to pm_stay_awake here, etc not
pm-qos.)

> o =A0 =A0 =A0 Power-aware applications can make use of power-naive infras=
tructure.
> =A0 =A0 =A0 =A0This means that a power-aware application must have some w=
ay,
> =A0 =A0 =A0 =A0whether explicit or implicit, to ensure that any power-nai=
ve
> =A0 =A0 =A0 =A0infrastructure is permitted to run when a power-aware appl=
ication
> =A0 =A0 =A0 =A0needs it to run.
>
> o =A0 =A0 =A0 When a power-aware application is preventing the system from
> =A0 =A0 =A0 =A0shutting down, and is also waiting on a power-naive applic=
ation,
> =A0 =A0 =A0 =A0the power-aware application must set a timeout to handle
> =A0 =A0 =A0 =A0the possibility that the power-naive application might halt
> =A0 =A0 =A0 =A0or otherwise fail. =A0(Such timeouts are also used to limi=
t the
> =A0 =A0 =A0 =A0number of kernel modifications required.)

wake-lock/suspend-blocker timeouts have nothing to do with the timeout
used by applications when waiting for a response from a less trusted
application.

>
> o =A0 =A0 =A0 If no power-aware or power-optimized application are indica=
ting
> =A0 =A0 =A0 =A0a need for the system to remain operating, the system is p=
ermitted
> =A0 =A0 =A0 =A0(even encouraged!) to suspend all execution, even if power=
-naive
> =A0 =A0 =A0 =A0applications are runnable. =A0(This requirement did appear=
 to be
> =A0 =A0 =A0 =A0somewhat controversial.)

I would say it should suspend even if power aware applications are
runnable. Most applications do not exclusively perform critical work.

>
> o =A0 =A0 =A0 Transition to low-power state must be efficient. =A0In part=
icular,
> =A0 =A0 =A0 =A0methods based on repeated attempts to suspend are consider=
ed to
> =A0 =A0 =A0 =A0be too inefficient to be useful.
>

It must be power-efficient. Repeated attempts to suspend will kill the
idle battery life.

> o =A0 =A0 =A0 Individual peripherals and CPUs must still use standard
> =A0 =A0 =A0 =A0power-conservation measures, for example, transitioning CP=
Us into
> =A0 =A0 =A0 =A0low-power states on idle and powering down peripheral devi=
ces
> =A0 =A0 =A0 =A0and hardware accelerators that have not been recently used.
>
> o =A0 =A0 =A0 The API that controls the system power state must be
> =A0 =A0 =A0 =A0accessible both from Android's Java replacement, from
> =A0 =A0 =A0 =A0userland C code, and from kernel C code (both process
> =A0 =A0 =A0 =A0level and irq code, but not NMI handlers).
>
> o =A0 =A0 =A0 Any initialization of the API that controls the system power
> =A0 =A0 =A0 =A0state must be unconditional, so as to be free from failure.
> =A0 =A0 =A0 =A0(I don't currently understand how this relates, probably d=
ue to
> =A0 =A0 =A0 =A0my current insufficient understanding of the proposed patc=
h set.)
>

Unconditional initialization makes it easier to add suspend blockers
to existing kernel code since you don't have to add new failure exit
paths. It is not a strong requirement.

> o =A0 =A0 =A0 The API that controls the system power state must operate
> =A0 =A0 =A0 =A0correctly on SMP systems of modest size. =A0(My guess is t=
hat
> =A0 =A0 =A0 =A0"modest" means up to four CPUs, maybe up to eight CPUs.)
>
> o =A0 =A0 =A0 Any QoS-based solution must take display and user-input
> =A0 =A0 =A0 =A0state into account. =A0In other words, the QoS must be
> =A0 =A0 =A0 =A0expressed as a function of the display and the user-input
> =A0 =A0 =A0 =A0states.
>
> o =A0 =A0 =A0 Transitioning to extremely low power states requires saving
> =A0 =A0 =A0 =A0and restoring DRAM and/or cache SRAM state, which in itself
> =A0 =A0 =A0 =A0consumes significant energy. =A0The power savings must the=
refore
> =A0 =A0 =A0 =A0be balanced against the energy consumed in the state
> =A0 =A0 =A0 =A0transitions.
>
> o =A0 =A0 =A0 The current Android userspace API must be supported in order
> =A0 =A0 =A0 =A0to support existing device software.
>
>



-- =

Arve Hj=F8nnev=E5g

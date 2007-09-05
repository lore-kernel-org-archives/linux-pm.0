From: Len Brown <lenb@kernel.org>
Subject: Ottawa Linux Power Management Summit, June 25-26,
	2007 - Minutes
Date: Wed, 5 Sep 2007 04:26:04 -0400
Message-ID: <200709050426.04793.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

A Linux Power Management "mini-summit" was held in Ottawa
on June 25 and 26, 2007, immediately preceeding the Ottawa Linux Symposiu=
m.

An effort was made to follow the best-known-method
for a Linux mini-summit, thought to be the most recent
storage-summit. =A0The invitation to the meeting was open --
sent to linux-pm@lists.linux-foundation.org in early May.
The focus of the meeting was on technical discussion. =A0Thus,
only presentations which supported discussion were encouraged,
and the size of the forum was capped at 20. =A0The agenda was set
by consensus of the attendees.

Thank you to the Intel Open Source Technology Center
for sponsoring the meeting.

Day 1 attendees:

Len Brown, Intel OTC, Linux Kernel ACPI Maintainer
Mark Gross, Intel OTC, embedded Linux team
Paul Mundt, Renesas, Linux Kernel Super-H Maintainer
Kevin Hilman, MontaVista, MV DPM Maintainer
Igor Stoppa, Nokia, OSSO Power Management
Sakari Poussa, Nokia, OSSO Power Management
Dave Jones, Red Hat, Fedora Maintainer, Linux Kernel Cpufreq Maintainer
Klaus Pedersen, Nokia, OSSO Power Management
Ken Rozendal, IBM, Linux on Power
Vivek Kashyap, IBM LTC
Adam Belay, Novell/MIT, cpuidle developer
Eugeny S. Mints, NGS Power Management
Scott E. Preece, Motorola
Marcelo Tosatti, Red Hat, One Laptop Per Child

Day 2 additional attendees:

Tariq Shureih, Intel OTC, MID power policy manager
Rishi Bhattacharya, Texas Instruments
Iliasbiris, Instituto de Tecnologia

notes:

Mark Gross showed off a Classmate PC. =A0The unit he had was a 900MHz
Celeron (model 13) Find out more at http://classmatepc.com

Mark led a discussion about constraints/quality of service.
An application specifies a QOS/SLA to some middle-ware, which
translates that into operation constraints. =A0We discussed the
vocabulary for constraints. =A0More on this below.

Igor Stoppa presented findings from the Nokia Tablet team.
The OMAP1 used in the n770 had idle/big-sleep/deep-sleep.
The OMAP2 is used in the n800, is built on 90nm technology.
The OMAP3 is expected to be built on high leakage 65nm technology,
and thus require software to take advantage of power-gating off states.
Indeed, the OMAP3 has over 30 power gates.

http://linux.omap.com has OMAP Linux resources.
http://source.mvista.com hosts OMAP patches before they get
to kernel.org

Re: Performance States

Igor asserted that once a voltage is selected, it is it always
the best policy to run at the maximum frequency supported by
that voltage.

However, the OMAP2 throws Linux a curve ball when increasing
the ARM core to its maximum speed, it will _reduce_ the speed of
the DSP. =A0Eg. 400MHz and 133MHz respectively. =A0cpufreq doesn't
have a concept of this kind of dependency.

cpufreq_set_policy() doesn't match Nokia's needs as it is a 1-way
notification, and there is no way to register constraints.

Igor reported a scaling frequency bug where the current polling
interval and minimum residency formulas in ondemand don't work
on Nokia's hardware.

He also described "spread to deadline" in contrast to "race to
idle". =A0In spread-to-deadline, the work is run at the minimum rate
such that it will complete in time for a known future deadline.
The deadline might be an expected external periodic communication
event, for example.

Re: pause/resume
Total pause/resume on the n800 is 20-80ms.
PLL re-lock takes about 0.1ms and the voltage ramp is about 5ms
by comparison. =A0The big time consumer is drivers. =A0In particular
syncing with screen updates.

Paul Mundt contrasted the clock framework with cpufreq, saying
that one could build a rate table of all P-state transitions.
Though this would need to prototyped to see if it is viable.

Marcelo Tosatti shoed off an OLPC XO-1 (http://laptop.org/)
It includes a 433MHz AMD Geode LX.
(this replaced the previous cache-less Geode GX)
The XO-1 has 1G NAND flash 1200x900 LED screen which uses 0.2W min,
1.0 Watts max. =A0These screen power numbers are truly impressive.

OLPC wants to aggressively auto-suspend to an suspend-to-RAM
like state, except the screen stays on (and wireless stays on).
The system wakes upon user-input. =A0The requirement for this state
is < 100ms resume latency. =A0Jim Gettys asserts that the iPAQ could
resume in 10ms by comparison. =A0Marcelo reports that the XO-1
can resume in 160ms today if USB is disabled. =A0However, if USB
is enabled, it resumes in 250ms. =A0He thinks that resume needs to
be multi-threaded, and it needs to be smarter so that it doesn't
blindly resume every device in the system.

XO-1 has a Display Controller (DCON), which will refresh display
even when processor completely powered off.

Regarding wake, enable_irqwake(irq) is ugly b/c it is IRQ specific.
Needs to e enable-wakeup(device) -- a generic API.

Audio amplifier must delay ~100ms power-up to avoid a pop.

OLPC is not using suspend-to-disk, yet.

Discussed the STD vs STR path. =A0The expectation is that STR can be
faster if it doesn't follow the same path as STD. =A0Per the list,
Rafael is working on this.

OLPC is using OHM - Open HW Manager -- a generic system manager,
of which power management is just one part.

olpc-pm.c olpc_pm_enter() is kicked off by OHM on detecting idle.

Dave Jones led a discussion on cpufreq.

Re: Accounting vs cpufreq.
Enterprise capacity planning applications get confused by cpufreq.
cpufreq lowers the MHz due to low demand, the management application
sees no idle time left -- indicating that the system has reached capacity
and need to be upgraded.

Dave commented that the cpufreq conservative governor should
be deleted and whatever hooks are needed should simply be added
to ondemand.

MHz vs scheduler: today cpufreq simply tracks idle time and the
schedule is completely unaware that cpufreq changes the frequency.
Application hints may be appropriate for apps to tell the scheduler
about their MHz needs. =A0Also, the scheduler may be better off
scheduling cycles instead of scheduling time.

Discussion on APERF/MPERF MSRs on Intel processors: The APERF/MPERF
ratio conveys the "actual" to "maximum" MHz ratio since the
MSRs were last reset. =A0Note that with Intel Dynamic Acceleration
(IDA), this ratio can be greater than 1 -- so maybe "maximum"
needs to be re-worded as "marketing":-)

governors It isn't clear whey there needs to be a governor
per core. =A0It seems to be unused today, except on incorrectly
administered systems.

user-space: cpuspeed, powernowd not used so much these days.

The fabled DPM/PowerOP/cpufreq integration isn't happening fast.
Per previous discussion, an abstract notion Operating Points
makes the most sense, and perhaps dealing in units of absolute
MHz is not the right model. =A0Though users are now accustomed to
thinking they know the absolute MHz....

Dave Jones was open to the idea of transforming cpufreq into a
generic clock scaling implementation.

Dave mentioned that Fedora Core 7 32-bit is now shipping with
CONFIG_NOHZ=3Dy and CONFIG_HZ=3D1000.

Kevin Hillman led a discussion on DPM (Dynamic Power Management,
http://dynamicpower.sourceforge.net/)

DPM has been shipping since Linux-2.4 and is a part of many
successful products, so it will continue to be supported.

One key aspect of DPM is that it allows customers to put their
platform-specific proprietary control code in user-space.

DPM has hooks in the scheduler where applications explicitly
request an operating state.

MontaVista is hoping to migrate to mainline, now that mainline is
becoming more capable. =A0In particular, they need solid tickless,
cpufreq, and wake-up events.

Paul Mundt described the cutting edge in the Super-H space.
The SH4A-SMP has 4 cores and it expected to be used in high-end
consumer electronics, navigation etc. =A0It has per-core voltage
regulation, and CPU offline saves real power. =A0Often ITRON is
run on a core.

Mark Gross led a discussion on Device QOS Parameters, to see
if common language might be suitable, say in a sysfs interface.
We brain-stormed on how throughput, rate, power gain, latency,
acoustic and timeout applied to various classes of devices;
such as storage, wired and wireless networks, and the display.

Suspend/Resume:
Earlier on the list, Linus stated that he might
prefer multiple entry points that do simpler functions rather
than the over-loaded .suspend/.resume I/F we have today.

Adam Belay described a 2-pass device suspend to ram loop, where .stop is
first called for each device before the first .suspend is called:

.start .stop
=A0=A0=A0=A0=A0=A0=A0=A0dont touch hardware able to return failure
.suspend(target state)
=A0=A0=A0=A0=A0=A0=A0=A0saves HW state enable wake feature invoke D-state
=A0=A0=A0=A0=A0=A0=A0=A0(power-off)
[take STD snapshot here] .resume

There is also a .reset especially for kexec that can be called
after .stop. =A0It removes the IRQ and int src.

The .stop loop allows a device to veto the suspend and for the
system to quickly back out of the operation.

sysfs brainstorm...

=A0/sys/class/power/state
=A0/sys/device/.../power/state
=A0=A0=A0=A0=A0=A0=A0=A0A class could provide default hooks for devices.

Tariq Shureih presented an effort to implement a Linux Power Policy
Manager (PPM). =A0This effort is primarily intended to fill the needs
of Linux mobile-internet-devices (http://moblin.org/)
However, nothing limits its use to that market segment.

The big question was how this compares to the OHM effort.
http://ohm.freedesktop.org

The initial answer is that PPM will be BSD licensed,
and OHM will be LGPL.

Nokia in the lab hopes to replace their proprietary solution
with OHM.

We discussed powertop.
Go to http://linuxpowertop.org/ for the latest.

Virtualization. =A0Observed that power management comes "for free"
in the hosted model and there is heavy lifting to make it work
in the hypervisor model.

In particular, Xen, the popular hypervisor-hybrid model currently
lacks C-state and P-state support.

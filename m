From: "Geoffrey Hausheer" <w4ry27fpn4@snkmail.com>
Subject: Increased idle power on Atom netbook with 2.6.35 and
	intel_idle
Date: Tue, 10 Aug 2010 19:27:55 -0700
Message-ID: <5563-1281493676-58384@sneakemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4436035254414525051=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============4436035254414525051==
Content-Type: multipart/alternative; boundary=0016364d1d1d52f849048d82ffe5

--0016364d1d1d52f849048d82ffe5
Content-Type: text/plain; charset=ISO-8859-1

I'm running UNR 10.04 on an Asus AspireOne 532h (Atom N450 1.66GHz w/ SMT).
 Due to some intermittent problems with suspend, I'd upgraded to a 2.6.34
and then recently to a 2.6.35 kernel.
I noticed that I could get my idle power (as reported by ACPI) down to 5.5W
idle with a stock 2.6.34 kernel (the test I ran below didn't get it quite
that low), but I have only been able to get down to 6.8W or so using 2.6.35
(despite having increased the time spent in sleep states).  I found that
with stock 2.6.35 the kernel would only go into C2, so I switched to using
intel_idle, which added C4 state, but power didn't change much.
I also tried disabling smt and that added about 1.5W to idle power (despite
even further reducing the wakeups-per-second below 10)
Is there any way to further identify where the power is being spent, or to
figure out what is casuing the increased power consumption?  On my netbook,
the difference between 5.5W and 6.8 is ~1.5 hours (of course my average
usage will be somewhat higher, but even when playing a movie, the difference
is 7.1W vs 7.9W (still almost an hour of difference)

Here are some powertop numbers (computer completely idle, same power
management settings applied, no wireless, lowest brightness:

2.6.32 (with ubuntu patches applied) SMT enabled:

Cn                Avg residency
C0 (cpu running)        ( 0.3%)
polling           0.0ms ( 0.0%)
C1 halt           0.0ms ( 0.0%)
C2                1.2ms ( 0.0%)
C3               30.0ms (99.7%)
P-states (frequencies)
  1.67 Ghz     0.0%
  1333 Mhz     0.0%
  1000 Mhz   100.0%
Disk accesses:
Wakeups-from-idle per second : 33.5     interval: 20.0s
Power usage (ACPI estimate): 6.4W (7.8 hours)
Top causes for wakeups:
  25.5% ( 13.2)   [acpi] <interrupt>
  18.1% (  9.3)   [kernel scheduler] Load balancing tick
  17.9% (  9.2)   [kernel core] hrtimer_start (tick_sched_timer)
  10.1% (  5.2)   events/0
   8.0% (  4.2)   Xorg
   4.5% (  2.4)   [Rescheduling interrupts] <kernel IPI>
   4.1% (  2.1)   [extra timer interrupt]

2.6.34 stock kernel (smt enabled)
Cn                Avg residency
C0 (cpu running)        ( 0.3%)
polling           0.0ms ( 0.0%)
C1 halt           0.0ms ( 0.0%)
C2                0.4ms ( 0.0%)
C3               37.0ms (99.7%)
P-states (frequencies)
  1.67 Ghz     0.0%
  1333 Mhz     0.0%
  1000 Mhz   100.0%
Wakeups-from-idle per second : 27.9     interval: 20.0s
Power usage (ACPI estimate): 6.1W (8.4 hours)
Top causes for wakeups:
  27.0% ( 11.1)   [kernel scheduler] Load balancing tick
  15.7% (  6.5)   [Rescheduling interrupts] <kernel IPI>
  12.7% (  5.2)   [kernel core] hrtimer_start (tick_sched_timer)
  10.7% (  4.4)   [acpi] <interrupt>
  10.0% (  4.1)   Xorg
   7.2% (  3.0)   [extra timer interrupt]

2.6.35 stock kernel (intel_idle):
C0 (cpu running)        ( 0.1%)
polling           0.0ms ( 0.0%)
C1 mwait          0.0ms ( 0.0%)
C2 mwait          0.4ms ( 0.0%)
C4 mwait         55.1ms (99.8%)
P-states (frequencies)
  1.67 Ghz     0.3%
  1333 Mhz     0.0%
  1000 Mhz    99.7%
Disk accesses:
Wakeups-from-idle per second : 19.1     interval: 20.0s
Power usage (ACPI estimate): 7.0W (8.1 hours)
Top causes for wakeups:
  24.4% (  4.8)   [kernel scheduler] Load balancing tick
  22.6% (  4.5)   [kernel core] hrtimer_start (tick_sched_timer)
  20.4% (  4.0)   Xorg
   9.8% (  1.9)   gnome-terminal

Here is the same 2.6.35 kernel after disabling cpu1 (via echo 0 >
/sys/devices/system/cpu/cpu1/online ):
Cn                Avg residency
C0 (cpu running)        ( 0.3%)
polling           0.0ms ( 0.0%)
C1 mwait          0.0ms ( 0.0%)
C2 mwait          3.2ms ( 0.0%)
C4 mwait        103.8ms (99.7%)
P-states (frequencies)
  1.67 Ghz     1.7%
  1333 Mhz     0.0%
  1000 Mhz    98.3%
Disk accesses:
Wakeups-from-idle per second :  9.8     interval: 20.0s
Power usage (ACPI estimate): 8.3W (6.8 hours)
Top causes for wakeups:
  28.4% (  4.5)   [kernel core] hrtimer_start (tick_sched_timer)
  25.9% (  4.0)   Xorg

turning of the virtual CPU1 drastically reduced the number of "load
balancing ticks" and gave me substantial time in C4 (103ms vs 55ms) but
power jumped substantially.

Anyhow, I have no idea how to proceed.  I have managed to get the cpu into
lower sleep-states for longer periods of time, but my power reported by ACPI
has been negatively affected.

Thanks,
..Geoff

--0016364d1d1d52f849048d82ffe5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m running UNR 10.04 on an Asus AspireOne 532h (Atom N450 1.66GHz w/ S=
MT). =A0Due to some intermittent problems with suspend, I&#39;d upgraded to=
 a 2.6.34 and then recently to a 2.6.35 kernel.<div>I noticed that I could =
get my idle power (as reported by ACPI) down to 5.5W idle with a stock 2.6.=
34 kernel (the test I ran below didn&#39;t get it quite that low), but I ha=
ve only been able to get down to 6.8W or so using 2.6.35 (despite having in=
creased the time spent in sleep states). =A0I found that with stock 2.6.35 =
the kernel would only go into C2, so I switched to using intel_idle, which =
added C4 state, but power didn&#39;t change much.</div>

<div>I also tried disabling smt and that added about 1.5W to idle power (de=
spite even further reducing the wakeups-per-second below 10)</div><div>Is t=
here any way to further identify where the power is being spent, or to figu=
re out what is casuing the increased power consumption? =A0On my netbook, t=
he difference between 5.5W and 6.8 is ~1.5 hours (of course my average usag=
e will be somewhat higher, but even when playing a movie, the difference is=
 7.1W vs 7.9W (still almost an hour of difference)</div>

<div><br></div><div>Here are some powertop numbers (computer completely idl=
e, same power management settings applied, no wireless, lowest brightness:<=
/div><div><br></div><div>2.6.32 (with ubuntu patches applied) SMT enabled:<=
/div>

<div><br></div><div><div>Cn =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Avg residency</d=
iv><div>C0 (cpu running) =A0 =A0 =A0 =A0( 0.3%)</div><div>polling =A0 =A0 =
=A0 =A0 =A0 0.0ms ( 0.0%)</div><div>C1 halt =A0 =A0 =A0 =A0 =A0 0.0ms ( 0.0=
%)</div><div>C2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01.2ms ( 0.0%)</div>

<div>C3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30.0ms (99.7%)</div><div>P-states (freq=
uencies)</div><div>=A0=A01.67 Ghz =A0 =A0 0.0%</div><div>=A0=A01333 Mhz =A0=
 =A0 0.0%</div><div>=A0=A01000 Mhz =A0 100.0%</div><div>Disk accesses:</div=
><div>Wakeups-from-idle per second : 33.5 =A0 =A0 interval: 20.0s</div>

<div>Power usage (ACPI estimate): 6.4W (7.8 hours)</div><div>Top causes for=
 wakeups:</div><div>=A0=A025.5% ( 13.2) =A0 [acpi] &lt;interrupt&gt;</div><=
div>=A0=A018.1% ( =A09.3) =A0 [kernel scheduler] Load balancing tick</div><=
div>=A0=A017.9% ( =A09.2) =A0 [kernel core] hrtimer_start (tick_sched_timer=
)</div>

<div>=A0=A010.1% ( =A05.2) =A0 events/0</div><div>=A0=A0 8.0% ( =A04.2) =A0=
 Xorg</div><div>=A0=A0 4.5% ( =A02.4) =A0 [Rescheduling interrupts] &lt;ker=
nel IPI&gt;</div><div>=A0=A0 4.1% ( =A02.1) =A0 [extra timer interrupt]</di=
v><div><br></div></div><div>

2.6.34 stock kernel (smt enabled)</div><div><div>Cn =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Avg residency</div><div>C0 (cpu running) =A0 =A0 =A0 =A0( 0.3%)</di=
v><div>polling =A0 =A0 =A0 =A0 =A0 0.0ms ( 0.0%)</div><div>C1 halt =A0 =A0 =
=A0 =A0 =A0 0.0ms ( 0.0%)</div><div>C2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00.4ms=
 ( 0.0%)</div>

<div>C3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 37.0ms (99.7%)</div><div>P-states (freq=
uencies)</div><div>=A0=A01.67 Ghz =A0 =A0 0.0%</div><div>=A0=A01333 Mhz =A0=
 =A0 0.0%</div><div>=A0=A01000 Mhz =A0 100.0%</div><div>Wakeups-from-idle p=
er second : 27.9 =A0 =A0 interval: 20.0s</div>

<div>Power usage (ACPI estimate): 6.1W (8.4 hours)</div><div>Top causes for=
 wakeups:</div><div>=A0=A027.0% ( 11.1) =A0 [kernel scheduler] Load balanci=
ng tick</div><div>=A0=A015.7% ( =A06.5) =A0 [Rescheduling interrupts] &lt;k=
ernel IPI&gt;</div>

<div>=A0=A012.7% ( =A05.2) =A0 [kernel core] hrtimer_start (tick_sched_time=
r)</div><div>=A0=A010.7% ( =A04.4) =A0 [acpi] &lt;interrupt&gt;</div><div>=
=A0=A010.0% ( =A04.1) =A0 Xorg</div><div>=A0=A0 7.2% ( =A03.0) =A0 [extra t=
imer interrupt]</div></div><div>

<br></div><div>2.6.35 stock kernel (intel_idle):</div><div><div>C0 (cpu run=
ning) =A0 =A0 =A0 =A0( 0.1%)</div><div>polling =A0 =A0 =A0 =A0 =A0 0.0ms ( =
0.0%)</div><div>C1 mwait =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)</div><div>C2 mwai=
t =A0 =A0 =A0 =A0 =A00.4ms ( 0.0%)</div>
<div>C4 mwait =A0 =A0 =A0 =A0 55.1ms (99.8%)</div><div>P-states (frequencie=
s)</div><div>=A0=A01.67 Ghz =A0 =A0 0.3%</div><div>=A0=A01333 Mhz =A0 =A0 0=
..0%</div><div>=A0=A01000 Mhz =A0 =A099.7%</div><div>Disk accesses:</div><di=
v>Wakeups-from-idle per second : 19.1 =A0 =A0 interval: 20.0s</div>
<div>Power usage (ACPI estimate): 7.0W (8.1 hours)</div><div>Top causes for=
 wakeups:</div><div>=A0=A024.4% ( =A04.8) =A0 [kernel scheduler] Load balan=
cing tick</div><div>=A0=A022.6% ( =A04.5) =A0 [kernel core] hrtimer_start (=
tick_sched_timer)</div>
<div>=A0=A020.4% ( =A04.0) =A0 Xorg</div><div>=A0=A0 9.8% ( =A01.9) =A0 gno=
me-terminal</div></div><div><br></div><div>Here is the same 2.6.35 kernel a=
fter disabling cpu1 (via=A0echo 0 &gt; /sys/devices/system/cpu/cpu1/online =
):</div><div><div>
Cn =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Avg residency</div><div>C0 (cpu running) =
=A0 =A0 =A0 =A0( 0.3%)</div><div>polling =A0 =A0 =A0 =A0 =A0 0.0ms ( 0.0%)<=
/div><div>C1 mwait =A0 =A0 =A0 =A0 =A00.0ms ( 0.0%)</div><div>C2 mwait =A0 =
=A0 =A0 =A0 =A03.2ms ( 0.0%)</div><div>C4 mwait =A0 =A0 =A0 =A0103.8ms (99.=
7%)</div>
<div>P-states (frequencies)</div><div>=A0=A01.67 Ghz =A0 =A0 1.7%</div><div=
>=A0=A01333 Mhz =A0 =A0 0.0%</div><div>=A0=A01000 Mhz =A0 =A098.3%</div><di=
v>Disk accesses:</div><div>Wakeups-from-idle per second : =A09.8 =A0 =A0 in=
terval: 20.0s</div><div>Power usage (ACPI estimate): 8.3W (6.8 hours)</div>
<div>Top causes for wakeups:</div><div>=A0=A028.4% ( =A04.5) =A0 [kernel co=
re] hrtimer_start (tick_sched_timer)</div><div>=A0=A025.9% ( =A04.0) =A0 Xo=
rg</div></div><div><br></div><div>turning of the virtual CPU1 drastically r=
educed the number of &quot;load balancing ticks&quot; and gave me substanti=
al time in C4 (103ms vs 55ms) but power jumped substantially.</div>
<div><br></div><div>Anyhow, I have no idea how to proceed. =A0I have manage=
d to get the cpu into lower sleep-states for longer periods of time, but my=
 power reported by ACPI has been negatively affected.</div><div><br></div>
<div>Thanks,</div><div>.Geoff</div>

--0016364d1d1d52f849048d82ffe5--

--===============4436035254414525051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4436035254414525051==--

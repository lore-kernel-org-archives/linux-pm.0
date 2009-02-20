From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/4] timers: framework for migration between
	CPU
Date: Fri, 20 Feb 2009 18:25:16 +0530
Message-ID: <20090220125516.GB10232__21758.8478154086$1235134793$gmane$org@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: a.p.zijlstra@chello.nl, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, tglx@linutronix.de, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,


In an SMP system, tasks are scheduled on different CPUs by the
scheduler, interrupts are managed by irqbalancer daemon, but timers
are still stuck to the CPUs that they have been initialised.  Timers
queued by tasks gets re-queued on the CPU where the task gets to run
next, but timers from IRQ context like the ones in device drivers are
still stuck on the CPU they were initialised.  This framework will
help move all 'movable timers' from one CPU to any other CPU of choice
using a sysfs interface.

Why is that a problem?

In a completely idle system with large number of cores, and CPU
packages, we can have a few timers stuck in each core that will force the
corresponding CPU package to wakeup for a short duration to service
the timer interrupt.

Timers eventually have to run on some CPU in the system, but ability to
move timers from one CPU to another can help consolidate timers to
less number of CPUs.  Consolidating timers to one or two cores
in a large system helps in reducing the CPU wakeups from idle since
there is better chance of servicing multiple timer during one wakeup
interval.  This technique could also help 'range timer' framework where
timers expiring pretty close in time can be combined together and save
wakeups for the CPU.

Migrating timer from select set of CPUs and consolidating them helps
improve the deep sleep state residency and reduce the number of cpu
wakeups from idle. This framework and patch series is an enabler for
a higher level framework to evacuate CPU packages and consolidate work
in an almost idle system.

Currently, timers are migrated during the cpu offline operation.
Since cpu-hotplug is too heavy for this purpose,this patch
demonstrates a lightweight timer migration framework.

My earlier post to lkml in this area can be found at
http://lkml.org/lkml/2008/10/16/138

Evacuating timers from certain CPUs can help other general situations
like HPC or highly optimised system to run specific set of application.
Essentially this framework will help us control the spread of
OS/device driver timers in a multi-cpu system.

The following patches are included:
PATCH 1/4 - framework to identify pinned timers.
PATCH 2/4 - sysfs hook to enable timer migration.
PATCH 3/4 - identifying the existing pinned hrtimers.
PATCH 4/4 - logic to enable timer migration.

The patches are based against kernel version 2.6.29-rc5

The following experiment was carried out to demonstrate the
functionality of the patch.
The machine used is a 2 socket, quad core machine.

I have used a driver which continuously queues timers on a CPU.
With the timers queued I measure the sleep state residency
for a period of 10s.
Next, I enable timer migration and move all timers away from
that CPU to a specific cpu and measure the sleep state residency period.
The comparison in sleep state residency values is posted below.

Also the difference in Local Timer Interrupt rate(LOC) rate
from /proc/interrupts is posted below.

The interface for timer migration is located at
/sys/devices/system/cpu/cpuX/timer_migration

By echoing a target cpu number we can enable migration for that cpu.

	echo 4 > /sys/devices/system/cpu/cpu1/timer_migration

this would move all regular and hrtimers from cpu1 to cpu4 when the
new timers are queued or old timers are requeued.
Timers already in the queue will not be migrated and would
fire one last time on cpu1.

	echo 4 > /sys/devices/system/cpu/cpu4/timer_migration

this would stop timer migration.

---------------------------------------------------------------------------
Timers are being queued on CPU2 using my test driver.


	Package 0			Package 1	    Local Timer
								Count
---------------------------- ----------------------------	C0 167
|Core| Sleep time          | |Core|       Sleep time    |	C1 310
|0   |	 8.58219	   | |4   |        10.05127     |	C2 2542
|1   |	10.04206           | |5   |        10.05216     |	C3 268
|2   |   9.77348           | |6   |        10.05386     |	C4 54
|3   |  10.03901           | |7   |        10.05540     |	C5 27
---------------------------- ----------------------------	C6 28
								C7 20
Since timers are being queued on CPU2, Core sleep state residency of CPU2
is relatively low compared to others, barring CPU0. The LOC count
shows a high interrupt rate on CPU2, as expected.

---------------------------------------------------------------------------
Timers Migrated to CPU7

	Package 0			Package 1	    Local Timer
								Count
----------------------------  ----------------------------	C0 129
|Core|       Sleep time    |  |Core|       Sleep time    |	C1 206
|0   |        8.94301      |  |4   |        10.04280     |	C2 203
|1   |       10.05429      |  |5   |        10.04471     |	C3 292
|2   |       10.04477      |  |6   |        10.04320     |	C4 33
|3   |       10.04570      |  |7   |         9.77789     |	C5 25
----------------------------  ----------------------------	C6 42
								C7 2033
Here, timers are being migrated from CPU2 to CPU7. The sleep state
residency value of CPU2 has gone up and that of CPU7 has come down.
Also, LOC count shows that timers have been moved.

---------------------------------------------------------------------------
Timers migrated to CPU1

	Package 0			Package 1	    Local Timer
							        Count
----------------------------  ----------------------------      C0 210
|Core|       Sleep time    |  |Core|       Sleep time    |      C1 2049
|0   |        9.50814      |  |4   |        10.05087     |      C2 331
|1   |        9.81115      |  |5   |        10.05121     |      C3 307
|2   |       10.04120      |  |6   |        10.05312     |      C4 324
|3   |       10.04015      |  |7   |        10.05327     |      C5 22
----------------------------  ----------------------------      C6 27
                                                                C7 27

---------------------------------------------------------------------------

Please let me know your comments.

--arun

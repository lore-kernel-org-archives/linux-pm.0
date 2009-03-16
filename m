From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v3 PATCH 0/4] timers: Framework for migration of timers
Date: Mon, 16 Mar 2009 16:40:45 +0530
Message-ID: <20090316111045.GA4686__45948.3595252552$1237202111$gmane$org@linux.vnet.ibm.com>
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
help move all 'movable timers' using a sysctl interface.

Iteration v2 of this patch can be found at
http://lkml.org/lkml/2009/3/4/130


Changelog: v2->v3

-removed the sysfs interface for enabling timer migration
and instead created a /proc/sys sysctl, which can turn off
timer_migration when CONFIG_SCHED_DEBUG =y.(as suggested by Ingo)

-modified the interface to identify pinned regular timers,
made it cleaner and simpler to understand.(as suggested by Oleg)


The following patches are included:
PATCH 1/4 - framework to identify pinned timers.
PATCH 2/4 - identifying the existing pinned hrtimers.
PATCH 3/4 - /proc/sys sysctl hook to enable timer migration.
PATCH 4/4 - logic to enable timer migration.

The patchset is based on the latest tip/master.

Timer migration is enabled by default as suggested by Ingo.
It can be turned off when CONFIG_SCHED_DEBUG=y by

echo 0 > /proc/sys/kernel/timer_migration


Benchmark tested: Kernbench

Kernbench results on an 2-socket, quad-core machine
Averaged over 3 iterations.
sched_mc_power_savings = 2

------------------------------------------------------------------------
|No. of	    Time taken(s)      Time Taken(s)	      Time Taken(s)    |
|Threads  Patch Not Applied (Migration Disabled)   (Migration Enabled) |
|								       |
|  32	     64.02		64.05			63.73	       |
|  16	     63.31		63.71			62.91	       |
|   8	     67.20		67.38			67.32	       |
|   4	    115.67	       114.72		       114.54	       |
|   2	    222.21	       220.63		       218.13	       |
------------------------------------------------------------------------


TODO:

-Yet to implement Oleg's comment on my previous post PATCH 4/4.
Current code seems to be working fine. Working on it to implement
what has been suggested.


Please let me know your comments.

--arun

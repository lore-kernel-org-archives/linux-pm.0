From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/4] timers: Timer migration
Date: Thu, 16 Oct 2008 17:12:39 +0530
Message-ID: <20081016114239.GA7641__28150.5144936547$1224157690$gmane$org@linux.vnet.ibm.com>
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

(This is merely for discussion purposes and not for inclusion).

This is a re-work of the earlier patch which i had sent.
Link to the earlier patch - http://lkml.org/lkml/2008/9/16/40
I have made the following changes from my previous patch:

1) Created a new framework for identifying cpu-pinned hrtimers,so
that such hrtimers are ignored during migration of timers.

2)A better sysfs interface which allows you to echo a target cpu
number to the per-cpu sysfs entry and all timers are migrated
to that cpu, instead of choosing cpu0 by default.

This patch set is based on the kernel version 2.6.27.


Here's a brief introduction as to why we need timer migration.

An idle cpu on which device drivers have initialized timers, or any
timer that is (re)queued from a softirq context has to be
frequently woken up to service the timers. So, consolidation of timers
onto a fewer number of cpus is important. Migration of timers from
idle cpus onto lesser idle cpus is necessary. Currently, timers are
migrated during the cpu offline operation. However cpu-hotplug for the
sake of idle system power management is too heavy. So, this patch
implements a lightweight timer migration framework.

Also, in machines with large number of CPUs, when utilization is not
high enough, but is not 0% either, we would want to consolidate all
the system activity to as fewer number of packages as possible.

a) Interrupts are usually re-routed using the power-aware irqbalance
daemon.

b) For tasks, we have hooks in the scheduler which can consolidate tasks to
a fewer number of CPUs.

c) The remaining part of the system activity is the timers, which can be
queued from a task or a softirq context.

c-1)If they're queued from the task context, then they migrate whenever the
task is migrated.

c-2) However, if they're requeued from a softirq context, then it's not
possible to currently migrate them unless the CPU is offlined.

Hence, the need for a minimalistic framework which allows to
migrate the last remaining system activity from the last few
idle-but-serving-timers CPUs of an otherwise idle package, to a package
which is already having some amount of system activity on them.

Also, this kind of a framework will be helpful for a certain class of
applications like the High Performance (HPC) applications, where we
would want to restrict the system housekeeping activities to as fewer
number of CPUs as possible, in order to minimize the jitter caused by
these housekeeping activities.


Lastly, the algorithm which decides to which cpu the timer should be
migrated to should be conservative in the sense that, it should
migrate only if the target cpu is sufficiently busy so that it is not
woken up from an idle state. In that case where even target cpu is
idle, the penalty of wake up would be same on either of the cpus.

Tests carried out:

a) I have tested this patch by stressing the system using a script
which continuously hotplug-add and removes the cpus.

b) Also ran kernbench. The kernbench results with and without my patches
on were fairly similar.

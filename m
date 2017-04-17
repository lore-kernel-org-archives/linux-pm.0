From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 00/10] timer: Move from a push remote at enqueue to a pull at
 expiry model
Date: Mon, 17 Apr 2017 20:32:41 +0200
Message-ID: <20170417183241.244217993@linutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbdDQSxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 14:53:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

Placing timers at enqueue time on a target CPU based on dubious heuristics
does not make any sense:

 1) Most timer wheel timers are canceled or rearmed before they expire.

 2) The heuristics to predict which CPU will be busy when the timer expires
    are wrong by definition.

So we waste precious cycles to place timers at enqueue time.

The proper solution to this problem is to always queue the timers on the
local CPU and allow the non pinned timers to be pulled onto a busy CPU at
expiry time.

To achieve this the timer storage has been split into local pinned and
global timers. Local pinned timers are always expired on the CPU on which
they have been queued. Global timers can be expired on any CPU.

As long as a CPU is busy it expires both local and global timers. When a
CPU goes idle it arms for the first expiring local timer. If the first
expiring pinned (local) timer is before the first expiring movable timer,
then no action is required because the CPU will wake up before the first
movable timer expires. If the first expiring movable timer is before the
first expiring pinned (local) timer, then this timer is queued into a idle
timerqueue and eventually expired by some other active CPU.

To avoid global locking the timerqueues are implemented as a hierarchy. The
lowest level of the hierarchy holds the CPUs. The CPUs are associated to
groups of 8, which are seperated per node. If more than one CPU group
exist, then a second level in the hierarchy collects the groups. Depending
on the size of the system more than 2 levels are required. Each group has a
"migrator" which checks the timerqueue during the tick for remote expirable
timers.

If the last CPU in a group goes idle it reports the first expiring event in
the group up to the next group(s) in the hierarchy. If the last CPU goes
idle it arms its timer for the first system wide expiring timer to ensure
that no timer event is missed.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers

Thanks,

	tglx
---
 b/.../timer_migration.h         |  173 ++++++++++
 b/kernel/time/timer_migration.c |  659 ++++++++++++++++++++++++++++++++++++++++
 b/kernel/time/timer_migration.h |   89 +++++
 include/linux/cpuhotplug.h      |    1 
 kernel/time/Makefile            |    1 
 kernel/time/tick-internal.h     |    4 
 kernel/time/tick-sched.c        |  121 ++++++-
 kernel/time/tick-sched.h        |    3 
 kernel/time/timer.c             |  240 +++++++++-----
 lib/timerqueue.c                |    8 
 10 files changed, 1203 insertions(+), 96 deletions(-)

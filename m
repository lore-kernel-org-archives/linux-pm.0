From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch V2 00/10] timer: Move from a push remote at enqueue to a
 pull at expiry model
Date: Fri, 21 Apr 2017 12:28:53 -0700
Message-ID: <20170421192853.GD3956@linux.vnet.ibm.com>
References: <20170418111102.490432548@linutronix.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37101 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1425143AbdDUT27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 15:28:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3LJNfLP079604
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2017 15:28:58 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29ycje062u-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2017 15:28:58 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 21 Apr 2017 15:28:57 -0400
Content-Disposition: inline
In-Reply-To: <20170418111102.490432548@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:02PM +0200, Thomas Gleixner wrote:
> Placing timers at enqueue time on a target CPU based on dubious heuristics
> does not make any sense:
> 
>  1) Most timer wheel timers are canceled or rearmed before they expire.
> 
>  2) The heuristics to predict which CPU will be busy when the timer expires
>     are wrong by definition.
> 
> So we waste precious cycles to place timers at enqueue time.
> 
> The proper solution to this problem is to always queue the timers on the
> local CPU and allow the non pinned timers to be pulled onto a busy CPU at
> expiry time.
> 
> To achieve this the timer storage has been split into local pinned and
> global timers. Local pinned timers are always expired on the CPU on which
> they have been queued. Global timers can be expired on any CPU.
> 
> As long as a CPU is busy it expires both local and global timers. When a
> CPU goes idle it arms for the first expiring local timer. If the first
> expiring pinned (local) timer is before the first expiring movable timer,
> then no action is required because the CPU will wake up before the first
> movable timer expires. If the first expiring movable timer is before the
> first expiring pinned (local) timer, then this timer is queued into a idle
> timerqueue and eventually expired by some other active CPU.
> 
> To avoid global locking the timerqueues are implemented as a hierarchy. The
> lowest level of the hierarchy holds the CPUs. The CPUs are associated to
> groups of 8, which are seperated per node. If more than one CPU group
> exist, then a second level in the hierarchy collects the groups. Depending
> on the size of the system more than 2 levels are required. Each group has a
> "migrator" which checks the timerqueue during the tick for remote expirable
> timers.
> 
> If the last CPU in a group goes idle it reports the first expiring event in
> the group up to the next group(s) in the hierarchy. If the last CPU goes
> idle it arms its timer for the first system wide expiring timer to ensure
> that no timer event is missed.

OK, after several attempts this week, I formally state that I officially
suck at reviewing, though I must confess that I am quite partial to use
of hierarchies to avoid scalability bottlenecks.  I therefore applied
these patches and ran rcutorture on them.  Two of 19 scenarios resulted
in failures, namely TREE04 and TREE07.  I have posted their .config and
console.log files here:

http://www2.rdrop.com/users/paulmck/submission/TREE04.2017.04.21a.config
http://www2.rdrop.com/users/paulmck/submission/TREE04.2017.04.21a.console.log
http://www2.rdrop.com/users/paulmck/submission/TREE07.2017.04.21a.config
http://www2.rdrop.com/users/paulmck/submission/TREE07.2017.04.21a.console.log

The first splat from TREE04 is:

[    3.513964] WARNING: CPU: 1 PID: 755 at /home/paulmck/public_git/linux-rcu/kernel/time/timer_migration.c:387 tmigr_set_cpu_active+0xd7/0xf0
[    3.517320] Modules linked in:
[    3.518173] CPU: 1 PID: 755 Comm: rcu_torture_rea Not tainted 4.11.0-rc2+ #1
[    3.520134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[    3.522692] Call Trace:
[    3.523354]  <IRQ>
[    3.523953]  dump_stack+0x4d/0x65
[    3.524846]  __warn+0xc6/0xe0
[    3.525680]  warn_slowpath_null+0x18/0x20
[    3.526787]  tmigr_set_cpu_active+0xd7/0xf0
[    3.527866]  tmigr_cpu_activate+0x36/0x40
[    3.528872]  tick_nohz_stop_sched_tick+0x248/0x330
[    3.530103]  tick_nohz_irq_exit+0x109/0x140
[    3.531214]  irq_exit+0x74/0xf0
[    3.532068]  smp_apic_timer_interrupt+0x38/0x50
[    3.533239]  apic_timer_interrupt+0x90/0xa0
[    3.534363] RIP: 0010:__local_bh_enable_ip+0x3e/0x80
[    3.535722] RSP: 0000:ffffc900014ffe60 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff10
[    3.537640] RAX: 0000000000000000 RBX: ffffffff8319c0e0 RCX: 000000000000000a
[    3.539461] RDX: ffffffff81e46b40 RSI: 0000000000000200 RDI: ffffffff810b0630
[    3.541307] RBP: ffffc900014ffe60 R08: 0000000000000001 R09: 0000000000000101
[    3.543497] R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffffffee5
[    3.545556] R13: 0000000000000000 R14: 00000000dfa1ef74 R15: fffffffffffffee6
[    3.547186]  </IRQ>
[    3.547689]  ? rcu_bh_torture_deferred_free+0x20/0x20
[    3.548837]  rcu_bh_torture_read_unlock+0x15/0x20
[    3.549861]  rcu_torture_reader+0xe4/0x2b0
[    3.550801]  ? rcu_torture_reader+0x2b0/0x2b0
[    3.551768]  kthread+0xfc/0x130
[    3.552465]  ? rcu_torture_fqs+0xe0/0xe0
[    3.553387]  ? kthread_create_on_node+0x40/0x40
[    3.554460]  ret_from_fork+0x29/0x40

Line 387 is this line in tmigr_set_cpu_active():

	if (WARN_ON(group->active == group->num_childs)) {

The splat from TREE07 looks quite similar, although it has three splats
rather than only two.

							Thanx, Paul

> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers
> 
> Changes vs. V1:
>   - Add missing inline stubs
>   - Bail out when running on UP
>   - Don't compile migration code for SMP=n
>   - Reorder trace point storage
> 
> Thanks,
> 
> 	tglx
> ---
>  /timer_migration.h              |  173 ++++++++++
>  b/kernel/time/timer_migration.c |  666 ++++++++++++++++++++++++++++++++++++++++
>  b/kernel/time/timer_migration.h |   83 ++++
>  include/linux/cpuhotplug.h      |    1 
>  kernel/time/Makefile            |    3 
>  kernel/time/tick-internal.h     |    4 
>  kernel/time/tick-sched.c        |  121 ++++++-
>  kernel/time/tick-sched.h        |    3 
>  kernel/time/timer.c             |  239 +++++++++-----
>  lib/timerqueue.c                |    8 
>  10 files changed, 1205 insertions(+), 96 deletions(-)
> 
> 
> 
> 

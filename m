From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v4 RFC PATCH 0/4] timers: Framework for migration of
	timers
Date: Wed, 1 Apr 2009 17:01:28 +0530
Message-ID: <20090401113128.GA22478__10756.3253761784$1238585986$gmane$org@linux.vnet.ibm.com>
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

Iteration v3 of this patch can be found at
http://lkml.org/lkml/2009/3/16/162

Changelog: v3->v4

-An hrtimer is migrated *only* if its expiry occurs after the next timer
interrupt on the CPU to which it is being migrated to. This prevents any
possible latency, which might have arised otherwise due to migration.

So, a few helper functions have been added to check if migration would
result in latency or not.
Thanks to Thomas for pointing out this issue.

The following patches are included:
PATCH 1/4 - framework to identify pinned timers.
PATCH 2/4 - identifying the existing pinned hrtimers.
PATCH 3/4 - /proc/sys sysctl hook to enable timer migration.
PATCH 4/4 - logic to enable timer migration.

The patchset is based on the latest tip/master.

Timer migration is enabled by default as suggested by Ingo.
It can be turned off when CONFIG_SCHED_DEBUG=y by

echo 0 > /proc/sys/kernel/timer_migration



Please let me know your comments.

--arun

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 0/2] IRQ based next prediction
Date: Tue, 16 Feb 2016 16:41:24 +0100
Message-ID: <1455637286-14285-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

The current approach to select an idle state is based on the idle period
statistics computation.

Useless to say this approach satisfied everyone as a solution to find the
best trade-off between the performances and the energy saving via the menu
governor.

However, the kernel is evolving to act pro-actively regarding the energy
constraints with the scheduler and the different power management subsystems
are not collaborating with the scheduler as the conductor of the decisions,
they all act independently.

The cpuidle governors are based on idle period statistics, without knowledge
of what woke up the cpu. In these sources of wakes up, the IPI are of course
accounted (as well as the timers irq) which results in doing statistics on
the scheduler behavior too. It is no sense to let the scheduler to take a
decision based on a next prediction of its own decisions.

In order to integrate the cpuidle framework into the scheduler, we have to
radically change the approach by clearly identifying what is causing a wake
up and how it behaves.

This serie inverts the logic.

Instead of tracking the idle durations and do statistics on them, these
patches track the interrupt individually and try to predict the next interrupt.

By combining the interrupts' next event on a single CPU, we can predict the
next event for the CPU, hence predict how long we will be sleeping when
entering idle.

The IPI and timer interrupts are not taken into account.

The first patch computes the interval between each interrupt and fill a
circular buffer with the values.

The second patch computes the next event when entering idle.

When we the cpu enters idle, it asks for the expected sleep time. Then the
expected minimum sleep length for all interrupts is used and compared to
the timer sleep length, again the minimum is taken and gives the expected
sleep time.

The statistics are very trivial and could be improved later but this first
step shows we have a nice overall improvement in SMP. In UP the menu governor
is a bit better which may indicate the next prediction computation could be
improved but confirms removing the IPI from the equation increase the
accuracy.

Changelog:
	V3:
	  - Drop RFC prefix
	  - Convert hook approach to native irq code
	  - Use local_clock instead of ktime_get
	  - Store time in nanosec
	  - Remove the ktime dance with u64
	  - + Take into account different comments
        RFC V2:
           - Changed the register_ops approach for the irq subsystem
           - Fixed Nicolas's comments
	RFC V1:
	   - Initial post

Daniel Lezcano (2):
  irq: Track the interrupt timings
  sched: idle: IRQ based next prediction for idle period

 drivers/cpuidle/Kconfig   |   9 ++
 include/linux/interrupt.h |  17 +++
 include/linux/irqdesc.h   |   4 +
 kernel/irq/Kconfig        |   3 +
 kernel/irq/Makefile       |   1 +
 kernel/irq/handle.c       |   2 +
 kernel/irq/internals.h    |  42 +++++++
 kernel/irq/irqdesc.c      |  10 ++
 kernel/irq/manage.c       |   3 +
 kernel/irq/timings.c      | 110 ++++++++++++++++++
 kernel/sched/Makefile     |   1 +
 kernel/sched/idle-sched.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 482 insertions(+)
 create mode 100644 kernel/irq/timings.c
 create mode 100644 kernel/sched/idle-sched.c

-- 
1.9.1

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC V2 0/2] IRQ based next prediction
Date: Wed, 20 Jan 2016 17:00:31 +0100
Message-ID: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
References: <alpine.DEB.2.11.1601201634520.3575@nanos>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37223 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934429AbcATQBP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 11:01:15 -0500
Received: by mail-wm0-f46.google.com with SMTP id n5so36820315wmn.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 08:01:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1601201634520.3575@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

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

The first patch provides a callback to be registered in the irq subsystem
and to be called when an interrupt is handled with a timestamp.

The second patch uses the callback provided by the patch above to compute
the delta and store it in a circular buffer. It is per cpu, the callback
implements minimal operations as it is in an interrupt context.

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
	V2:
	   - Changed the register_ops approach for the irq subsystem
           - Fixed Nicolas's comments

Daniel Lezcano (2):
  irq: Add a framework to measure interrupt timings
  sched: idle: IRQ based next prediction for idle period

 drivers/cpuidle/Kconfig    |   9 +
 include/linux/interrupt.h  |  26 +++
 include/linux/irqhandler.h |   1 +
 kernel/irq/Kconfig         |   4 +
 kernel/irq/handle.c        |   1 +
 kernel/irq/internals.h     |  43 ++++
 kernel/irq/irqdesc.c       |   6 +
 kernel/irq/manage.c        |  10 +-
 kernel/sched/Makefile      |   1 +
 kernel/sched/idle-sched.c  | 529 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 629 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/idle-sched.c

-- 
1.9.1


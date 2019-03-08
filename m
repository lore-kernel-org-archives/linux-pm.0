From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/3] IRQ next prediction and mbed governor
Date: Fri,  8 Mar 2019 22:20:44 +0100
Message-ID: <20190308212047.28767-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The following patchset provides the missing bits to predict the next
event on the the current CPU by identifying three categories of wakeup
sources, the interrupts from the devices, the timers and the IPI
rescheduling.

Initially, the interrupt prediction was based on the statistical
normal law, discarding interrupt intervals out of the gaussian curve,
thus allowing to predict only interrupts coming in regular intervals.
Unfortunately this approach prevents to handle any kind of irregular
intervals, closing the door for more accuracy in the prediction.

With a derived array suffixes algorithm, it is possible to quickly
detect the repeating patterns in less than 1us per interrupt on x86.

The algorithm is described in the documentation. It is simple in
in apparence but it needs some attention to understand how it allows
to detect the pattern and return a guess estimate of the next event.

And finally, a new cpuidle governor is added to make use of these
predictions for the different wake up sources but targetting embedded
systems.

Daniel Lezcano (3):
  genirq/timings: Remove variance computation code
  genirq/timings: Add array suffix computation code
  cpuidle/drivers/mbed: Add new governor for embedded systems

 drivers/cpuidle/Kconfig            |  11 +-
 drivers/cpuidle/governors/Makefile |   1 +
 drivers/cpuidle/governors/mbed.c   | 143 +++++++++
 kernel/irq/timings.c               | 488 +++++++++++++++++++----------
 4 files changed, 485 insertions(+), 158 deletions(-)
 create mode 100644 drivers/cpuidle/governors/mbed.c

-- 
2.17.1

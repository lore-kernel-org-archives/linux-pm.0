From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH V3 0/3] time/cpuidle: Support in tick broadcast framework in
 absence of external clock device
Date: Thu, 06 Feb 2014 11:19:35 +0530
Message-ID: <20140206054158.4595.17827.stgit@preeti>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, paulus@samba.org, benh@kernel.crashing.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Cc: deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On some architectures, the local timers of CPUs stop in deep idle states.
They will need to depend on an external clock device to wake them up. However
certain implementations of archs do not have an external clock device.

This patchset provides support in the tick broadcast framework for such
architectures so as to enable the CPUs to get into deep idle.

Presently we are in need of this support on certain implementations of
PowerPC. This patchset has thus been tested on the same.

V1: https://lkml.org/lkml/2013/12/12/687.
V2: https://lkml.org/lkml/2014/1/24/28

Changes in V3:
1. Modified comments and code around programming of the broadcast hrtimer.

---

Preeti U Murthy (2):
      time: Change the return type of clockevents_notify() to integer
      time/cpuidle:Handle failed call to BROADCAST_ENTER on archs with CPUIDLE_FLAG_TIMER_STOP set

Thomas Gleixner (1):
      tick/cpuidle: Initialize hrtimer mode of broadcast


 drivers/cpuidle/cpuidle.c            |   38 +++++++-----
 include/linux/clockchips.h           |   15 ++++-
 kernel/time/Makefile                 |    2 -
 kernel/time/clockevents.c            |    8 ++-
 kernel/time/tick-broadcast-hrtimer.c |  105 ++++++++++++++++++++++++++++++++++
 kernel/time/tick-broadcast.c         |   51 ++++++++++++++++-
 kernel/time/tick-internal.h          |    6 +-
 7 files changed, 197 insertions(+), 28 deletions(-)
 create mode 100644 kernel/time/tick-broadcast-hrtimer.c

-- 

From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/3] Stop sched tick in idle injection task
Date: Wed,  9 Nov 2016 11:05:09 -0800
Message-ID: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1029 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbcKITHD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Nov 2016 14:07:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Idle injection drivers today use RT threads to run idle loop. There are
efficiency and accounting issues with the current intel_powerclamp.c
and acpi_pad.c. A while ago, I posted CFS based idle injection patch trying
to address them:
https://lkml.org/lkml/2015/11/13/576

Peter proposed another approach with the introduction of a PF_IDLE flag.
This patchset is based on his original posting:
https://lkml.org/lkml/2014/6/4/56

These patches apply on top of the kworker and cpu hotplug state machine
changes made to Intel powerclamp driver.
https://lkml.org/lkml/2016/10/17/362

Similar changes to ACPI PAD driver is developed along with other
enhancements. It will be posted after this patchset is accepted.

Jacob Pan (2):
  cpuidle: allow setting deepest idle
  thermal/powerclamp: use PF_IDLE in injection kthread

Peter Zijlstra (1):
  idle: add support for tasks that inject idle

 drivers/cpuidle/cpuidle.c          |  12 +++
 drivers/thermal/intel_powerclamp.c |  58 ++++++---------
 include/linux/cpu.h                |   2 +
 include/linux/cpuidle.h            |   4 +-
 include/linux/sched.h              |   3 +-
 kernel/fork.c                      |   3 +
 kernel/sched/core.c                |   1 +
 kernel/sched/idle.c                | 147 +++++++++++++++++++++----------------
 8 files changed, 130 insertions(+), 100 deletions(-)

-- 
1.9.1


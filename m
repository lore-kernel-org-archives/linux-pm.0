From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/3] Stop sched tick in idle injection task
Date: Mon, 14 Nov 2016 10:47:55 -0800
Message-ID: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62995 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbcKNStz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 13:49:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Changelog:
v2:
	- moved duration timer from powerclamp driver to play_idle()
	- unexport cpuidle_use_deepest_state
	- indentation fix

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
  thermal/powerclamp: stop sched tick in forced idle

Peter Zijlstra (1):
  idle: add support for tasks that inject idle

 drivers/cpuidle/cpuidle.c          |  11 +++
 drivers/thermal/intel_powerclamp.c |  35 +-------
 include/linux/cpu.h                |   2 +
 include/linux/cpuidle.h            |   4 +-
 include/linux/sched.h              |   3 +-
 kernel/fork.c                      |   3 +
 kernel/sched/core.c                |   1 +
 kernel/sched/idle.c                | 177 +++++++++++++++++++++++--------------
 8 files changed, 136 insertions(+), 100 deletions(-)

-- 
1.9.1


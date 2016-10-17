From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] thermal/intel_powerclamp: Conversion to kthread worker API and new CPU hotplug state
Date: Mon, 17 Oct 2016 14:32:49 +0200
Message-ID: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
List-Id: linux-pm@vger.kernel.org

The kthread worker API enhancements are in 4.9-rc1. Therefore
we could finally convert the intel_powerclamp kthreads to it.

The API hides a rather tricky code for the sleeping, freezing,
and exiting checks. It should help to avoid races and maintain
these operations.

Sebastian asked me to send also the conversion to the new
CPU hotplug state machine on top of the kthread conversion.

IMPORTANT: 

I have tested this on top of 4.9-rc1. But I needed to add
("sched/fair: Fix sched domains NULL deference in select_idle_sibling()")
from linux-tip, see
https://lkml.kernel.org/r/tip-9cfb38a7ba5a9c27c1af8093fb1af4b699c0a441@git.kernel.org
Otherwise, the CPU hotplug failed very often.


Petr Mladek (2):
  thermal/intel_powerclamp: Remove duplicated code that starts the
    kthread
  thermal/intel_powerclamp: Convert the kthread to kthread worker API

Sebastian Andrzej Siewior (1):
  thermal/intel_powerclamp: Convert to CPU hotplug state

 drivers/thermal/intel_powerclamp.c | 374 +++++++++++++++++++++----------------
 1 file changed, 209 insertions(+), 165 deletions(-)

-- 
1.8.5.6

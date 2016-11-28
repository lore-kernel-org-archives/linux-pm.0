From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/4] Misc enhancements to intel_powerclamp
Date: Mon, 28 Nov 2016 13:44:48 -0800
Message-ID: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755446AbcK1Vqm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 16:46:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>

This patchset is applicable on top of scheduler support of forced idle
tasks. (https://lkml.org/lkml/2016/11/28/683)

Jacob Pan (1):
  thermal/intel_powerclamp: stop sched tick in forced idle

Petr Mladek (2):
  thermal/intel_powerclamp: Remove duplicated code that starts the
    kthread
  thermal/intel_powerclamp: Convert the kthread to kthread worker API

Sebastian Andrzej Siewior (1):
  thermal/intel_powerclamp: Convert to CPU hotplug state

 drivers/thermal/intel_powerclamp.c | 359 +++++++++++++++++++------------------
 1 file changed, 184 insertions(+), 175 deletions(-)

-- 
1.9.1


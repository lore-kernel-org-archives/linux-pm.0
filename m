From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 0/2] powercap/rapl: reduce ipi calls and misc clean up
Date: Tue, 23 Feb 2016 12:59:10 -0800
Message-ID: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Changes since V4:
	- Deleted unnecessary cpumask_any_and() call, assign first cpu as lead
Changes since V3:
	- Avoid for_each_online_cpu() search for per package MSR access. This
	  is achieved by tracking a per package lead cpu via cpumask_xx() calls.
	  (suggested by Thomas Gleixner <tglx@linutronix.de>)
	- Add direct reference of RAPL package for each RAPL domain.

Jacob Pan (2):
  cpumask: export cpumask_any_but
  powercap/rapl: reduce ipi calls

 drivers/powercap/intel_rapl.c | 220 ++++++++++++++++++++++--------------------
 lib/cpumask.c                 |   1 +
 2 files changed, 115 insertions(+), 106 deletions(-)

-- 
1.9.1

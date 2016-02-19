From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 0/2] powercap/rapl: reduce ipi calls and misc clean up
Date: Fri, 19 Feb 2016 12:37:31 -0800
Message-ID: <1455914253-18138-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1298 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992763AbcBSUis (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 15:38:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Changes since V3:
	- Avoid for_each_online_cpu() search for per package MSR access. This
	  is achieved by tracking a per package lead cpu via cpumask_xx() calls.
	  (suggested by Thomas Gleixner <tglx@linutronix.de>)
	- Add direct reference of RAPL package for each RAPL domain.

This patch optimize remote IPI calls for MSR access.

Jacob Pan (2):
  cpumask: export cpumask_any_but
  powercap/rapl: reduce ipi calls

 drivers/powercap/intel_rapl.c | 224 ++++++++++++++++++++++--------------------
 lib/cpumask.c                 |   1 +
 2 files changed, 119 insertions(+), 106 deletions(-)

-- 
1.9.1


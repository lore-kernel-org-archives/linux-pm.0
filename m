From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 0/4] powercap/rapl: reduce ipi calls and misc clean up
Date: Wed, 24 Feb 2016 13:31:34 -0800
Message-ID: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2922 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbcBXVdH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 16:33:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Changes since v5:
	- Split changes into seprate patches. No code change.
Changes since V4:
	- Deleted unnecessary cpumask_any_and() call, assign first cpu as lead
Changes since V3:
	- Avoid for_each_online_cpu() search for per package MSR access. This
	  is achieved by tracking a per package lead cpu via cpumask_xx() calls.
	    (suggested by Thomas Gleixner <tglx@linutronix.de>)
	    - Add direct reference of RAPL package for each RAPL domain.

Jacob Pan (4):
  cpumask: export cpumask_any_but
  powercap/rapl: reduce ipi calls
  powercap/rapl: add package reference per domain
  powercap/rapl: track lead cpu per package

 drivers/powercap/intel_rapl.c | 220 ++++++++++++++++++++++--------------------
 lib/cpumask.c                 |   1 +
 2 files changed, 115 insertions(+), 106 deletions(-)

-- 
1.9.1


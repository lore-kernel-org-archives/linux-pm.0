From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 1/2] cpumask: export cpumask_any_but
Date: Tue, 23 Feb 2016 12:59:11 -0800
Message-ID: <1456261152-21907-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4902 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbcBWVA1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Feb 2016 16:00:27 -0500
In-Reply-To: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Export cpumask_any_but() for module use. This will be used by drivers
such as intel_rapl to locate an active cpu on a socket.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 lib/cpumask.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 5a70f61..81dedaa 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -41,6 +41,7 @@ int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 			break;
 	return i;
 }
+EXPORT_SYMBOL(cpumask_any_but);
 
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
-- 
1.9.1


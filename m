From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 1/2] cpumask: export cpumask_any_but
Date: Fri, 19 Feb 2016 12:37:32 -0800
Message-ID: <1455914253-18138-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1455914253-18138-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455914253-18138-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

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

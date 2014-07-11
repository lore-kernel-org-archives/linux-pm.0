From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch V1 17/30] mm, intel_powerclamp: Use cpu_to_mem()/numa_mem_id() to support memoryless node
Date: Fri, 11 Jul 2014 15:37:34 +0800
Message-ID: <1405064267-11678-18-git-send-email-jiang.liu@linux.intel.com>
References: <1405064267-11678-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1405064267-11678-1-git-send-email-jiang.liu@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>, Mike Galbraith <umgwanakikbuti@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org, linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When CONFIG_HAVE_MEMORYLESS_NODES is enabled, cpu_to_node()/numa_node_id()
may return a node without memory, and later cause system failure/panic
when calling kmalloc_node() and friends with returned node id.
So use cpu_to_mem()/numa_mem_id() instead to get the nearest node with
memory for the/current cpu.

If CONFIG_HAVE_MEMORYLESS_NODES is disabled, cpu_to_mem()/numa_mem_id()
is the same as cpu_to_node()/numa_node_id().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 95cb7fc20e17..9d9be8cd1b50 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -531,7 +531,7 @@ static int start_power_clamp(void)
 
 		thread = kthread_create_on_node(clamp_thread,
 						(void *) cpu,
-						cpu_to_node(cpu),
+						cpu_to_mem(cpu),
 						"kidle_inject/%ld", cpu);
 		/* bind to cpu here */
 		if (likely(!IS_ERR(thread))) {
@@ -582,7 +582,7 @@ static int powerclamp_cpu_callback(struct notifier_block *nfb,
 	case CPU_ONLINE:
 		thread = kthread_create_on_node(clamp_thread,
 						(void *) cpu,
-						cpu_to_node(cpu),
+						cpu_to_mem(cpu),
 						"kidle_inject/%lu", cpu);
 		if (likely(!IS_ERR(thread))) {
 			kthread_bind(thread, cpu);
-- 
1.7.10.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

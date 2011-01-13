From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/12] intel_idle: open broadcast clock event
Date: Wed, 12 Jan 2011 22:40:01 -0500
Message-ID: <2a2d31c8dc6f1ebcf5eab1d93a0cb0fb4ed57c7c.1294889887.git.len.brown@intel.com>
References: <1294890002-6274-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1294890002-6274-1-git-send-email-lenb@kernel.org>
In-reply-to: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
References: <ddbd550d503c9cdefcd6674a0ef168d57d3f0917.1294889887.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: stable@kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>

Intel_idle driver uses CLOCK_EVT_NOTIFY_BROADCAST_ENTER
CLOCK_EVT_NOTIFY_BROADCAST_EXIT
for broadcast clock events. The _ENTER/_EXIT doesn't really open broadcast clock
events, please see processor_idle.c for an example. In some situation, this will
cause boot hang, because some CPUs enters idle but local APIC timer stalls.

Reported-and-tested-by: Yan Zheng <zheng.z.yan@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
cc: stable@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c |   47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8256309..fc39358 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -59,6 +59,8 @@
 #include <linux/hrtimer.h>	/* ktime_get_real() */
 #include <trace/events/power.h>
 #include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <asm/mwait.h>
 
 #define INTEL_IDLE_VERSION "0.4"
@@ -73,6 +75,7 @@ static int max_cstate = MWAIT_MAX_NUM_CSTATES - 1;
 
 static unsigned int mwait_substates;
 
+#define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
 /* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
 static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
 
@@ -252,6 +255,39 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	return usec_delta;
 }
 
+static void __setup_broadcast_timer(void *arg)
+{
+	unsigned long reason = (unsigned long)arg;
+	int cpu = smp_processor_id();
+
+	reason = reason ?
+		CLOCK_EVT_NOTIFY_BROADCAST_ON : CLOCK_EVT_NOTIFY_BROADCAST_OFF;
+
+	clockevents_notify(reason, &cpu);
+}
+
+static int __cpuinit setup_broadcast_cpuhp_notify(struct notifier_block *n,
+		unsigned long action, void *hcpu)
+{
+	int hotcpu = (unsigned long)hcpu;
+
+	switch (action & 0xf) {
+	case CPU_ONLINE:
+		smp_call_function_single(hotcpu, __setup_broadcast_timer,
+			(void *)true, 1);
+		break;
+	case CPU_DOWN_PREPARE:
+		smp_call_function_single(hotcpu, __setup_broadcast_timer,
+			(void *)false, 1);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata setup_broadcast_notifier = {
+	.notifier_call = setup_broadcast_cpuhp_notify,
+};
+
 /*
  * intel_idle_probe()
  */
@@ -314,7 +350,11 @@ static int intel_idle_probe(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
-		lapic_timer_reliable_states = 0xFFFFFFFF;
+		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
+	else {
+		smp_call_function(__setup_broadcast_timer, (void *)true, 1);
+		register_cpu_notifier(&setup_broadcast_notifier);
+	}
 
 	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
 		" model 0x%X\n", boot_cpu_data.x86_model);
@@ -441,6 +481,11 @@ static void __exit intel_idle_exit(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 
+	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE) {
+		smp_call_function(__setup_broadcast_timer, (void *)false, 1);
+		unregister_cpu_notifier(&setup_broadcast_notifier);
+	}
+
 	return;
 }
 
-- 
1.7.4.rc1.14.g7fad99

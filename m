From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 7/9] arm,arm64,drivers: reduce scope of cap_parsing_failed
Date: Thu,  9 Feb 2017 09:25:23 +0000
Message-ID: <20170209092525.6654-8-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170209092525.6654-1-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, juri.lelli-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Reduce the scope of cap_parsing_failed (making it static in
drivers/base/arch_topology.c) by slightly changing {arm,arm64} DT
parsing code.

For arm checking for !cap_parsing_failed before calling normalize_
cpu_capacity() is superfluous, as returning an error from parse_
cpu_capacity() (above) means cap_from _dt is set to false.

For arm64 we can simply check if raw_capacity points to something,
which is not if capacity parsing has failed.

Suggested-by: Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/kernel/topology.c   | 3 +--
 arch/arm64/kernel/topology.c | 5 +----
 drivers/base/arch_topology.c | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 51e9ed6439f1..5d4679a5418b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -75,7 +75,6 @@ static unsigned long *__cpu_capacity;
 
 static unsigned long middle_capacity = 1;
 static bool cap_from_dt = true;
-extern bool cap_parsing_failed;
 extern void normalize_cpu_capacity(void);
 extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
@@ -164,7 +163,7 @@ static void __init parse_dt_topology(void)
 		middle_capacity = ((max_capacity / 3)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
 
-	if (cap_from_dt && !cap_parsing_failed)
+	if (cap_from_dt)
 		normalize_cpu_capacity();
 }
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f629f7524d65..deb5ebc1bdfe 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -26,7 +26,6 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-extern bool cap_parsing_failed;
 extern void normalize_cpu_capacity(void);
 extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
@@ -186,10 +185,8 @@ static int __init parse_dt_topology(void)
 	 * cluster with restricted subnodes.
 	 */
 	map = of_get_child_by_name(cn, "cpu-map");
-	if (!map) {
-		cap_parsing_failed = true;
+	if (!map)
 		goto out;
-	}
 
 	ret = parse_cluster(map, 0);
 	if (ret != 0)
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c1dd430adad2..c75fa5ab732b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -90,7 +90,7 @@ subsys_initcall(register_cpu_capacity_sysctl);
 
 u32 capacity_scale;
 u32 *raw_capacity;
-bool cap_parsing_failed;
+static bool cap_parsing_failed;
 
 void normalize_cpu_capacity(void)
 {
@@ -205,7 +205,7 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || cap_parsing_failed)
+	if (!acpi_disabled || !raw_capacity)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

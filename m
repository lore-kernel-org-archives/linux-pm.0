From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH 7/7] arm,arm64,drivers: reduce scope of cap_parsing_failed
Date: Thu, 19 Jan 2017 14:37:57 +0000
Message-ID: <20170119143757.14537-8-juri.lelli@arm.com>
References: <20170119143757.14537-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170119143757.14537-1-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Reduce the scope of cap_parsing_failed (making it static in
drivers/base/arch_topology.c) by slightly changing {arm,arm64} DT
parsing code.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
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
index 3faf89518892..cfe51f7e1a3e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -99,7 +99,7 @@ subsys_initcall(register_cpu_capacity_sysctl);
 
 u32 capacity_scale;
 u32 *raw_capacity;
-bool cap_parsing_failed;
+static bool cap_parsing_failed;
 
 void normalize_cpu_capacity(void)
 {
@@ -209,7 +209,7 @@ static struct notifier_block init_cpu_capacity_notifier = {
 
 static int __init register_cpufreq_notifier(void)
 {
-	if (cap_parsing_failed)
+	if (!raw_capacity)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-- 
2.10.0

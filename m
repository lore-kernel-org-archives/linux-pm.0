From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 5/6] arm64: Fixup users of topology_physical_package_id
Date: Tue, 19 Sep 2017 13:47:50 -0500
Message-ID: <20170919184751.25110-6-jeremy.linton@arm.com>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919184751.25110-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

There are a few arm64 specific users (cpufreq, psci, etc) which really
want the cluster rather than the topology_physical_package_id(). Lets
convert those users to topology_cod_id(). That way when we start
differentiating the socket/cluster they will continue to behave correctly.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/clk/clk-mb86s7x.c        | 2 +-
 drivers/cpufreq/arm_big_little.c | 2 +-
 drivers/firmware/psci_checker.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mb86s7x.c b/drivers/clk/clk-mb86s7x.c
index 2a83a3ff1d09..da4b456f9afc 100644
--- a/drivers/clk/clk-mb86s7x.c
+++ b/drivers/clk/clk-mb86s7x.c
@@ -338,7 +338,7 @@ static struct clk_hw *mb86s7x_clclk_register(struct device *cpu_dev)
 		return ERR_PTR(-ENOMEM);
 
 	clc->hw.init = &init;
-	clc->cluster = topology_physical_package_id(cpu_dev->id);
+	clc->cluster = topology_cod_id(cpu_dev->id);
 
 	init.name = dev_name(cpu_dev);
 	init.ops = &clk_clc_ops;
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 17504129fd77..6ee69b3820de 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -72,7 +72,7 @@ static struct mutex cluster_lock[MAX_CLUSTERS];
 
 static inline int raw_cpu_to_cluster(int cpu)
 {
-	return topology_physical_package_id(cpu);
+	return topology_cod_id(cpu);
 }
 
 static inline int cpu_to_cluster(int cpu)
diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
index 6523ce962865..a9465f5d344a 100644
--- a/drivers/firmware/psci_checker.c
+++ b/drivers/firmware/psci_checker.c
@@ -202,7 +202,7 @@ static int hotplug_tests(void)
 	 */
 	for (i = 0; i < nb_cluster; ++i) {
 		int cluster_id =
-			topology_physical_package_id(cpumask_any(clusters[i]));
+			topology_cod_id(cpumask_any(clusters[i]));
 		ssize_t len = cpumap_print_to_pagebuf(true, page_buf,
 						      clusters[i]);
 		/* Remove trailing newline. */
-- 
2.13.5

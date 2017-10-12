From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 5/7] arm64: Fixup users of topology_physical_package_id
Date: Thu, 12 Oct 2017 14:48:54 -0500
Message-ID: <20171012194856.13844-6-jeremy.linton@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012194856.13844-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

There are a few arm64 specific users (cpufreq, psci, etc) which really
want the cluster rather than the topology_physical_package_id(). Lets
convert those users to topology_cod_id(). That way when we start
differentiating the socket/cluster they will continue to behave correctly.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 2 +-
 drivers/firmware/psci_checker.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

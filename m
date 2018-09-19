From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/12] OPP: Don't try to remove all OPP tables on failure
Date: Wed, 19 Sep 2018 15:20:21 -0700
Message-ID: <404b1369ea26f598b96ae4d3183262a879703cfe.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

dev_pm_opp_of_cpumask_add_table() creates the OPP table for all CPUs
present in the cpumask and on errors it should revert all changes it has
done.

It actually is doing a bit more than that. On errors, it tries to free
all the OPP tables, even the one it hasn't created yet. This may also
end up freeing the OPP tables which were created from separate path,
like dev_pm_opp_set_supported_hw().

Reported-and-tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/cpu.c | 8 ++++++--
 drivers/opp/of.c  | 4 ++--
 drivers/opp/opp.h | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 0c0910709435..2eb5e2e7ff66 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -108,7 +108,8 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of,
+				      int last_cpu)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -116,6 +117,9 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 	WARN_ON(cpumask_empty(cpumask));
 
 	for_each_cpu(cpu, cpumask) {
+		if (cpu == last_cpu)
+			break;
+
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev) {
 			pr_err("%s: failed to get cpu%d device\n", __func__,
@@ -140,7 +144,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, false);
+	_dev_pm_opp_cpumask_remove_table(cpumask, false, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 20988c426650..86222586f27b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
  */
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+	_dev_pm_opp_cpumask_remove_table(cpumask, true, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
@@ -627,7 +627,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 				 __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			dev_pm_opp_of_cpumask_remove_table(cpumask);
+			_dev_pm_opp_cpumask_remove_table(cpumask, true, cpu);
 			break;
 		}
 	}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 7c540fd063b2..a9d22aa534c3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -196,7 +196,7 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
-- 
2.14.1

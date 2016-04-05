From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] cpufreq: mt8173: use list_for_each_entry*()
Date: Tue,  5 Apr 2016 10:38:06 +0800
Message-ID: <0679e197c8c0c4329d3d8190f1777fd61edbaebf.1459823809.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Geliang Tang <geliangtang@163.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use list_for_each_entry*() instead of list_for_each*() to simplify
the code.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/cpufreq/mt8173-cpufreq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 2058e6d..6f602c7 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -59,11 +59,8 @@ static LIST_HEAD(dvfs_info_list);
 static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
 {
 	struct mtk_cpu_dvfs_info *info;
-	struct list_head *list;
-
-	list_for_each(list, &dvfs_info_list) {
-		info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
 
+	list_for_each_entry(info, &dvfs_info_list, list_head) {
 		if (cpumask_test_cpu(cpu, &info->cpus))
 			return info;
 	}
@@ -524,8 +521,7 @@ static struct cpufreq_driver mt8173_cpufreq_driver = {
 
 static int mt8173_cpufreq_probe(struct platform_device *pdev)
 {
-	struct mtk_cpu_dvfs_info *info;
-	struct list_head *list, *tmp;
+	struct mtk_cpu_dvfs_info *info, *tmp;
 	int cpu, ret;
 
 	for_each_possible_cpu(cpu) {
@@ -559,11 +555,9 @@ static int mt8173_cpufreq_probe(struct platform_device *pdev)
 	return 0;
 
 release_dvfs_info_list:
-	list_for_each_safe(list, tmp, &dvfs_info_list) {
-		info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
-
+	list_for_each_entry_safe(info, tmp, &dvfs_info_list, list_head) {
 		mtk_cpu_dvfs_info_release(info);
-		list_del(list);
+		list_del(&info->list_head);
 	}
 
 	return ret;
-- 
2.5.5

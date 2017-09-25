From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] cpufreq: SPEAr: pr_err() strings should end with newlines
Date: Mon, 25 Sep 2017 15:43:49 +0530
Message-ID: <511e2c0f9a2dd23aceb8c0fc39184bfaca1f98c9.1506334381.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35971 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbdIYKOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 06:14:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/cpufreq/spear-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 4894924..195f27f 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -177,7 +177,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 
 	np = of_cpu_device_node_get(0);
 	if (!np) {
-		pr_err("No cpu node found");
+		pr_err("No cpu node found\n");
 		return -ENODEV;
 	}
 
@@ -187,7 +187,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 
 	prop = of_find_property(np, "cpufreq_tbl", NULL);
 	if (!prop || !prop->value) {
-		pr_err("Invalid cpufreq_tbl");
+		pr_err("Invalid cpufreq_tbl\n");
 		ret = -ENODEV;
 		goto out_put_node;
 	}
-- 
1.9.1

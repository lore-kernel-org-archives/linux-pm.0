From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 396/493] cpufreq: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:45 -0500
Message-ID: <1353349642-3677-396-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41486 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab2KSSew (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Nov 2012 13:34:52 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl> 
Cc: cpufreq@vger.kernel.org 
Cc: linux-pm@vger.kernel.org 
---
 drivers/cpufreq/longhaul.c    | 2 +-
 drivers/cpufreq/powernow-k8.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 8d7ebb2..f1fa500 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -930,7 +930,7 @@ static int __cpuinit longhaul_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int __devexit longhaul_cpu_exit(struct cpufreq_policy *policy)
+static int longhaul_cpu_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_put_attr(policy->cpu);
 	return 0;
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 1fd0c8a..056faf6 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1186,7 +1186,7 @@ err_out:
 	return -ENODEV;
 }
 
-static int __devexit powernowk8_cpu_exit(struct cpufreq_policy *pol)
+static int powernowk8_cpu_exit(struct cpufreq_policy *pol)
 {
 	struct powernow_k8_data *data = per_cpu(powernow_data, pol->cpu);
 
-- 
1.8.0


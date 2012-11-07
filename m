From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 5/6 v4] power: export opp cpufreq functions
Date: Wed,  7 Nov 2012 12:32:45 -0600
Message-ID: <1352313166-28980-6-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352313166-28980-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

These functions are needed to make the cpufreq-core0 and highbank-cpufreq
drivers loadable as modules.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
Changes from v3
	includes linux/export.h instead of module.h
Changes from v2
	None.
Changes from v1
        Added Nishanth Menon's ack.
        Clarified the purpose of the change in the commit message.

 drivers/base/power/opp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index d946864..4062ec3 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -23,6 +23,7 @@
 #include <linux/rcupdate.h>
 #include <linux/opp.h>
 #include <linux/of.h>
+#include <linux/export.h>
 
 /*
  * Internal data structure organization with the OPP layer library is as
@@ -643,6 +644,7 @@ int opp_init_cpufreq_table(struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL(opp_init_cpufreq_table);
 
 /**
  * opp_free_cpufreq_table() - free the cpufreq table
@@ -660,6 +662,7 @@ void opp_free_cpufreq_table(struct device *dev,
 	kfree(*table);
 	*table = NULL;
 }
+EXPORT_SYMBOL(opp_free_cpufreq_table);
 #endif		/* CONFIG_CPU_FREQ */
 
 /**
@@ -720,4 +723,5 @@ int of_init_opp_table(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(of_init_opp_table);
 #endif
-- 
1.7.11.7

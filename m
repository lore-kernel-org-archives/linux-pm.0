From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] PM / OPP: Export more symbols for module usage
Date: Mon, 28 Jan 2013 12:26:16 -0600
Message-ID: <1359397576-26131-3-git-send-email-nm@ti.com>
References: <1359397576-26131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359397576-26131-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Rafael <rjw@sisk.pl>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Mark Langsdorf <mark.langsdorf@calxeda.com>

Export cpufreq helpers in OPP to make the cpufreq-core0 and highbank-cpufreq
drivers loadable as modules.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/base/power/opp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 0dbe270..32ee0fc 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -661,6 +661,7 @@ int opp_init_cpufreq_table(struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(opp_init_cpufreq_table);
 
 /**
  * opp_free_cpufreq_table() - free the cpufreq table
@@ -678,6 +679,7 @@ void opp_free_cpufreq_table(struct device *dev,
 	kfree(*table);
 	*table = NULL;
 }
+EXPORT_SYMBOL_GPL(opp_free_cpufreq_table);
 #endif		/* CONFIG_CPU_FREQ */
 
 /**
@@ -738,4 +740,5 @@ int of_init_opp_table(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(of_init_opp_table);
 #endif
-- 
1.7.9.5

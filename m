From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] cpufreq: dt: Add support for APM X-Gene 2
Date: Thu, 15 Dec 2016 14:55:00 -0800
Message-ID: <1481842500-11836-1-git-send-email-hotran@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Hoan Tran <hotran@apm.com>
List-Id: linux-pm@vger.kernel.org

Add the compatible string for supporting the generic device tree cpufreq-dt
driver on APM's X-Gene 2 SoC.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bc97b6a..7fcaf26 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -26,6 +26,8 @@
 	{ .compatible = "allwinner,sun8i-a83t", },
 	{ .compatible = "allwinner,sun8i-h3", },
 
+	{ .compatible = "apm,xgene-shadowcat", },
+
 	{ .compatible = "arm,integrator-ap", },
 	{ .compatible = "arm,integrator-cp", },
 
-- 
1.9.1

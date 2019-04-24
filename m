From: andy.tang@nxp.com
Subject: [PATCH] cpufreq: qoriq: Add ls1028a chip support
Date: Wed, 24 Apr 2019 10:32:23 +0800
Message-ID: <20190424023223.29614-1-andy.tang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Enable cpufreq feature on ls1028a chip by adding its compatible
string.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 drivers/cpufreq/qoriq-cpufreq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 4295e54..d308c4d 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 
 	{ .compatible = "fsl,ls1012a-clockgen", },
 	{ .compatible = "fsl,ls1021a-clockgen", },
+	{ .compatible = "fsl,ls1028a-clockgen", },
 	{ .compatible = "fsl,ls1043a-clockgen", },
 	{ .compatible = "fsl,ls1046a-clockgen", },
 	{ .compatible = "fsl,ls1088a-clockgen", },
-- 
1.7.1

From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks using PM clocks
Date: Thu, 23 Apr 2015 14:15:40 +0530
Message-ID: <1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46795 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbbDWIqB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 04:46:01 -0400
In-Reply-To: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>

Add runtime PM support to handle (core and iface) clocks for devices
without a controllable power domain. Once the drivers for these devices
are converted to use runtime PM apis, all clock handling (for core and
iface) from these drivers can then be removed.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 480ebf6..92b0f6d 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/jiffies.h>
 #include <linux/pm_clock.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include "gdsc.h"
 
@@ -226,3 +227,22 @@ void gdsc_unregister(struct device *dev)
 {
 	of_genpd_del_provider(dev->of_node);
 }
+
+static struct dev_pm_domain default_qcom_pm_domain = {
+	.ops = {
+		USE_PM_CLK_RUNTIME_OPS
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+static struct pm_clk_notifier_block qcom_pm_notifier = {
+	.pm_domain	= &default_qcom_pm_domain,
+	.con_ids	= { "core", "iface" },
+};
+
+static int __init qcom_pm_runtime_init(void)
+{
+	pm_clk_add_notifier(&platform_bus_type, &qcom_pm_notifier);
+	return 0;
+}
+core_initcall(qcom_pm_runtime_init);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


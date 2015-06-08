From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 4/8] clk: scpi: add support for cpufreq virtual device
Date: Mon,  8 Jun 2015 11:39:58 +0100
Message-ID: <1433760002-24120-5-git-send-email-sudeep.holla@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48090 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbbFHKk2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Jun 2015 06:40:28 -0400
In-Reply-To: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>

The clocks for the CPUs are provided by SCP and are managed by this
clock driver. So the cpufreq device needs to be added only after the
clock get registered and removed when this driver is unloaded.

This patch manages the cpufreq virtual device based on the clock
availability.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/clk-scpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 707b3430c55f..2e056ac19c54 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -34,6 +34,8 @@ struct scpi_clk {
 
 #define to_scpi_clk(clk) container_of(clk, struct scpi_clk, hw)
 
+static struct platform_device *cpufreq_dev;
+
 static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
 {
@@ -238,6 +240,11 @@ static int scpi_clocks_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 
+	if (cpufreq_dev) {
+		platform_device_unregister(cpufreq_dev);
+		cpufreq_dev = NULL;
+	}
+
 	for_each_available_child_of_node(np, child)
 		of_clk_del_provider(np);
 	return 0;
@@ -263,6 +270,12 @@ static int scpi_clocks_probe(struct platform_device *pdev)
 			return ret;
 		}
 	}
+	/* Add the virtual cpufreq device */
+	cpufreq_dev = platform_device_register_simple("scpi-cpufreq",
+						      -1, NULL, 0);
+	if (!cpufreq_dev)
+		pr_warn("unable to register cpufreq device");
+
 	return 0;
 }
 
-- 
1.9.1


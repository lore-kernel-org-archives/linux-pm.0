From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 4/5] clk: scpi: add support for cpufreq virtual device
Date: Wed, 27 May 2015 10:53:17 +0100
Message-ID: <1432720398-5701-5-git-send-email-sudeep.holla@arm.com>
References: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432720398-5701-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The clocks for the CPUs are provided by SCP and are managed by this
clock driver. So the cpufreq device needs to be added only after the
clock get registered and removed when this driver is unloaded.

This patch manages the cpufreq virtual device based on the clock
availability.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/clk-scpi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 55bfa708a5b4..04068072f8d1 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -36,6 +36,7 @@ struct scpi_clk {
 #define to_scpi_clk(clk) container_of(clk, struct scpi_clk, hw)
 
 static struct scpi_ops *scpi_ops;
+static struct platform_device *cpufreq_dev;
 
 static unsigned long scpi_clk_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
@@ -241,6 +242,11 @@ static int scpi_clocks_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 
+	if (cpufreq_dev) {
+		platform_device_unregister(cpufreq_dev);
+		cpufreq_dev = NULL;
+	}
+
 	for_each_available_child_of_node(np, child)
 		of_clk_del_provider(np);
 	scpi_ops = NULL;
@@ -264,6 +270,12 @@ static int scpi_clocks_probe(struct platform_device *pdev)
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

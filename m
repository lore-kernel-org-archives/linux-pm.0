From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V1 7/8] cpufreq: calxeda: reuse dt_device.c to create cpufreq platform device
Date: Mon,  1 Dec 2014 17:11:28 +0530
Message-ID: <b05c2501e607e23ed7bf30ab81211a2d6f57eecf.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:52196 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbaLALmR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:42:17 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so11019667pad.27
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:42:17 -0800 (PST)
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, santosh shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, k.chander@samsung.com, olof@lixom.net, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

We now have a common interface for create platform device required to probe
cpufreq-dt driver (and others as well). Lets create devices from dt_device.c
instead of platform specific code.

For calxeda, we are updating the blacklist instead of DT because the newer kernel
should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dt_device.c        | 3 +++
 drivers/cpufreq/highbank-cpufreq.c | 5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index 2075228..8b5ac05 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -34,6 +34,9 @@ static const struct of_device_id compatible_machine_match[] = {
 
 	{ .compatible = "xlnx,zynq-7000",	.data = "cpufreq-dt" },
 
+	{ .compatible = "calxeda,highbank",	.data = "cpufreq-dt" },
+	{ .compatible = "calxeda,ecx-2000",	.data = "cpufreq-dt" },
+
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
 
 	/* BLACKLIST of existing users of other drivers below */
diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index 1608f71..faab680 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -20,7 +20,6 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/pl320-ipc.h>
-#include <linux/platform_device.h>
 
 #define HB_CPUFREQ_CHANGE_NOTE	0x80000001
 #define HB_CPUFREQ_IPC_LEN	7
@@ -60,7 +59,6 @@ static struct notifier_block hb_cpufreq_clk_nb = {
 
 static int hb_cpufreq_driver_init(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	struct device_node *np;
@@ -95,9 +93,6 @@ static int hb_cpufreq_driver_init(void)
 		goto out_put_node;
 	}
 
-	/* Instantiate cpufreq-dt */
-	platform_device_register_full(&devinfo);
-
 out_put_node:
 	of_node_put(np);
 	return ret;
-- 
2.0.3.693.g996b0fd


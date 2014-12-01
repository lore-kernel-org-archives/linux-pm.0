From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V1 4/8] cpufreq: mvebu: reuse dt_device.c to create cpufreq platform device
Date: Mon,  1 Dec 2014 17:11:25 +0530
Message-ID: <862271735f97759b517ef8c9eb8ee66bdd8cbec3.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36559 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbaLALmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:42:05 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so10974183pab.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:42:04 -0800 (PST)
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

For marvell, we are updating the blacklist instead of DT because the newer
kernel should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-mvebu/pmsu.c  | 1 -
 drivers/cpufreq/dt_device.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index bbd8664..9d02618 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -644,7 +644,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		}
 	}
 
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index cf01bed..33fc046 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -27,6 +27,8 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "fsl,imx27",		.data = "cpufreq-dt" },
 	{ .compatible = "fsl,imx51",		.data = "cpufreq-dt" },
 
+	{ .compatible = "marvell,armadaxp",	.data = "cpufreq-dt" },
+
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
 
 	/* BLACKLIST of existing users of other drivers below */
-- 
2.0.3.693.g996b0fd


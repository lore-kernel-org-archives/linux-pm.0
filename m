From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 6/7] ARM: mxs: register cpufreq-dt in pm init
Date: Sun, 22 Mar 2015 00:30:02 +0000
Message-ID: <1426984203-9133-7-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60752 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbCVAab (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2015 20:30:31 -0400
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
Cc: fabio.estevam@freescale.com, marex@denx.de, kernel@pengutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch adds the registration of cpufreq-dt into pm init to get
cpufreq support for MXS platform.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-mxs/pm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
index 0170e99..23c52e0 100644
--- a/arch/arm/mach-mxs/pm.c
+++ b/arch/arm/mach-mxs/pm.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/suspend.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include "pm.h"
 
 static int mxs_suspend_enter(suspend_state_t state)
@@ -35,7 +36,12 @@ static struct platform_suspend_ops mxs_suspend_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
+static struct platform_device mxs_cpufreq_pdev = {
+	.name = "cpufreq-dt",
+};
+
 void __init mxs_pm_init(void)
 {
 	suspend_set_ops(&mxs_suspend_ops);
+	platform_device_register(&mxs_cpufreq_pdev);
 }
-- 
1.7.9.5


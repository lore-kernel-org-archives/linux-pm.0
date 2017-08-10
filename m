From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: Kconfig: fix indentation in couple of entries
Date: Thu, 10 Aug 2017 12:16:50 +0100
Message-ID: <1502363810-20038-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbdHJLQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Aug 2017 07:16:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

There are couple of places where 8 spaces are used instead of tabs.
Replace former by latter. No functional change intended.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/Kconfig.arm | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Hi Viresh,

I found I am the culprit for the indentation issue you pointed out in
SCMI patch. Looks like I am always copy pasting from previous places
I added and spreading it :)

Regards,
Sudeep

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1f617143838c..753375c9d5dd 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -41,10 +41,10 @@ config ARM_DT_BL_CPUFREQ
 	  big.LITTLE platform. This gets frequency tables from DT.

 config ARM_VEXPRESS_SPC_CPUFREQ
-        tristate "Versatile Express SPC based CPUfreq driver"
+	tristate "Versatile Express SPC based CPUfreq driver"
 	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
-        help
-          This add the CPUfreq driver support for Versatile Express
+	help
+	  This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.

 config ARM_EXYNOS5440_CPUFREQ
@@ -227,9 +227,9 @@ config ARM_SCMI_CPUFREQ
 	  firmware providing the CPU DVFS functionality.

 config ARM_SCPI_CPUFREQ
-        tristate "SCPI based CPUfreq driver"
+	tristate "SCPI based CPUfreq driver"
 	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
-        help
+	help
 	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
 	  using SCPI protocol for CPU power management.

--
2.7.4

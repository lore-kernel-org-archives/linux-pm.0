From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: Kconfig: Fix spelling errors
Date: Tue, 22 Apr 2014 22:40:10 +0300
Message-ID: <5356C59A.1070906@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:51058 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751534AbaDVTkP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 15:40:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Fix 4 spelling errors in help sections.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/Kconfig.arm | 4 ++--
 drivers/cpufreq/Kconfig.x86 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5805035..6e05a1e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -85,7 +85,7 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
 	  It allows usage of special frequencies for Samsung Exynos
 	  processors if thermal conditions are appropriate.
 
-	  It reguires, for safe operation, thermal framework with properly
+	  It requires, for safe operation, thermal framework with properly
 	  defined trip points.
 
 	  If in doubt, say N.
@@ -186,7 +186,7 @@ config ARM_S3C2416_CPUFREQ
 	  S3C2450 SoC. The S3C2416 supports changing the rate of the
 	  armdiv clock source and also entering a so called dynamic
 	  voltage scaling mode in which it is possible to reduce the
-	  core voltage of the cpu.
+	  core voltage of the CPU.
 
 	  If in doubt, say N.
 
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index d369349..89ae88f 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -10,7 +10,7 @@ config X86_INTEL_PSTATE
 	  The driver implements an internal governor and will become
           the scaling driver and governor for Sandy bridge processors.
 
-	  When this driver is enabled it will become the perferred
+	  When this driver is enabled it will become the preferred
           scaling driver for Sandy bridge processors.
 
 	  If in doubt, say N.
@@ -52,7 +52,7 @@ config X86_ACPI_CPUFREQ_CPB
 	help
 	  The powernow-k8 driver used to provide a sysfs knob called "cpb"
 	  to disable the Core Performance Boosting feature of AMD CPUs. This
-	  file has now been superseeded by the more generic "boost" entry.
+	  file has now been superseded by the more generic "boost" entry.
 
 	  By enabling this option the acpi_cpufreq driver provides the old
 	  entry in addition to the new boost ones, for compatibility reasons.
-- 
1.9.0


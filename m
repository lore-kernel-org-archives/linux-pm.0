From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH v2 2/2] ARM64 / cpuidle: Use new cpuidle macro for entering retention state
Date: Wed,  8 Nov 2017 17:38:42 -0700
Message-ID: <1510187922-8218-3-git-send-email-pprakash@codeaurora.org>
References: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbdKIAi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 19:38:57 -0500
In-Reply-To: <1510187922-8218-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

CPU_PM_CPU_IDLE_ENTER_RETENTION skips calling cpu_pm_enter() and
cpu_pm_exit(). By not calling cpu_pm functions in idle entry/exit
paths we can reduce the latency involved in entering and exiting
the low power idle state.

On ARM64 based Qualcomm server platform we measured below overhead
for calling cpu_pm_enter and cpu_pm_exit for retention states.

workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
	Average overhead of cpu_pm_enter - 1.2us
	Average overhead of cpu_pm_exit  - 3.1us

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 arch/arm64/kernel/cpuidle.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index fd69108..f2d1381 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -47,6 +47,8 @@ int arm_cpuidle_suspend(int index)
 
 #include <acpi/processor.h>
 
+#define ARM64_LPI_IS_RETENTION_STATE(arch_flags) (!(arch_flags))
+
 int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
 	return arm_cpuidle_init(cpu);
@@ -54,6 +56,10 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 
 int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
-	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
+	if (ARM64_LPI_IS_RETENTION_STATE(lpi->arch_flags))
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION(arm_cpuidle_suspend,
+						lpi->index);
+	else
+		return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
 }
 #endif
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 1/3] arm64: psci: warn if psci_power_state variable is not initialised
Date: Thu, 30 Oct 2014 09:25:36 +0530
Message-ID: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:43232 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbaJ3Dzj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 23:55:39 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so4306109pdj.14
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2014 20:55:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vladimir Murzin <vladimir.murzin@arm.com>

Without this cpu_suspend may cause crash dump when psci cpuidle
is not initialised and cpu_suspend is called.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/kernel/psci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 866c1c8..2178d6e 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -523,9 +523,11 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	struct psci_power_state *state = __get_cpu_var(psci_power_state);
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
-	 * from the cpu_suspend operations
+	 * from the cpu_suspend operations.
+	 * Also psci_power_state variable should have been populated by
+	 * above init idle routine.
 	 */
-	if (WARN_ON_ONCE(!index))
+	if (WARN_ON_ONCE(!index || !state))
 		return -EINVAL;
 
 	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
-- 
1.9.1


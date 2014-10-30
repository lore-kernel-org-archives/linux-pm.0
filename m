From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 2/3] arm64: psci: fix cpu_suspend to check idle state type for index
Date: Thu, 30 Oct 2014 09:25:37 +0530
Message-ID: <1414641338-25279-2-git-send-email-amit.daniel@samsung.com>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60535 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbaJ3Dzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 23:55:43 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so4232822pde.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2014 20:55:42 -0700 (PDT)
In-Reply-To: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vladimir Murzin <vladimir.murzin@arm.com>

This fix rectifies the psci cpu_suspend to check the C-state type
corresponding to the requested index.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/kernel/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 2178d6e..4ebc146 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -530,7 +530,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (WARN_ON_ONCE(!index || !state))
 		return -EINVAL;
 
-	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
+	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
 		ret = __cpu_suspend(index, psci_suspend_finisher);
-- 
1.9.1


From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH v2] arm64: psci: fix cpu_suspend to check idle state type for index
Date: Thu, 30 Oct 2014 17:54:51 +0530
Message-ID: <1414671891-29448-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41019 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759267AbaJ3MYk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 08:24:40 -0400
Received: by mail-pd0-f172.google.com with SMTP id r10so5102878pdi.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2014 05:24:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Cc: will.deacon@arm.com, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vladimir Murzin <vladimir.murzin@arm.com>

This fix rectifies the psci cpu_suspend implementation to check the
PSCI power state parameter type field associated with the requested idle
state index.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm64/kernel/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 866c1c8..663da77 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -528,7 +528,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
-	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
+	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
 		ret = __cpu_suspend(index, psci_suspend_finisher);
-- 
1.9.1


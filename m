From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 22/27] drivers: firmware: PSCI: Export psci_has_ext_power_state()
Date: Tue, 17 Nov 2015 15:37:46 -0700
Message-ID: <1447799871-56374-23-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35900 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbbKQWjD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:39:03 -0500
Received: by pacdm15 with SMTP id dm15so22087304pac.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:39:02 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>

Export psci_has_ext_power_state() to allow PSCI layers to determine and
pass the correct state id in the format supported.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/firmware/psci.c | 2 +-
 include/linux/psci.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index d24f35d..3fd42e4 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -83,7 +83,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static u32 psci_cpu_suspend_feature;
 
-static inline bool psci_has_ext_power_state(void)
+bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 12c4865..b9afbe2 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -23,6 +23,7 @@
 bool psci_tos_resident_on(int cpu);
 bool psci_power_state_loses_context(u32 state);
 bool psci_power_state_is_valid(u32 state);
+bool psci_has_ext_power_state(void);
 
 struct psci_operations {
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.1.4


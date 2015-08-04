From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 4/9] kernel/cpu_pm: fix cpu_cluster_pm_exit comment
Date: Tue,  4 Aug 2015 17:35:34 -0600
Message-ID: <1438731339-58317-5-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33805 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbHDXgL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:11 -0400
Received: by pdber20 with SMTP id er20so10215683pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:10 -0700 (PDT)
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

cpu_cluster_pm_exit() must be sent after cpu_cluster_pm_enter() has been
sent for the cluster and before any cpu_pm_exit() notifications are sent
for any CPU.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 kernel/cpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 9656a3c..009cc9a 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  * low power state that may have caused some blocks in the same power domain
  * to reset.
  *
- * Must be called after cpu_pm_exit has been called on all cpus in the power
+ * Must be called after cpu_cluster_pm_enter has been called for the power
  * domain, and before cpu_pm_exit has been called on any cpu in the power
  * domain. Notified drivers can include VFP co-processor, interrupt controller
  * and its PM extensions, local CPU timers context save/restore which
-- 
2.1.4


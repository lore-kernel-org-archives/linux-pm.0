From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v9 1/9] qcom: scm: scm_set_warm_boot_addr() to set the warmboot address
Date: Fri, 24 Oct 2014 17:40:16 -0600
Message-ID: <1414194024-55547-2-git-send-email-lina.iyer@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49874 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbaJXXkr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Oct 2014 19:40:47 -0400
Received: by mail-pa0-f50.google.com with SMTP id eu11so1978217pac.37
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2014 16:40:47 -0700 (PDT)
In-Reply-To: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Set the warmboot address using an SCM call, only if the new address is
different than the old one.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/scm-boot.c | 22 ++++++++++++++++++++++
 include/soc/qcom/scm-boot.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/qcom/scm-boot.c b/drivers/soc/qcom/scm-boot.c
index 60ff7b4..5710967 100644
--- a/drivers/soc/qcom/scm-boot.c
+++ b/drivers/soc/qcom/scm-boot.c
@@ -37,3 +37,25 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
 			&cmd, sizeof(cmd), NULL, 0);
 }
 EXPORT_SYMBOL(scm_set_boot_addr);
+
+
+int scm_set_warm_boot_addr(void *entry, int cpu)
+{
+	static int flags[NR_CPUS] = {
+		SCM_FLAG_WARMBOOT_CPU0,
+		SCM_FLAG_WARMBOOT_CPU1,
+		SCM_FLAG_WARMBOOT_CPU2,
+		SCM_FLAG_WARMBOOT_CPU3,
+	};
+	static DEFINE_PER_CPU(void *, last_known_entry);
+	int ret;
+
+	if (entry == per_cpu(last_known_entry, cpu))
+		return 0;
+
+	ret = scm_set_boot_addr(virt_to_phys(entry), flags[cpu]);
+	if (!ret)
+		per_cpu(last_known_entry, cpu) = entry;
+
+	return ret;
+}
diff --git a/include/soc/qcom/scm-boot.h b/include/soc/qcom/scm-boot.h
index 02b445c..100938b 100644
--- a/include/soc/qcom/scm-boot.h
+++ b/include/soc/qcom/scm-boot.h
@@ -22,5 +22,6 @@
 #define SCM_FLAG_WARMBOOT_CPU3		0x40
 
 int scm_set_boot_addr(phys_addr_t addr, int flags);
+int scm_set_warm_boot_addr(void *entry, int cpu);
 
 #endif
-- 
2.1.0


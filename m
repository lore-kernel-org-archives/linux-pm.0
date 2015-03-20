From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v17 10/10] ARM: qcom: Update defconfig to enable cpuidle
Date: Fri, 20 Mar 2015 14:21:17 -0600
Message-ID: <1426882877-33008-11-git-send-email-lina.iyer@linaro.org>
References: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33467 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbCTUSj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 16:18:39 -0400
Received: by pabxg6 with SMTP id xg6so106130141pab.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 13:18:39 -0700 (PDT)
In-Reply-To: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Update defconfig to allow cpuidle for QCOM cpus.

* Enable QCOM_PM
* Enable ARM_QCOM_CPUIDLE

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c7da33..56bda6b 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -30,6 +30,7 @@ CONFIG_CLEANCACHE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_QCOM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -135,6 +136,7 @@ CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
 CONFIG_QCOM_GSBI=y
+CONFIG_QCOM_PM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_GCC_806X=y
-- 
2.1.0


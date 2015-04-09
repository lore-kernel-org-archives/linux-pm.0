From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v19 2/3] ARM: config: Update qcom_defconfig to enable cpuidle
Date: Thu,  9 Apr 2015 13:20:42 -0600
Message-ID: <1428607243-7723-3-git-send-email-lina.iyer@linaro.org>
References: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34666 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181AbbDITVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2015 15:21:41 -0400
Received: by pdbqa5 with SMTP id qa5so105636981pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2015 12:21:41 -0700 (PDT)
In-Reply-To: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Update qcom_defconfig to allow cpuidle for QCOM cpus.

* Enable QCOM_PM
* Enable ARM_CPUIDLE

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c7da33..33a5339 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -30,6 +30,7 @@ CONFIG_CLEANCACHE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
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


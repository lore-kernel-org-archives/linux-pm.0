From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 16/16] drivers: qcom: Enable genpd on selecting QCOM_PM
Date: Fri, 26 Jun 2015 21:02:36 -0600
Message-ID: <1435374156-19214-17-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34557 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbF0DDK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:10 -0400
Received: by pdbep18 with SMTP id ep18so63072913pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:03:09 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Enable PM_CPU_DOMAIN and its PM_GENERIC_DOMAINS dependenciesd to provide
cpu domain support for QCOM SoCs.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 01aa2fd..9564a35 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -15,6 +15,9 @@ config QCOM_PM
 	depends on ARCH_QCOM && !ARM64
 	select QCOM_SCM
 	select ARM_CPU_SUSPEND
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_SLEEP
+	select PM_GENERIC_DOMAINS_OF
 	help
 	  QCOM Platform specific power driver to manage cores and L2 low power
 	  modes. It interface with various system drivers to put the cores in
-- 
2.1.4


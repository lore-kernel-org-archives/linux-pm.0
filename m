From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 1/7] msm: scm: Add SCM warmboot flags for quad core targets.
Date: Thu,  4 Sep 2014 16:35:26 -0600
Message-ID: <1409870132-16929-2-git-send-email-lina.iyer@linaro.org>
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49996 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbaIDWgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 18:36:24 -0400
Received: by mail-pd0-f172.google.com with SMTP id v10so2236920pde.31
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 15:36:23 -0700 (PDT)
In-Reply-To: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org
Cc: linux-pm@vger.kernel.org, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Quad core targets like APQ8074, APQ8064, APQ8084 need SCM support set up
warm boot addresses in the Secure Monitor. Extend the SCM flags to
support warmboot addresses for secondary cores.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/soc/qcom/scm-boot.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/qcom/scm-boot.h b/include/soc/qcom/scm-boot.h
index 6aabb24..02b445c 100644
--- a/include/soc/qcom/scm-boot.h
+++ b/include/soc/qcom/scm-boot.h
@@ -18,6 +18,8 @@
 #define SCM_FLAG_COLDBOOT_CPU3		0x20
 #define SCM_FLAG_WARMBOOT_CPU0		0x04
 #define SCM_FLAG_WARMBOOT_CPU1		0x02
+#define SCM_FLAG_WARMBOOT_CPU2		0x10
+#define SCM_FLAG_WARMBOOT_CPU3		0x40
 
 int scm_set_boot_addr(phys_addr_t addr, int flags);
 
-- 
1.9.1


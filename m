From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 1/2] ARM: qcom: Add SCM warmboot flags for quad core targets.
Date: Wed, 25 Feb 2015 15:54:11 -0700
Message-ID: <1424904852-12719-2-git-send-email-lina.iyer@linaro.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Quad core targets like APQ8074, APQ8064, APQ8084 need SCM support set up
warm boot addresses in the Secure Monitor. Extend the SCM flags to
support warmboot addresses for secondary cores.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/mach-qcom/scm-boot.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-qcom/scm-boot.h b/arch/arm/mach-qcom/scm-boot.h
index 6aabb24..02b445c 100644
--- a/arch/arm/mach-qcom/scm-boot.h
+++ b/arch/arm/mach-qcom/scm-boot.h
@@ -18,6 +18,8 @@
 #define SCM_FLAG_COLDBOOT_CPU3		0x20
 #define SCM_FLAG_WARMBOOT_CPU0		0x04
 #define SCM_FLAG_WARMBOOT_CPU1		0x02
+#define SCM_FLAG_WARMBOOT_CPU2		0x10
+#define SCM_FLAG_WARMBOOT_CPU3		0x40
 
 int scm_set_boot_addr(phys_addr_t addr, int flags);
 
-- 
2.1.0

From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 7/7] arm64: defconfig: Enable power management support for QCOM SoCs
Date: Fri, 17 Apr 2015 17:49:09 -0600
Message-ID: <1429314549-6730-8-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, Will.Deacon@arm.com, lorenzo.pieralisi@arm.com
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, mlocke@codeaurora.org, bryanh@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Enable QCOM_PM to allow QCOM SoCs to use the platform support to enter
idle states.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2212d40..901b05e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -132,6 +132,7 @@ CONFIG_RTC_DRV_XGENE=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_QCOM_PM=y
 CONFIG_MSM_GCC_8916=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PHY_XGENE=y
-- 
2.1.0

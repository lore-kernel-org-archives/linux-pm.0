From: Wei Ni <wni@nvidia.com>
Subject: [PATCH] arm64: defconfig: Enable TEGRA_SOCTHERM
Date: Wed, 24 Apr 2019 17:56:59 +0800
Message-ID: <1556099819-15553-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, daniel.lezcano@linaro.org, edubezval@gmail.com
Cc: linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Enable Tegra soctherm, and builds as kernel.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8432e24207e..3d8f9d5bf7cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -406,6 +406,7 @@ CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_TEGRA_SOCTHERM=y
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_QCOM_TSENS=y
 CONFIG_UNIPHIER_THERMAL=y
-- 
2.7.4

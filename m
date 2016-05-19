From: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Thu, 19 May 2016 00:00:18 -0500
Message-ID: <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, Andy Gross <andy.gross@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch adds the qcom,idle-state-spc compatible to the SPC idle
state.  This compatible indicates that the state is one which supports
freeze.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 208af00..032e411 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -104,7 +104,7 @@
 
 		idle-states {
 			CPU_SPC: spc {
-				compatible = "arm,idle-state";
+				compatible = "qcom,idle-state-spc", "arm,idle-state";
 				arm,psci-suspend-param = <0x40000002>;
 				entry-latency-us = <130>;
 				exit-latency-us = <150>;
-- 
1.9.1

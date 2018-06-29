From: David Dai <daidavid1@codeaurora.org>
Subject: [RFC PATCH v1 2/2] arm64: dts: sdm845: Add interconnect provider DT nodes
Date: Fri, 29 Jun 2018 14:08:18 -0700
Message-ID: <1530306498-5181-3-git-send-email-daidavid1@codeaurora.org>
References: <1530306498-5181-1-git-send-email-daidavid1@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306498-5181-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, daidavid1@codeaurora.org, amit.kucheria@linaro.org, ilina@codeaurora.org, seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
List-Id: linux-pm@vger.kernel.org

Add RSC(Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Change-Id: I58f0bfc3ed484d7b45064dceb94dcfda507e9333
Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 228d502..c2a5309 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1091,6 +1091,11 @@
 
 				pmi8998_bob: bob {};
 			};
+
+			qnoc: qnoc-rsc-hlos{
+				compatible = "qcom,sdm845-rsc-hlos";
+				status = "okay";
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

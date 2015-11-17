From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 24/27] arm64: dts: Add Qualcomm MSM8916, MTP8916, APQ8016, SBC8016 ids
Date: Tue, 17 Nov 2015 15:37:48 -0700
Message-ID: <1447799871-56374-25-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35958 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642AbbKQWjH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:39:07 -0500
Received: by pacdm15 with SMTP id dm15so22088902pac.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:39:06 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Kumar Gala <galak@codeaurora.org>

From: Kumar Gala <galak@codeaurora.org>

Add qcom,msm-id and qcom,board-id to allow bootloader to identify which
device tree to boot on the MTP8916 & SBC8016 boards.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts | 3 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi    | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 825f489..6fea25d 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -13,9 +13,11 @@
 
 /dts-v1/;
 
+#include <dt-bindings/arm/qcom-ids.h>
 #include "apq8016-sbc.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
 	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
+	qcom,board-id = <QCOM_BRD_ID(SBC, 1, 0) QCOM_BRD_SUBTYPE_DEFAULT>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
index fced77f..6c68b4e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -13,10 +13,13 @@
 
 /dts-v1/;
 
+#include <dt-bindings/arm/qcom-ids.h>
 #include "msm8916-mtp.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
 	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp-smb1360",
 			"qcom,msm8916", "qcom,mtp";
+	qcom,board-id = <QCOM_BRD_ID(MTP, 1, 0) QCOM_BRD_SUBTYPE_DEFAULT>,
+			<QCOM_BRD_ID(MTP, 1, 0) QCOM_BRD_SUBTYPE_MTP8916_SMB1360>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8d184ff..7be7c23 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -14,10 +14,16 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
+#include <dt-bindings/arm/qcom-ids.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8916";
 	compatible = "qcom,msm8916";
+	qcom,msm-id =	<QCOM_ID_MSM8916 0>,
+			<QCOM_ID_MSM8216 0>,
+			<QCOM_ID_MSM8116 0>,
+			<QCOM_ID_MSM8616 0>,
+			<QCOM_ID_APQ8016 0>;
 
 	interrupt-parent = <&intc>;
 
-- 
2.1.4


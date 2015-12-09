From: Tim Bird <tim.bird@sonymobile.com>
Subject: [PATCH v2 3/3] ARM: dts: qcom: add charger otg regulator
Date: Tue, 8 Dec 2015 16:40:18 -0800
Message-ID: <1449621618-11900-3-git-send-email-tim.bird@sonymobile.com>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:9267 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752254AbbLIAku (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 19:40:50 -0500
In-Reply-To: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org
Cc: Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com, tim.bird@sonymobile.com

Add the otg regulator provided by the charger block.

Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index b0d4439..1b80100 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -45,6 +45,10 @@
 					  "chg-gone",
 					  "usb-valid",
 					  "dc-valid";
+
+			usb-otg-in-supply = <&pm8941_5vs1>;
+
+			chg_otg: otg { };
 		};
 
 		pm8941_gpios: gpios@c000 {
-- 
2.4.2


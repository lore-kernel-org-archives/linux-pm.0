From: Tim Bird <tim.bird@sonymobile.com>
Subject: [PATCH v3 3/3] ARM: dts: qcom: add charger otg regulator
Date: Wed, 9 Dec 2015 04:45:55 -0800
Message-ID: <1449665155-29322-4-git-send-email-tim.bird@sonymobile.com>
References: <1449665155-29322-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449665155-29322-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org
Cc: Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com, tim.bird@sonymobile.com
List-Id: linux-pm@vger.kernel.org

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
2.6.3

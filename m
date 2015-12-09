From: Tim Bird <tim.bird@sonymobile.com>
Subject: [PATCH v3 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 9 Dec 2015 04:45:53 -0800
Message-ID: <1449665155-29322-2-git-send-email-tim.bird@sonymobile.com>
References: <1449665155-29322-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1449665155-29322-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, courtney.cavin@sonymobile.com, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org
Cc: Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com, tim.bird@sonymobile.com
List-Id: linux-pm@vger.kernel.org

Add a binding for the regulator which controls the OTG chargepath switch.
The OTG switch gets its power from pm8941_5vs1, and that should be
expressed as a usb-otg-in-supply property in the DT node for the
charger driver.  The regulator name is "otg".

Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
---
Changes since v1
 - switch supply name to have dashes instead of underscores
 - remove superfluous DT explanations in the otg node description
---
 .../devicetree/bindings/power_supply/qcom_smbb.txt    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
index 65b88fa..28b6da7 100644
--- a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
+++ b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
@@ -105,6 +105,22 @@ PROPERTIES
                regulation must be done externally to fully comply with
                the JEITA safety guidelines if this flag is set.
 
+- usb-otg-in-supply:
+  Usage: optional
+  Value type: <phandle>
+  Description: Reference to the regulator supplying power to the USB_OTG_IN
+               pin.
+
+child nodes:
+- otg:
+  Usage: optional
+  Description: This node defines a regulator used to control the direction
+               of VBUS voltage - specifically: whether to supply voltage
+               to VBUS for host mode operation of the OTG port, or allow
+               input voltage from external VBUS for charging.  In the
+               hardware, the supply for this regulator comes from
+               usb-otg-in-supply.
+
 EXAMPLE
 charger@1000 {
        compatible = "qcom,pm8941-charger";
@@ -128,4 +144,7 @@ charger@1000 {
 
        qcom,fast-charge-current-limit = <1000000>;
        qcom,dc-charge-current-limit = <1000000>;
+       usb-otg-in-supply = <&pm8941_5vs1>;
+
+       otg {};
 };
-- 
2.6.3

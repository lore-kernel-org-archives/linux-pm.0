From: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: [PATCHv2 2/4] dt-binding: power: Add Qualcomm SMBB binding
Date: Thu, 30 Jul 2015 10:53:55 -0700
Message-ID: <1438278837-29967-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1438278837-29967-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438278837-29967-1-git-send-email-bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Courtney Cavin <courtney.cavin-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Courtney Cavin <courtney.cavin-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>

Add the Qualcomm Switch-Mode Battery Charger and Boost device tree
binding.

Signed-off-by: Courtney Cavin <courtney.cavin-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
---

Changes since v1:
- Corrected authorship

 .../devicetree/bindings/power_supply/qcom_smbb.txt | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt

diff --git a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
new file mode 100644
index 000000000000..65b88fac854b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
@@ -0,0 +1,131 @@
+Qualcomm Switch-Mode Battery Charger and Boost
+
+PROPERTIES
+- compatible:
+  Usage: required
+  Value type: <stringlist>
+  Description: Must be one of:
+               - "qcom,pm8941-charger"
+
+- reg:
+  Usage: required
+  Value type: <prop-encoded-array>
+  Description: Base address of registers for SMBB block
+
+- interrupts:
+  Usage: required
+  Value type: <prop-encoded-array>
+  Description: The format of the specifier is defined by the binding document
+               describing the node's interrupt parent.  Must contain one
+               specifier for each of the following interrupts, in order:
+               - charge done
+               - charge fast mode
+               - charge trickle mode
+               - battery temperature ok
+               - battery present
+               - charger disconnected
+               - USB-in valid
+               - DC-in valid
+
+- interrupt-names:
+  Usage: required
+  Value type: <stringlist>
+  Description: Must contain the following list, strictly ordered:
+               "chg-done",
+               "chg-fast",
+               "chg-trkl",
+               "bat-temp-ok",
+               "bat-present",
+               "chg-gone",
+               "usb-valid",
+               "dc-valid"
+
+- qcom,fast-charge-current-limit:
+  Usage: optional (default: 1A, or pre-configured value)
+  Value type: <u32>; uA; range [100mA : 3A]
+  Description: Maximum charge current; May be clamped to safety limits.
+
+- qcom,fast-charge-low-threshold-voltage:
+  Usage: optional (default: 3.2V, or pre-configured value)
+  Value type: <u32>; uV; range [2.1V : 3.6V]
+  Description: Battery voltage limit above which fast charging may operate;
+               Below this value linear or switch-mode auto-trickle-charging
+               will operate.
+
+- qcom,fast-charge-high-threshold-voltage:
+  Usage: optional (default: 4.2V, or pre-configured value)
+  Value type: <u32>; uV; range [3.24V : 5V]
+  Description: Battery voltage limit below which fast charging may operate;
+               The fast charger will attempt to charge the battery to this
+               voltage.  May be clamped to safety limits.
+
+- qcom,fast-charge-safe-voltage:
+  Usage: optional (default: 4.2V, or pre-configured value)
+  Value type: <u32>; uV; range [3.24V : 5V]
+  Description: Maximum safe battery voltage; May be pre-set by bootloader, in
+               which case, setting this will harmlessly fail. The property
+               'fast-charge-high-watermark' will be clamped by this value.
+
+- qcom,fast-charge-safe-current:
+  Usage: optional (default: 1A, or pre-configured value)
+  Value type: <u32>; uA; range [100mA : 3A]
+  Description: Maximum safe battery charge current; May pre-set by bootloader,
+               in which case, setting this will harmlessly fail. The property
+               'qcom,fast-charge-current-limit' will be clamped by this value.
+
+- qcom,auto-recharge-threshold-voltage:
+  Usage: optional (default: 4.1V, or pre-configured value)
+  Value type: <u32>; uV; range [3.24V : 5V]
+  Description: Battery voltage limit below which auto-recharge functionality
+               will restart charging after end-of-charge;  The high cutoff
+               limit for auto-recharge is 5% above this value.
+
+- qcom,minimum-input-voltage:
+  Usage: optional (default: 4.3V, or pre-configured value)
+  Value type: <u32>; uV; range [4.2V : 9.6V]
+  Description: Input voltage level above which charging may operate
+
+- qcom,dc-current-limit:
+  Usage: optional (default: 100mA, or pre-configured value)
+  Value type: <u32>; uA; range [100mA : 2.5A]
+  Description: Default DC charge current limit
+
+- qcom,disable-dc:
+  Usage: optional (default: false)
+  Value type: boolean: <u32> or <empty>
+  Description: Disable DC charger
+
+- qcom,jeita-extended-temp-range:
+  Usage: optional (default: false)
+  Value type: boolean: <u32> or <empty>
+  Description: Enable JEITA extended temperature range;  This does *not*
+               adjust the maximum charge voltage or current in the extended
+               temperature range.  It only allows charging when the battery
+               is in the extended temperature range.  Voltage/current
+               regulation must be done externally to fully comply with
+               the JEITA safety guidelines if this flag is set.
+
+EXAMPLE
+charger@1000 {
+       compatible = "qcom,pm8941-charger";
+       reg = <0x1000 0x700>;
+       interrupts = <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x10 4 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
+                       <0x0 0x14 1 IRQ_TYPE_EDGE_BOTH>;
+       interrupt-names = "chg-done",
+                       "chg-fast",
+                       "chg-trkl",
+                       "bat-temp-ok",
+                       "bat-present",
+                       "chg-gone",
+                       "usb-valid",
+                       "dc-valid";
+
+       qcom,fast-charge-current-limit = <1000000>;
+       qcom,dc-charge-current-limit = <1000000>;
+};
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 5/8] dt-bindings: introduce cpu power domain bindings for Qualcomm SoCs
Date: Thu, 11 Oct 2018 02:50:52 +0530
Message-ID: <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's cpu
domain driver. The driver is used for managing system sleep activities
that are required when application processor is going to deepest low
power mode.

Cc: devicetree@vger.kernel.org
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 .../bindings/soc/qcom/cpu_power_domain.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
new file mode 100644
index 0000000..1c8fe69
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
@@ -0,0 +1,39 @@
+Qualcomm Technologies cpu power domain
+-----------------------------------------
+
+CPU power domain handles the tasks that need to be performed during
+application processor deeper low power mode entry for QCOM SoCs which
+have hardened IP blocks combinedly called as RPMH (Resource Power Manager
+Hardened) for shared resource management. Flushing the buffered requests
+to TCS (Triggered Command Set) in RSC (Resource State Coordinator) and
+programming the wakeup timer in PDC (Power Domain Controller) for timer
+based wakeup are handled as part of domain power down.
+
+The bindings for cpu power domain is specified in the RSC section in
+devicetree.
+
+Properties:
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,cpu-pm-domain".
+
+- #power-domain-cells: number of cells in power domain specifier;
+    must be 0.
+
+Node of a device using power domains must have a power-domains property
+defined with a phandle to respective power domain.
+
+Example:
+
+	apps_rsc: rsc@179c0000 {
+		[...]
+		cpu_pd: power-domain-controller {
+			compatible = "qcom,cpu-pm-domain";
+			#power-domain-cells = <0>;
+		};
+	};
+
+
+See Documentation/devicetree/bindings/power/power_domain.txt for description
+of consumer-side bindings.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

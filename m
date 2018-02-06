From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v6 10/15] dt-bindings: arm: Document qcom,kpss-gcc
Date: Tue,  6 Feb 2018 09:38:23 +0530
Message-ID: <1517890108-8140-11-git-send-email-sricharan@codeaurora.org>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org, robh@kernel.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The ACC and GCC regions present in KPSSv1 contain registers to
control clocks and power to each Krait CPU and L2. Documenting
the bindings here.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  7 +++++
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 32 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
index 1333db9..382a574 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
@@ -21,10 +21,17 @@ PROPERTIES
 		    the register region. An optional second element specifies
 		    the base address and size of the alias register region.
 
+- clock-output-names:
+	Usage: optional
+	Value type: <string>
+	Definition: Name of the output clock. Typically acpuX_aux where X is a
+		    CPU number starting at 0.
+
 Example:
 
 	clock-controller@2088000 {
 		compatible = "qcom,kpss-acc-v2";
 		reg = <0x02088000 0x1000>,
 		      <0x02008000 0x1000>;
+		clock-output-names = "acpu0_aux";
 	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
new file mode 100644
index 0000000..37fc0a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
@@ -0,0 +1,32 @@
+Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: should be one of the following. The generic compatible
+			"qcom,kpss-gcc" should also be included.
+			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
+			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of the register region
+
+- clock-output-names:
+	Usage: required
+	Value type: <string>
+	Definition: Name of the output clock. Typically acpu_l2_aux indicating
+		    an L2 cache auxiliary clock.
+
+Example:
+
+	l2cc: clock-controller@2011000 {
+		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
+		reg = <0x2011000 0x1000>;
+		clock-output-names = "acpu_l2_aux";
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

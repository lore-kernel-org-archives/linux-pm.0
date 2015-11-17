From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v5 1/3] devicetree: bindings: Add optional dynamic-power-coefficient property
Date: Tue, 17 Nov 2015 12:06:21 +0000
Message-ID: <1447761983-12415-2-git-send-email-punit.agrawal@arm.com>
References: <1447761983-12415-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447761983-12415-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, javi.merino@arm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

The dynamic power consumption of a device is proportional to the
square of voltage (V) and the clock frequency (f). It can be expressed as

Pdyn = dynamic-power-coefficient * V^2 * f.

The coefficient represents the running time dynamic power consumption in
units of mw/MHz/uVolt^2 and can be used in the above formula to
calculate the dynamic power in mW.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3a07a87..6aca64f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -242,6 +242,23 @@ nodes to be present and contain the properties described below.
 		Definition: Specifies the syscon node controlling the cpu core
 			    power domains.
 
+	- dynamic-power-coefficient
+		Usage: optional
+		Value type: <prop-encoded-array>
+		Definition: A u32 value that represents the running time dynamic
+			    power coefficient in units of mW/MHz/uVolt^2. The
+			    coefficient can either be calculated from power
+			    measurements or derived by analysis.
+
+			    The dynamic power consumption of the CPU  is
+			    proportional to the square of the Voltage (V) and
+			    the clock frequency (f). The coefficient is used to
+			    calculate the dynamic power as below -
+
+			    Pdyn = dynamic-power-coefficient * V^2 * f
+
+			    where voltage is in uV, frequency is in MHz.
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
-- 
2.6.2

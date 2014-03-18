From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v5 2/3] Documentation: arm: add cache DT bindings
Date: Tue, 18 Mar 2014 11:28:51 +0000
Message-ID: <1395142132-20788-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Capella <sebastian.capella@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dave Martin <dave.martin@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>Mark
List-Id: linux-pm@vger.kernel.org

On ARM systems the cache topology cannot be probed at runtime, in
particular, it is impossible to probe which CPUs share a given cache
level. Power management software requires this knowledge to implement
optimized power down sequences, hence this patch adds a document that
defines the DT cache bindings for ARM systems. The bindings supersede
cache bindings in the ePAPR (PowerPC bindings), because caches geometry for
architected caches is probeable on ARM systems. This patch also adds
properties that are specific to ARM architected caches to the existing ones
defined in the ePAPR v1.1, as bindings extensions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/cache.txt | 166 ++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

diff --git a/Documentation/devicetree/bindings/arm/cache.txt b/Documentation/devicetree/bindings/arm/cache.txt
new file mode 100644
index 0000000..b90fcc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cache.txt
@@ -0,0 +1,166 @@
+==========================================
+ARM processors cache binding description
+==========================================
+
+Device tree bindings for cache nodes are already part of the ePAPR standard
+v1.1 ([2]) for PowerPC platforms. This document defines the cache bindings
+for caches on ARM processor systems.
+
+On ARM based systems most of the cache properties related to cache geometry
+are probeable in HW (please refer to the processor TRMs in [1] for register
+details), hence, unless otherwise stated, the properties defined in ePAPR for
+internal, multi-level and shared caches ([2], 3.7.3, 3.8) are to be considered
+superseded on ARM.
+
+On ARM, caches are either architected (directly controlled by the processor
+through coprocessor instructions and tightly coupled with the processor
+implementation) or unarchitected (controlled through a memory mapped
+interface, implemented as a stand-alone IP external to the processor
+implementation).
+
+This document provides the device tree bindings for ARM architected caches.
+
+- ARM architected cache node
+
+	Description: must be a direct child of the cpu node.
+		     A system can contain multiple architected cache nodes
+		     per cpu node, linked through the next-level-cache phandle.
+		     The next-level-cache property in the cpu node points to
+		     the first level of architected cache for the CPU.
+		     The next-level-cache links ordering must represent the
+		     system cache hierarchy in the system, with the upper
+		     cache level represented by a cache node with a missing
+		     next-level-cache property.
+
+	ARM architected cache node defines the following properties:
+
+	- compatible
+		Usage: Required
+		Value type: <string>
+		Definition: value shall be "arm,arch-cache".
+
+	- power-domain
+		Usage: Optional
+		Value type: <prop-encoded-array>
+		Definition: A phandle and power domain specifier as defined by
+			    bindings of power domain specified by [3].
+
+Example(dual-cluster big.LITTLE system 32-bit)
+
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			next-level-cache = <&L1_0>;
+
+			L1_0: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+
+			L2_0: l2-cache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			next-level-cache = <&L1_1>;
+
+			L1_1: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x2>;
+			next-level-cache = <&L1_2>;
+
+			L1_2: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x3>;
+			next-level-cache = <&L1_3>;
+
+			L1_3: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_0>;
+			};
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			next-level-cache = <&L1_4>;
+
+			L1_4: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+
+			L2_1: l2-cache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			next-level-cache = <&L1_5>;
+
+			L1_5: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+		};
+
+		cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			next-level-cache = <&L1_6>;
+
+			L1_6: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+		};
+
+		cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			next-level-cache = <&L1_7>;
+
+			L1_7: l1-cache {
+				compatible = "arm,arch-cache";
+				next-level-cache = <&L2_1>;
+			};
+		};
+	};
+
+[1] ARM Architecture Reference Manuals
+    http://infocenter.arm.com/help/index.jsp
+
+[2] ePAPR standard
+    https://www.power.org/documentation/epapr-version-1-1/
+
+[3] Kernel documentation - power domain bindings
+    Documentation/devicetree/bindings/power/power_domain.txt
-- 
1.8.4

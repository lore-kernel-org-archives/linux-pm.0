From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 6/6] arm64: boot: dts: update rtsm aemv8 dts with PSCI
 and idle states
Date: Tue,  6 May 2014 19:04:43 +0100
Message-ID: <1399399483-17112-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Nicolas Pitre <nico@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sebastian Capella <sebastian.capella@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Antti Miettinen <ananaza@iki.fi>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>
List-Id: linux-pm@vger.kernel.org

This patch updates the RTSM dts file with PSCI bindings and nodes
describing the AEMv8 model idle states parameters.

PSCI function IDs compliancy with PSCI v0.2 is still under development
so this patch provides PSCI function IDs for demonstration purposes only.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 49 ++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
index d79de9c..fd23737 100644
--- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
@@ -27,37 +27,70 @@
 		serial3 = &v2m_serial3;
 	};
 
+	psci {
+		compatible = "arm,psci";
+		method = "smc";
+		/*
+		 * Function IDs usage and compliancy with PSCI v0.2 still
+		 * under discussion.  Current IDs should be considered
+		 * temporary for demonstration purposes.
+		 */
+		cpu_suspend = <0x84000001>;
+		cpu_off = <0x84000002>;
+		cpu_on = <0x84000003>;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				entry-method-param = <0x0010000>;
+				entry-latency-us = <40>;
+				exit-latency-us = <100>;
+				min-residency-us = <150>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				entry-method-param = <0x1010000>;
+				entry-latency-us = <500>;
+				exit-latency-us = <1000>;
+				min-residency-us = <2500>;
+			};
+		};
+
 		cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x1>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x2>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,armv8";
 			reg = <0x0 0x3>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0x8000fff8>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 	};
 
-- 
1.8.4

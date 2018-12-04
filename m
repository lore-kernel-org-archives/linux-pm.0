From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state support
 on Armada 7K/8K"
Date: Tue,  4 Dec 2018 17:46:02 +0200
Message-ID: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, orenbh <orenbh@marvell.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Sergey Matyukevich <geomatsi@gmail.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>
List-Id: linux-pm@vger.kernel.org

This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.

This commit breaks boot on Armada 8K based systems. Reverting it makes
affected systems boot again.

Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 -------------------
 2 files changed, 31 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 64632c873888..01ea662afba8 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -20,28 +20,24 @@
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x001>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0x101>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 073610ac0a53..7d94c1fa592a 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -28,33 +28,6 @@
 		method = "smc";
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle_states {
-			entry_method = "arm,pcsi";
-
-			CPU_SLEEP_0: cpu-sleep-0 {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x0010000>;
-				entry-latency-us = <80>;
-				exit-latency-us  = <160>;
-				min-residency-us = <320>;
-			};
-
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x1010000>;
-				entry-latency-us = <500>;
-				exit-latency-us = <1000>;
-				min-residency-us = <2500>;
-			};
-		};
-	};
-
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.19.2

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/10] ARM: dts: mt7623: Remove "cooling-{min|max}-level" for
 CPU nodes
Date: Fri,  9 Feb 2018 14:28:03 +0530
Message-ID: <33d7494641d2f89c827e5e09d1143f125c33e784.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-mediatek@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
a CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused properties from the CPU nodes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 4 ----
 arch/arm/boot/dts/mt7623.dtsi                                  | 2 --
 2 files changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index f6403089edcf..d36f07e0a2bb 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -21,8 +21,6 @@ Binding for MediaTek's CPUFreq driver
 	       flow is handled by hardware, hence no software "voltage tracking" is
 	       needed.
 - #cooling-cells:
-- cooling-min-level:
-- cooling-max-level:
 	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt
 	for detail.
 
@@ -67,8 +65,6 @@ Binding for MediaTek's CPUFreq driver
 		clock-names = "cpu", "intermediate";
 		operating-points-v2 = <&cpu_opp_table>;
 		#cooling-cells = <2>;
-		cooling-min-level = <0>;
-		cooling-max-level = <7>;
 	};
 	cpu@1 {
 		device_type = "cpu";
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b750da5362f7..8e7c65464c9d 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -87,8 +87,6 @@
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
-			cooling-min-level = <0>;
-			cooling-max-level = <7>;
 			clock-frequency = <1300000000>;
 		};
 
-- 
2.15.0.194.g9af6a3dea062

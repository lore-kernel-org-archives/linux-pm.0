From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V2 4/4] dts: Add cpufreq controller node for Exynos5440 SoC
Date: Sat,  2 Mar 2013 15:04:14 +0530
Message-ID: <1362216854-6633-4-git-send-email-amit.daniel@samsung.com>
References: <1362216854-6633-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362216854-6633-1-git-send-email-amit.daniel@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Inderpal Singh <inderpal.singh@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add cpufreq controller device node for Exynos5440 SoC for passing
parameters like controller base address, interrupt and cpufreq
table. This node is added inside cpu0 node as done in other cpufreq
drivers.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5f3562a..fd0c811 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -31,6 +31,19 @@
 				interrupts = <1 13 0xf08>;
 				clock-frequency = <1000000>;
 			};
+
+			cpufreq@160000 {
+				compatible = "samsung,exynos5440-cpufreq";
+				reg = <0x160000 0x1000>;
+				interrupts = <0 57 0>;
+				operating-points = <
+					/* KHZ	  uV */
+					1200000 1025000
+					1000000 975000
+					800000  925000
+					>;
+				clocks = <&clock 2>;
+			};
 		};
 		cpu@1 {
 			compatible = "arm,cortex-a15";
-- 
1.7.1

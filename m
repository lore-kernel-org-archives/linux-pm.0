From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] arm64: dts: hi6220: Add all CPUs in cooling maps
Date: Thu,  5 Jul 2018 10:39:24 +0530
Message-ID: <fd741a8140809406ce86c479bbf6f03319490a64.1530766981.git.viresh.kumar@linaro.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org, Wei Xu <xuwei5@hisilicon.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures the CPU0 in the cooling maps. Things work by chance as
under normal circumstances its the CPU0 which is used by the operating
systems to probe the cooling devices. But as soon as that ordering
changes and any other CPU is used to bring up the cooling device, we
will start seeing errors.

On the other hand, the hardware is partially defined in DT in these
cases and we must do a better job by capturing all devices.

Add all devices (CPUs here) in the cooling maps which are also affected
by the trip point.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 247024df714f..919d36b91bf3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -886,7 +886,14 @@
 				cooling-maps {
 					map0 {
 						trip = <&target>;
-						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					};
 				};
 			};
-- 
2.18.0.rc1.242.g61856ae69a2c

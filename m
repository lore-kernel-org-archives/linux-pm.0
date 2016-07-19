From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v6 3/8] arm, dts: add TC2 cpu capacity-dmips-mhz information
Date: Tue, 19 Jul 2016 13:40:43 +0100
Message-ID: <1468932048-31635-4-git-send-email-juri.lelli@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, Liviu Dudau <liviu.dudau@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add TC2 cpu capacity binding information.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

Changes from v1:
  - capacity-scale removed

Changes from v4:
  - binding changed to capacity-dmips-mhz
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 0205c97efdef..45d08cc37b01 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -39,6 +39,7 @@
 			reg = <0>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu1: cpu@1 {
@@ -47,6 +48,7 @@
 			reg = <1>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		cpu2: cpu@2 {
@@ -55,6 +57,7 @@
 			reg = <0x100>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity-dmips-mhz = <516>;
 		};
 
 		cpu3: cpu@3 {
@@ -63,6 +66,7 @@
 			reg = <0x101>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity-dmips-mhz = <516>;
 		};
 
 		cpu4: cpu@4 {
@@ -71,6 +75,7 @@
 			reg = <0x102>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			capacity-dmips-mhz = <516>;
 		};
 
 		idle-states {
-- 
2.7.0

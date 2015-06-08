From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 7/8] arm64: dts: add CPU topology on Juno
Date: Mon,  8 Jun 2015 11:40:01 +0100
Message-ID: <1433760002-24120-8-git-send-email-sudeep.holla@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

This patch adds CPU topology on Juno. It will be useful for ther other
IP blocks depending on this topology.

Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 26 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts    | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index c62751153a4f..69130840c6cd 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -34,6 +34,32 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A57_0>;
+				};
+				core1 {
+					cpu = <&A57_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+		};
+
 		A57_0: cpu@0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index d7cbdd482a61..ce1128a54c8d 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -34,6 +34,32 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&A57_0>;
+				};
+				core1 {
+					cpu = <&A57_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&A53_0>;
+				};
+				core1 {
+					cpu = <&A53_1>;
+				};
+				core2 {
+					cpu = <&A53_2>;
+				};
+				core3 {
+					cpu = <&A53_3>;
+				};
+			};
+		};
+
 		A57_0: cpu@0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
-- 
1.9.1

From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 8/8] arm64: dts: add clock support for all the cpus
Date: Mon,  8 Jun 2015 11:40:02 +0100
Message-ID: <1433760002-24120-9-git-send-email-sudeep.holla@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48113 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbbFHKkh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Jun 2015 06:40:37 -0400
In-Reply-To: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>

This patch adds the CPU clocks so that the CPU DVFS can be enabled.

Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 6 ++++++
 arch/arm64/boot/dts/arm/juno.dts    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 69130840c6cd..5eef4aa0c532 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -66,6 +66,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		A57_1: cpu@1 {
@@ -74,6 +75,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		A53_0: cpu@100 {
@@ -82,6 +84,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A53_1: cpu@101 {
@@ -90,6 +93,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A53_2: cpu@102 {
@@ -98,6 +102,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A53_3: cpu@103 {
@@ -106,6 +111,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A57_L2: l2-cache0 {
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index ce1128a54c8d..c02f880584e8 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -66,6 +66,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		A57_1: cpu@1 {
@@ -74,6 +75,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
+			clocks = <&scpi_dvfs 0>;
 		};
 
 		A53_0: cpu@100 {
@@ -82,6 +84,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A53_1: cpu@101 {
@@ -90,6 +93,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A53_2: cpu@102 {
@@ -98,6 +102,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A53_3: cpu@103 {
@@ -106,6 +111,7 @@
 			device_type = "cpu";
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		A57_L2: l2-cache0 {
-- 
1.9.1


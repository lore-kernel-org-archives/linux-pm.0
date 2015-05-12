From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 03/34] arm: vexpress: Add CPU clock-frequencies to TC2 device-tree
Date: Tue, 12 May 2015 20:38:38 +0100
Message-ID: <1431459549-18343-4-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33745 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933488AbbELThy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 15:37:54 -0400
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

To enable the parsing of clock frequency and cpu efficiency values
inside parse_dt_topology [arch/arm/kernel/topology.c] to scale the
relative capacity of the cpus, this property has to be provided within
the cpu nodes of the dts file.

The patch is a copy of commit 8f15973ef8c3 ("ARM: vexpress: Add CPU
clock-frequencies to TC2 device-tree") taken from Linaro Stable Kernel
(LSK) massaged into mainline.

Cc: Jon Medhurst <tixy@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 7a2aeac..76613b2 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -39,6 +39,7 @@
 			reg = <0>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			clock-frequency = <1000000000>;
 		};
 
 		cpu1: cpu@1 {
@@ -47,6 +48,7 @@
 			reg = <1>;
 			cci-control-port = <&cci_control1>;
 			cpu-idle-states = <&CLUSTER_SLEEP_BIG>;
+			clock-frequency = <1000000000>;
 		};
 
 		cpu2: cpu@2 {
@@ -55,6 +57,7 @@
 			reg = <0x100>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			clock-frequency = <800000000>;
 		};
 
 		cpu3: cpu@3 {
@@ -63,6 +66,7 @@
 			reg = <0x101>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			clock-frequency = <800000000>;
 		};
 
 		cpu4: cpu@4 {
@@ -71,6 +75,7 @@
 			reg = <0x102>;
 			cci-control-port = <&cci_control2>;
 			cpu-idle-states = <&CLUSTER_SLEEP_LITTLE>;
+			clock-frequency = <800000000>;
 		};
 
 		idle-states {
-- 
1.9.1


From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v7 5/8] arm64, dts: add Juno cpu capacity-dmips-mhz information
Date: Mon,  5 Sep 2016 15:22:49 +0100
Message-ID: <1473085372-2840-6-git-send-email-juri.lelli@arm.com>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, Jon Medhurst <tixy@linaro.org>, peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, juri.lelli@arm.com, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, Kumar Gala <galak@codeaurora.org>, broonie@kernel.org, linux@arm.linux.org.uk, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>, sudeep.holla@arm.com, Olof Johansson <olof@lixom.net>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-pm@vger.kernel.org

Add Juno cpu capacity-dmips-mhz information.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

Changes from v1:
  - capacity-scale removed

Changes from v4:
  - binding changed to capacity-dmips-mhz

Changes from v6:
  - s/bindings// in changelog
---
 arch/arm64/boot/dts/arm/juno.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index a7270eff6939..6b4135e9cfe5 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -90,6 +90,7 @@
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		A57_1: cpu@1 {
@@ -100,6 +101,7 @@
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		A53_0: cpu@100 {
@@ -110,6 +112,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		A53_1: cpu@101 {
@@ -120,6 +123,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		A53_2: cpu@102 {
@@ -130,6 +134,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		A53_3: cpu@103 {
@@ -140,6 +145,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			capacity-dmips-mhz = <578>;
 		};
 
 		A57_L2: l2-cache0 {
-- 
2.7.0

From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v4 1/8] Documentation: arm: fix wrong reference number in DT definition
Date: Thu, 20 Apr 2017 15:43:09 +0100
Message-ID: <20170420144316.15632-2-juri.lelli@arm.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170420144316.15632-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

Reference to cpu capacity binding has a wrong number. Fix it.

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 698ad1f097fa..83ec3fa0a05e 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -248,7 +248,7 @@ nodes to be present and contain the properties described below.
 		Usage: Optional
 		Value type: <u32>
 		Definition:
-			# u32 value representing CPU capacity [3] in
+			# u32 value representing CPU capacity [4] in
 			  DMIPS/MHz, relative to highest capacity-dmips-mhz
 			  in the system.
 
@@ -475,5 +475,5 @@ cpus {
 [2] arm/msm/qcom,kpss-acc.txt
 [3] ARM Linux kernel documentation - idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
-[3] ARM Linux kernel documentation - cpu capacity bindings
+[4] ARM Linux kernel documentation - cpu capacity bindings
     Documentation/devicetree/bindings/arm/cpu-capacity.txt
-- 
2.10.0

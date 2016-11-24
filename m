From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 01/10] PM / OPP: Fix incorrect cpu-supply property in binding
Date: Thu, 24 Nov 2016 17:06:10 +0530
Message-ID: <85323242b2d1a1b489283fea8892c915510a2a61.1479986491.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479986491.git.viresh.kumar@linaro.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The regulator bindings allow the "<name>-supply" property to define a
single parent supply and not a list of parents.

Fix the wrong example code present in OPP bindings.

While at it also change the compatible string as Rob pointed out earlier
that none of A7 implementation have multiple supplies for the CPU core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index ee91cbdd95ee..f0239f68d186 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -386,10 +386,12 @@ Example 4: Handling multiple regulators
 / {
 	cpus {
 		cpu@0 {
-			compatible = "arm,cortex-a7";
+			compatible = "vendor,cpu-type";
 			...
 
-			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
+			vcc0-supply = <&cpu_supply0>;
+			vcc1-supply = <&cpu_supply1>;
+			vcc2-supply = <&cpu_supply2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
-- 
2.7.1.410.g6faf27b

From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 03/11] dt-bindings: thermal: Fix a typo in documentation
Date: Tue, 28 Aug 2018 19:08:32 +0530
Message-ID: <8480b996596184a478fe74dfdb97ead7dba6fb11.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

c(1) + x(1) was actually meant to be c(1) * x(1).

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index eb7ee91556a5..ca14ba959e0d 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -152,7 +152,7 @@ Optional property:
   Elem size: one cell	the sensors listed in the thermal-sensors property.
   Elem type: signed	Coefficients defaults to 1, in case this property
 			is not specified. A simple linear polynomial is used:
-			Z = c0 * x0 + c1 + x1 + ... + c(n-1) * x(n-1) + cn.
+			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
 
 			The coefficients are ordered and they match with sensors
 			by means of sensor ID. Additional coefficients are
-- 
2.17.1

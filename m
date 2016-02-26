From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/5] thermal: change "hysteresis" as optional property
Date: Fri, 26 Feb 2016 11:43:43 +0800
Message-ID: <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

The property "hysteresis" is mandatory for trip points, so if without
it the thermal zone cannot register successfully. But "hysteresis" is
ignored in the thermal subsystem and only inquired by several thermal
sensor drivers.

So change "hysteresis" as optional properties.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 9 +++++----
 drivers/thermal/of-thermal.c                          | 9 ++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 41b817f..7d79e77 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -89,10 +89,6 @@ Required properties:
   Type: signed		in millicelsius.
   Size: one cell
 
-- hysteresis:		A low hysteresis value on temperature property (above).
-  Type: unsigned	This is a relative value, in millicelsius.
-  Size: one cell
-
 - type:			a string containing the trip type. Expected values are:
 	"active":	A trip point to enable active cooling
 	"passive":	A trip point to enable passive cooling
@@ -100,6 +96,11 @@ Required properties:
 	"critical":	Hardware not reliable.
   Type: string
 
+Optional properties:
+- hysteresis:		A low hysteresis value on temperature property (above).
+  Type: unsigned	This is a relative value, in millicelsius.
+  Size: one cell
+
 * Cooling device maps
 
 The cooling device maps node is a node to describe how cooling devices
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 9043f8f..ab05500 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -689,11 +689,10 @@ static int thermal_of_populate_trip(struct device_node *np,
 	trip->temperature = prop;
 
 	ret = of_property_read_u32(np, "hysteresis", &prop);
-	if (ret < 0) {
-		pr_err("missing hysteresis property\n");
-		return ret;
-	}
-	trip->hysteresis = prop;
+	if (ret < 0)
+		pr_warning("missing hysteresis property\n");
+	else
+		trip->hysteresis = prop;
 
 	ret = thermal_of_get_trip_type(np, &trip->type);
 	if (ret < 0) {
-- 
1.9.1

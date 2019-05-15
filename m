From: Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] dt-bindings: thermal: Make cooling-maps property optional
Date: Wed, 15 May 2019 17:36:47 +0800
Message-ID: <20190515093647.47656-1-andy.tang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: robh+dt@kernel.org, daniel.lezcano@linaro.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

There may be no cooling device on system, or there are no enough
cooling devices for each thermal zone in multiple thermal zone
cases since cooling devices can't be shared.
So make this property optional to remove such limitations.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 .../devicetree/bindings/thermal/thermal.txt        |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index ca14ba9..694e834 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -142,11 +142,11 @@ Required properties:
 - trips:		A sub-node which is a container of only trip point nodes
   Type: sub-node	required to describe the thermal zone.
 
+
+Optional property:
 - cooling-maps:		A sub-node which is a container of only cooling device
   Type: sub-node	map nodes, used to describe the relation between trips
 			and cooling devices.
-
-Optional property:
 - coefficients:		An array of integers (one signed cell) containing
   Type: array		coefficients to compose a linear relation between
   Elem size: one cell	the sensors listed in the thermal-sensors property.
-- 
1.7.1

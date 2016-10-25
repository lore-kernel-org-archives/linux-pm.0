From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use correct compatibles
Date: Tue, 25 Oct 2016 08:26:38 -0700
Message-ID: <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477409199-52182-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brendan.jackman-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Juri.Lelli-5wv7dgnIgG8@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Update domain-idle-state binding to use "domain-idle-state" compatible
from Documentation/devicetree/bindings/arm/idle-states.txt.

Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Suggested-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index e165036..6fb53a3 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -30,8 +30,9 @@ Optional properties:
    available in the next section.
 
 - domain-idle-states : A phandle of an idle-state that shall be soaked into a
-                generic domain power state. The idle state definitions are
-                compatible with arm,idle-state specified in [1].
+                generic domain power state. The idle state definitions must be
+                compatible with "domain-idle-state" as well as
+                "arm,idle-state" as defined in [1].
   The domain-idle-state property reflects the idle state of this PM domain and
   not the idle states of the devices or sub-domains in the PM domain. Devices
   and sub-domains have their own idle-states independent of the parent
@@ -85,7 +86,7 @@ Example 3:
 	};
 
 	DOMAIN_RET: state@0 {
-		compatible = "arm,idle-state";
+		compatible = "domain-idle-state", "arm,idle-state";
 		reg = <0x0>;
 		entry-latency-us = <1000>;
 		exit-latency-us = <2000>;
@@ -93,7 +94,7 @@ Example 3:
 	};
 
 	DOMAIN_PWR_DN: state@1 {
-		compatible = "arm,idle-state";
+		compatible = "domain-idle-state", "arm,idle-state";
 		reg = <0x1>;
 		entry-latency-us = <5000>;
 		exit-latency-us = <8000>;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

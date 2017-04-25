From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] PM / Domains: Fix DT example
Date: Tue, 25 Apr 2017 12:48:21 +0530
Message-ID: <533b52e0ea175bf6bb893370c7f8c0309aae235a.1493104411.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The power-domain provider's #power-domain-cells field is set to 0 and
yet the children is using an index to point the power domain. Fix it by
removing the index field.

Fixes: 70bb510e4279 ("dt/bindings / PM/Domains: Update binding for PM domain idle states")
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 940707d095cc..14bd9e945ff6 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -81,7 +81,7 @@ domain provided by the 'parent' power controller.
 	child: power-controller@12341000 {
 		compatible = "foo,power-controller";
 		reg = <0x12341000 0x1000>;
-		power-domains = <&parent 0>;
+		power-domains = <&parent>;
 		#power-domain-cells = <0>;
 		domain-idle-states = <&DOMAIN_PWR_DN>;
 	};
-- 
2.12.0.432.g71c3a4f4ba37

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

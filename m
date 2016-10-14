From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 5/8] dt/bindings: Update binding for PM domain idle states
Date: Fri, 14 Oct 2016 10:47:53 -0700
Message-ID: <1476467276-75094-6-git-send-email-lina.iyer@linaro.org>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476467276-75094-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brendan.jackman-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Juri.Lelli-5wv7dgnIgG8@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Update DT bindings to describe idle states of PM domains.

This patch is based on the original patch by Marc Titinger.

Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..e165036 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,15 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state. The idle state definitions are
+                compatible with arm,idle-state specified in [1].
+  The domain-idle-state property reflects the idle state of this PM domain and
+  not the idle states of the devices or sub-domains in the PM domain. Devices
+  and sub-domains have their own idle-states independent of the parent
+  domain's idle states. In the absence of this property, the domain would be
+  considered as capable of being powered-on or powered-off.
+
 Example:
 
 	power: power-controller@12340000 {
@@ -59,6 +68,38 @@ The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
 
+Example 3:
+	parent: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		domain-idle-states = <&DOMAIN_RET>, <&DOMAIN_PWR_DN>;
+	};
+
+	child: power-controller@12341000 {
+		compatible = "foo,power-controller";
+		reg = <0x12341000 0x1000>;
+		power-domains = <&parent 0>;
+		#power-domain-cells = <0>;
+		domain-idle-states = <&DOMAIN_PWR_DN>;
+	};
+
+	DOMAIN_RET: state@0 {
+		compatible = "arm,idle-state";
+		reg = <0x0>;
+		entry-latency-us = <1000>;
+		exit-latency-us = <2000>;
+		min-residency-us = <10000>;
+	};
+
+	DOMAIN_PWR_DN: state@1 {
+		compatible = "arm,idle-state";
+		reg = <0x1>;
+		entry-latency-us = <5000>;
+		exit-latency-us = <8000>;
+		min-residency-us = <7000>;
+	};
+
 ==PM domain consumers==
 
 Required properties:
@@ -76,3 +117,5 @@ Example:
 The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

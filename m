From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC v6 7/7] PM / Domains: R-Mobile SYSC: Add PM QoS device latencies
Date: Mon, 27 Apr 2015 14:43:42 +0200
Message-ID: <1430138622-14029-8-git-send-email-geert+renesas@glider.be>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add optional generic PM QoS device latency properties to the bindings
and example.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC,

v4:
  - New.
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index 0a6f03a136792e84..e54ee193c9f8e263 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -95,7 +95,8 @@ which is a subdomain of A4S.
 == PM Domain Consumers ==
 
 Hardware blocks belonging to a PM domain should contain a "power-domains"
-property that is a phandle pointing to the corresponding PM domain node.
+property that is a phandle pointing to the corresponding PM domain node,
+and optional PM QoS device latencies:
 
 Example:
 
@@ -104,5 +105,7 @@ Example:
 		reg = <0xe6600000 0x100>;
 		clocks = <&mstp3_clks R8A7740_CLK_TPU0>;
 		power-domains = <&pd_a3sp>;
+		stop-latency = <250000>;
+		start-latency = <250000>;
 		#pwm-cells = <3>;
 	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

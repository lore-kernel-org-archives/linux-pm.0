From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v6 2/7] PM / Domains: R-Mobile SYSC: Add PM domain power-on/off latencies
Date: Mon, 27 Apr 2015 14:43:37 +0200
Message-ID: <1430138622-14029-3-git-send-email-geert+renesas@glider.be>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:37477 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbbD0Mnx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 08:43:53 -0400
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add optional generic PM domain power-on/off latencies to the bindings
and example.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC.
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index beda7d2efc304350..0a6f03a136792e84 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -45,6 +45,8 @@ Optional properties:
 	 - #address-cells: Must be 1,
 	 - #size-cells: Must be 0.
        If the PM domain is always-on, this property must be omitted.
+- power-on-latency: Power-on latency of the PM domain, in ns,
+- power-off-latency: Power-off latency of the PM domain, in ns.
 
 
 Example:
@@ -68,16 +70,22 @@ which is a subdomain of A4S.
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 
 					pd_a3sp: a3sp@11 {
 						reg = <11>;
 						#power-domain-cells = <0>;
+						power-on-latency = <250000>;
+						power-off-latency = <250000>;
 					};
 				};
 
 				pd_a4su: a4su@20 {
 					reg = <20>;
 					#power-domain-cells = <0>;
+					power-on-latency = <250000>;
+					power-off-latency = <250000>;
 				};
 			};
 		};
-- 
1.9.1


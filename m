From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] PM / Domains: Correct unit address in power-controller example
Date: Mon,  4 May 2015 16:13:24 +0200
Message-ID: <1430748804-7586-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:48890 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbbEDONd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 10:13:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

In example 2 of the generic PM domains DT bindings, the unit address of
the device node representing the child power controller doesn't match
its "reg" property. Correct it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
v2:
  - Add Acked-by
---
 Documentation/devicetree/bindings/power/power_domain.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index d6505bef655dc2df..32d1d3a399fe2a48 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -56,7 +56,7 @@ Example 2:
 		#power-domain-cells = <1>;
 	};
 
-	child: power-controller@12340000 {
+	child: power-controller@12341000 {
 		compatible = "foo,power-controller";
 		reg = <0x12341000 0x1000>;
 		power-domains = <&parent 0>;
-- 
1.9.1


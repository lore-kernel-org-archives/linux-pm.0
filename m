From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / Domains: Correct unit address in power-controller example
Date: Mon, 16 Mar 2015 15:47:12 +0100
Message-ID: <1426517232-2592-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:39263 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbbCPOrP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 10:47:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

In example 2 of the generic PM domains DT bindings, the unit address of
the device node representing the child power controller doesn't match
its "reg" property. Correct it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 0f8ed3710c66e9e2..025b5e7df61c630c 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -48,7 +48,7 @@ Example 2:
 		#power-domain-cells = <1>;
 	};
 
-	child: power-controller@12340000 {
+	child: power-controller@12341000 {
 		compatible = "foo,power-controller";
 		reg = <0x12341000 0x1000>;
 		power-domains = <&parent 0>;
-- 
1.9.1


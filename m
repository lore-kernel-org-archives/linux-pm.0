From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Define DT bindings for PM QoS device latencies
Date: Thu, 31 Mar 2016 15:50:25 +0200
Message-ID: <1459432226-22562-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36465 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbcCaNud (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 09:50:33 -0400
Received: by mail-lf0-f49.google.com with SMTP id e133so60069755lfe.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 06:50:32 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org

PM QoS device latencies are properties of the hardware. Let's define some
DT bindings for them.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..b101a20 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -65,12 +65,18 @@ Required properties:
  - power-domains : A phandle and PM domain specifier as defined by bindings of
                    the power controller specified by phandle.
 
+Optional properties:
+ - suspend-latency: Suspend latency of the device in ns.
+ - resume-latency: Resume latency of the device in ns.
+
 Example:
 
 	leaky-device@12350000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12350000 0x1000>;
 		power-domains = <&power 0>;
+		suspend-latency = <250000>;
+		resume-latency = <250000>;
 	};
 
 The node above defines a typical PM domain consumer device, which is located
-- 
1.9.1


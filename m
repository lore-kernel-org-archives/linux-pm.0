From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v6 4/7] PM / Domains: Add DT bindings for PM QoS device latencies
Date: Mon, 27 Apr 2015 14:43:39 +0200
Message-ID: <1430138622-14029-5-git-send-email-geert+renesas@glider.be>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:58190 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678AbbD0Mnx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 08:43:53 -0400
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

PM QoS device start/stop are properties of the hardware.
In legacy code, they're specified from platform code.
On DT platforms, their values should come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC,

v4:
  - Drop save/restore state latencies, as they're Linux driver-specific,
  - Change state to RFC, as this is put on hold,

v3:
  - No changes,

v2:
  - New.
---
 Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index d659e5cb39be6057..32d1d3a399fe2a48 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -73,12 +73,18 @@ Required properties:
  - power-domains : A phandle and PM domain specifier as defined by bindings of
                    the power controller specified by phandle.
 
+Optional properties:
+ - stop-latency: Stop latency of the device, in ns,
+ - start-latency: Start latency of the device, in ns,
+
 Example:
 
 	leaky-device@12350000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12350000 0x1000>;
 		power-domains = <&power 0>;
+		stop-latency = <250000>;
+		start-latency = <250000>;
 	};
 
 The node above defines a typical PM domain consumer device, which is located
-- 
1.9.1


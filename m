From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v6 1/7] PM / Domains: Add DT bindings for power-on/off latencies
Date: Mon, 27 Apr 2015 14:43:36 +0200
Message-ID: <1430138622-14029-2-git-send-email-geert+renesas@glider.be>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

PM domain power-on/off latencies are properties of the hardware.
In legacy code, they're specified from platform code.
On DT platforms, their values should come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kevin Hilman <khilman@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC,

v5:
  - No changes,

v4:
  - Add Reviewed-by,
  - Replace single latency value by list of latencies,

v3:
  - No changes,

v2:
  - Add Acked-by.
---
 Documentation/devicetree/bindings/power/power_domain.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7df61c630c..d659e5cb39be6057 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -28,6 +28,12 @@ Optional properties:
    created by the given provider should be subdomains of the domain
    specified by this binding. More details about power domain specifier are
    available in the next section.
+ - power-on-latency: List of power-on latencies (in ns), one for each PM
+   domain. If all power-on latencies are identical, the list may be shortened
+   to a single value.
+ - power-off-latency: List of power-off latencies (in ns), one for each PM
+   domain. If all power-off latencies are identical, the list may be shortened
+   to a single value.
 
 Example:
 
@@ -35,10 +41,12 @@ Example:
 		compatible = "foo,power-controller";
 		reg = <0x12340000 0x1000>;
 		#power-domain-cells = <1>;
+		power-on-latency = <250000 400000 180000>;
+		power-off-latency = <250000 400000 300000>;
 	};
 
-The node above defines a power controller that is a PM domain provider and
-expects one cell as its phandle argument.
+The node above defines a power controller that is a PM domain provider for
+3 PM domains, and expects one cell as its phandle argument.
 
 Example 2:
 
-- 
1.9.1


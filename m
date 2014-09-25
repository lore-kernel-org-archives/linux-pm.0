From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 02/13] PM / Domains: Add DT bindings for power-on/off
 latencies
Date: Thu, 25 Sep 2014 18:28:29 +0200
Message-ID: <1411662520-22795-3-git-send-email-geert+renesas@glider.be>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

PM domain power on/off-latencies are properties of the hardware.
In legacy code, they're specified from platform code.
On DT platforms, their values should come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
v3:
  - No changes
v2:
  - Add Acked-by

 Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 98c16672ab5f49e0..7bc421d84367d636 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -19,12 +19,18 @@ Required properties:
    providing multiple PM domains (e.g. power controllers), but can be any value
    as specified by device tree binding documentation of particular provider.
 
+Optional properties:
+ - power-on-latency: Power-on latency of the PM domain, in ns,
+ - power-off-latency: Power-off latency of the PM domain, in ns.
+
 Example:
 
 	power: power-controller@12340000 {
 		compatible = "foo,power-controller";
 		reg = <0x12340000 0x1000>;
 		#power-domain-cells = <1>;
+		power-on-latency = <250000>;
+		power-off-latency = <250000>;
 	};
 
 The node above defines a power controller that is a PM domain provider and
-- 
1.9.1

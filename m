From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 02/12] PM / Domains: Add DT bindings for PM QoS device
 latencies
Date: Tue, 16 Sep 2014 20:48:49 +0200
Message-ID: <1410893339-6361-3-git-send-email-geert+renesas@glider.be>
References: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

PM QoS device start/stop and save/restore state latencies are more or
less properties of the hardware.
In legacy code, they're specified from platform code.
On DT platforms, their values should come from DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should these properties be called "linux,*-latency"?

v2:
  - New
---
 Documentation/devicetree/bindings/power/power_domain.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 7bc421d84367d636..024815bc257723b1 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -42,12 +42,22 @@ Required properties:
  - power-domains : A phandle and PM domain specifier as defined by bindings of
                    the power controller specified by phandle.
 
+Optional properties:
+ - stop-latency: Stop latency of the device, in ns,
+ - start-latency: Start latency of the device, in ns,
+ - save-state-latency: Save-state latency of the device, in ns,
+ - restore-state-latency: Restore-state latency of the device, in ns.
+
 Example:
 
 	leaky-device@12350000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12350000 0x1000>;
 		power-domains = <&power 0>;
+		stop-latency = <250000>;
+		start-latency = <250000>;
+		save-state-latency = <250000>;
+		restore-state-latency = <250000>;
 	};
 
 The node above defines a typical PM domain consumer device, which is located
-- 
1.9.1

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 01/23] Documentation: dt: atmel-at91: add clocks to system
 timer, rstc and shdwc
Date: Fri, 31 Jul 2015 11:39:37 +0200
Message-ID: <1438335599-3301-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The system timer (at91rm9200), the reset controller and the shutdown
controller need an input clock. This is the slow clock and they will not
function without it.

Also fix the shutdown controller example.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 424ac8cbfa08..209710cdf3aa 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -50,6 +50,7 @@ System Timer (ST) required properties:
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for the ST which is the IRQ line
   shared across all System Controller members.
+- clocks: phandle to input clock.
 Its subnodes can be:
 - watchdog: compatible should be "atmel,at91rm9200-wdt"
 
@@ -89,12 +90,14 @@ RSTC Reset Controller required properties:
 - compatible: Should be "atmel,<chip>-rstc".
   <chip> can be "at91sam9260" or "at91sam9g45"
 - reg: Should contain registers location and length
+- clocks: phandle to input clock.
 
 Example:
 
 	rstc@fffffd00 {
 		compatible = "atmel,at91sam9260-rstc";
 		reg = <0xfffffd00 0x10>;
+		clocks = <&clk32k>;
 	};
 
 RAMC SDRAM/DDR Controller required properties:
@@ -117,6 +120,7 @@ required properties:
 - compatible: Should be "atmel,<chip>-shdwc".
   <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
 - reg: Should contain registers location and length
+- clocks: phandle to input clock.
 
 optional properties:
 - atmel,wakeup-mode: String, operation mode of the wakeup mode.
@@ -135,9 +139,10 @@ optional at91sam9x5 properties:
 
 Example:
 
-	rstc@fffffd00 {
-		compatible = "atmel,at91sam9260-rstc";
-		reg = <0xfffffd00 0x10>;
+	shdwc@fffffd10 {
+		compatible = "atmel,at91sam9260-shdwc";
+		reg = <0xfffffd10 0x10>;
+		clocks = <&clk32k>;
 	};
 
 Special Function Registers (SFR)
-- 
2.1.4

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 1/9] ARM: at91/dt: declare atmel,at91rm9200-st as a syscon
Date: Wed,  4 Mar 2015 15:21:29 +0100
Message-ID: <1425478897-27322-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

The system timer register range is also used for the watchdog. Declare it as a
syscon to be able to get a regmap early enough in the boot process

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index ad319f84f560..0fbb3582ec9d 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -46,7 +46,7 @@ PIT Timer required properties:
   shared across all System Controller members.
 
 System Timer (ST) required properties:
-- compatible: Should be "atmel,at91rm9200-st"
+- compatible: Should be "atmel,at91rm9200-st", "syscon"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for the ST which is the IRQ line
   shared across all System Controller members.
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 21c2b504f977..1b1c1ac2c4f6 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -356,7 +356,7 @@
 			};
 
 			st: timer@fffffd00 {
-				compatible = "atmel,at91rm9200-st";
+				compatible = "atmel,at91rm9200-st", "syscon";
 				reg = <0xfffffd00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 			};
-- 
2.1.0

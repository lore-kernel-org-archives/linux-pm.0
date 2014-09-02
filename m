From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/8] ARM: l2x0: support associativity from DT
Date: Tue,  2 Sep 2014 14:02:33 +0200
Message-ID: <1409659354-23553-8-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

The ARM RealView platforms comes with boot loaders that fail
to set up cache size, ways and associativity correctly. This
complements Florian's patch to set up cache size and sets from
the device tree with the possibility to set up associativity
on the L2C-220 cache variant.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  1 +
 arch/arm/mm/cache-l2x0.c                       | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index d33ed2344c7e..94b02f704f1d 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -44,6 +44,7 @@ Optional properties:
   I/O coherent mode. Valid only when the arm,pl310-cache compatible
   string is used.
 - interrupts : 1 combined interrupt.
+- cache-associativity : specifies the associativity of the cache
 - cache-size : specifies the size in bytes of the cache
 - cache-sets : specifies the number of associativity sets of the cache
 - cache-id-part: cache id part number to be used if it is not present
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c735f792c3d5..ebed9638b96c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1007,6 +1007,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 	u32 tag = 0;
 	u32 dirty = 0;
 	u32 val = 0, mask = 0;
+	u32 assoc = 0;
 
 	of_property_read_u32(np, "arm,tag-latency", &tag);
 	if (tag) {
@@ -1029,6 +1030,16 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
+	of_property_read_u32(np, "cache-associativity", &assoc);
+	if (assoc) {
+		if (assoc > 8) {
+			pr_warn("L2C: associativity %d is too large\n", assoc);
+		} else {
+			mask |= L2X0_AUX_CTRL_ASSOC_MASK;
+			val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
+		}
+	}
+
 	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
 
 	*aux_val &= ~mask;
-- 
1.9.3

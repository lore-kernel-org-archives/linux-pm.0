From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/8] ARM: l2c: parse 'cache-size' and 'cache-sets' properties
Date: Tue,  2 Sep 2014 14:02:32 +0200
Message-ID: <1409659354-23553-7-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

When both 'cache-size' and 'cache-sets' are specified for a L2 cache
controller node, parse those properties and make sure we validate the
way_size based on which type of L2 cache controller we are using.

Update the L2 cache controller Device Tree binding with the optional
'cache-size' and 'cache-sets' properties.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  2 +
 arch/arm/mm/cache-l2x0.c                       | 61 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index af527ee111c2..d33ed2344c7e 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -44,6 +44,8 @@ Optional properties:
   I/O coherent mode. Valid only when the arm,pl310-cache compatible
   string is used.
 - interrupts : 1 combined interrupt.
+- cache-size : specifies the size in bytes of the cache
+- cache-sets : specifies the number of associativity sets of the cache
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
 - wt-override: If present then L2 is forced to Write through mode
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 363c27bee3f6..c735f792c3d5 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -945,6 +945,61 @@ static int l2_wt_override;
  * pass it though the device tree */
 static u32 cache_id_part_number_from_dt;
 
+static void __init l2x0_cache_size_of_parse(const struct device_node *np,
+					    u32 *aux_val, u32 *aux_mask,
+					    u32 max_way_size)
+{
+	u32 mask = 0, val = 0;
+	u32 size = 0, sets = 0;
+	u32 way_size = 0, way_size_bits = 1;
+
+	of_property_read_u32(np, "cache-size", &size);
+	of_property_read_u32(np, "cache-sets", &sets);
+
+	if (!size || !sets)
+		return;
+
+	way_size = size / sets;
+
+	if (way_size > max_way_size) {
+		pr_warn("L2C: way size %dKB is too large\n", way_size >> 10);
+		return;
+	}
+
+	way_size >>= 10;
+	switch (way_size) {
+	case 512:
+		way_size_bits = 6;
+		break;
+	case 256:
+		way_size_bits = 5;
+		break;
+	case 128:
+		way_size_bits = 4;
+		break;
+	case 64:
+		way_size_bits = 3;
+		break;
+	case 32:
+		way_size_bits = 2;
+		break;
+	case 16:
+		way_size_bits = 1;
+		break;
+	default:
+		pr_err("cache way size: %d KB is not mapped\n",
+		       way_size);
+		break;
+	}
+
+	mask |= L2C_AUX_CTRL_WAY_SIZE_MASK;
+	val |= (way_size_bits << L2C_AUX_CTRL_WAY_SIZE_SHIFT);
+
+	*aux_val &= ~mask;
+	*aux_val |= val;
+	*aux_mask &= ~mask;
+}
+
 static void __init l2x0_of_parse(const struct device_node *np,
 				 u32 *aux_val, u32 *aux_mask)
 {
@@ -974,6 +1029,8 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
@@ -1047,6 +1104,8 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_512K);
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
@@ -1253,6 +1312,8 @@ static void __init aurora_of_parse(const struct device_node *np,
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
-- 
1.9.3

From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] ARM: l2c: parse cache properties from ePAPR definitions
Date: Tue,  9 Sep 2014 09:10:33 +0200
Message-ID: <1410246633-23407-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

When both 'cache-size' and 'cache-sets' are specified for a L2 cache
controller node, parse those properties and set up the
set size based on which type of L2 cache controller we are using.

Update the L2 cache controller Device Tree binding with the optional
'cache-size', 'cache-sets', 'cache-block-size' and 'cache-line-size'
properties. These come from the ePAPR specification.

Using the cache size, number of sets and cache line size we can
calculate desired associativity of the L2 cache. This is done
by the calculation:

    set size = cache size / sets
    ways = set size / line size
    way size = cache size / ways
    associativity = way size / line size

This patch is an extended version based on the initial patch
by Florian Fainelli.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/l2cc.txt |   6 ++
 arch/arm/mm/cache-l2x0.c                       | 134 +++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index af527ee111c2..b77343914c66 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -44,6 +44,12 @@ Optional properties:
   I/O coherent mode. Valid only when the arm,pl310-cache compatible
   string is used.
 - interrupts : 1 combined interrupt.
+- cache-size : specifies the size in bytes of the cache
+- cache-sets : specifies the number of associativity sets of the cache
+- cache-block-size : specifies the size in bytes of a cache block
+- cache-line-size : specifies the size in bytes of a line in the cache,
+  if this is not specified, the line size is assumed to be equal to the
+  cache block size
 - cache-id-part: cache id part number to be used if it is not present
   on hardware
 - wt-override: If present then L2 is forced to Write through mode
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5f2c988a06ac..8157b913f3f3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -945,6 +945,134 @@ static int l2_wt_override;
  * pass it though the device tree */
 static u32 cache_id_part_number_from_dt;
 
+static void __init l2x0_cache_size_of_parse(const struct device_node *np,
+					    u32 *aux_val, u32 *aux_mask,
+					    u32 max_set_size,
+					    u32 max_associativity)
+{
+	u32 mask = 0, val = 0;
+	u32 cache_size = 0, sets = 0;
+	u32 set_size = 0, set_size_bits = 1;
+	u32 ways = 0, way_size = 0;
+	u32 blocksize = 0;
+	u32 linesize = 0;
+	u32 assoc = 0;
+
+	of_property_read_u32(np, "cache-size", &cache_size);
+	of_property_read_u32(np, "cache-sets", &sets);
+	of_property_read_u32(np, "cache-block-size", &blocksize);
+	of_property_read_u32(np, "cache-line-size", &linesize);
+
+	if (!cache_size || !sets)
+		return;
+
+	/* All these l2 caches have the same line = block size actually */
+	if (!linesize) {
+		if (blocksize) {
+			/* If linesize if not given, it is equal to blocksize */
+			linesize = blocksize;
+		} else {
+			/* Fall back to known size */
+			linesize = CACHE_LINE_SIZE;
+		}
+	}
+
+	if (linesize != CACHE_LINE_SIZE)
+		pr_warn("L2C OF: DT supplied line size %d bytes does "
+			"not match hardware line size of %d bytes\n",
+			linesize,
+			CACHE_LINE_SIZE);
+
+	set_size = cache_size / sets;
+	ways = set_size / linesize;
+	way_size = cache_size / ways;
+
+	if (set_size > max_set_size) {
+		pr_warn("L2C: set size %dKB is too large\n", set_size >> 10);
+		return;
+	}
+
+	/*
+	 * This cache is set associative. By increasing associativity
+	 * we increase the number of blocks per set.
+	 */
+	assoc = way_size / linesize;
+	if (assoc > max_associativity) {
+		pr_err("L2C OF: cache setting yield too high associativity\n");
+		pr_err("L2C OF: %d calculated, max %d\n",
+		       assoc, max_associativity);
+		return;
+	}
+	/* This is the PL3x0 case */
+	if (max_associativity == 16 && (assoc != 8 && assoc != 16)) {
+		pr_err("L2C OF: cache setting yield illegal associativity\n");
+		pr_err("L2C OF: %d calculated, only 8 and 16 legal\n", assoc);
+		return;
+	}
+
+	mask |= L2X0_AUX_CTRL_ASSOC_MASK;
+
+	/*
+	 * Special checks for the PL310 that only has two settings and
+	 * cannot be set to fully associative.
+	 */
+	if (max_associativity == 16) {
+		if (assoc == 16)
+			val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
+		/* Else bit is left zero == 8 way associativity */
+	} else {
+		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
+	}
+
+	pr_debug("L2C OF: cache size: %d bytes (%dKB)\n",
+		 cache_size, cache_size >> 10);
+	pr_debug("L2C OF: set size: %d bytes (%d KB)\n",
+		 set_size, set_size >> 10);
+	pr_debug("L2C OF: line size: %d bytes\n", linesize);
+	pr_debug("L2C OF: ways: %d ways\n", ways);
+	pr_debug("L2C OF: way size: %d bytes\n", way_size);
+	pr_debug("L2C OF: associativity: %d\n", assoc);
+
+	switch (set_size >> 10) {
+	case 512:
+		set_size_bits = 6;
+		break;
+	case 256:
+		set_size_bits = 5;
+		break;
+	case 128:
+		set_size_bits = 4;
+		break;
+	case 64:
+		set_size_bits = 3;
+		break;
+	case 32:
+		set_size_bits = 2;
+		break;
+	case 16:
+		set_size_bits = 1;
+		break;
+	default:
+		pr_err("L2C OF: cache way size: %d KB is not mapped\n",
+		       way_size);
+		break;
+	}
+
+	/*
+	 * The l2x0 TRMs call this size "way size" but that is incorrect:
+	 * the thing being configured in these register bits is actually
+	 * the cache set size, so the variable here has the right name
+	 * but the register bit definitions following the TRM are not
+	 * in archaic naming.
+	 */
+	mask |= L2C_AUX_CTRL_WAY_SIZE_MASK;
+	val |= (set_size_bits << L2C_AUX_CTRL_WAY_SIZE_SHIFT);
+
+	*aux_val &= ~mask;
+	*aux_val |= val;
+	*aux_mask &= ~mask;
+}
+
 static void __init l2x0_of_parse(const struct device_node *np,
 				 u32 *aux_val, u32 *aux_mask)
 {
@@ -974,6 +1102,8 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K, 8);
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
@@ -1047,6 +1177,8 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_512K, 16);
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
@@ -1253,6 +1385,8 @@ static void __init aurora_of_parse(const struct device_node *np,
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K, 8);
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
-- 
1.9.3

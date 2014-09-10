From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] ARM: l2c: parse cache properties from ePAPR definitions
Date: Wed, 10 Sep 2014 10:59:32 +0200
Message-ID: <1410339572-23694-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>
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
    way size = cache size / ways = sets * line size
    associativity = cache size / way size

Example output from the PB1176 DT that look like this:

L2: l2-cache {
    compatible = "arm,l220-cache";
    (...)
    arm,override-auxreg;
    cache-size = <131072>; // 128kB
    cache-sets = <512>;
    cache-line-size = <32>;
};

Ends up like this:

L2C OF: override cache size: 131072 bytes (128KB)
L2C OF: override line size: 32 bytes
L2C OF: override way size: 16384 bytes (16KB)
L2C OF: override associativity: 8
L2C: DT/platform modifies aux control register: 0x02020fff -> 0x02030fff
L2C-220 cache controller enabled, 8 ways, 128 kB
L2C-220: CACHE_ID 0x41000486, AUX_CTRL 0x06030fff

Which is consistent with the value earlier hardcoded for the
PB1176 platform.

This patch is an extended version based on the initial patch
by Florian Fainelli.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Fix up way size and associativity calculations using the combined
  wisdom of Arnd and Russell.
- Push associativity writes down to each cache hardware
  implementation, L2x0/PL3x0 respectively.
- Introduce a boolean device tree property to tell whether the
  auxilary register value containing these size and set-based
  configurations should be modified by the OS or not
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  10 ++
 arch/arm/mm/cache-l2x0.c                       | 147 +++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index af527ee111c2..918b4489ab73 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -43,7 +43,17 @@ Optional properties:
 - arm,io-coherent : indicates that the system is operating in an hardware
   I/O coherent mode. Valid only when the arm,pl310-cache compatible
   string is used.
+- arm,override-auxreg : this boolean property tells the OS implementation of
+  the l2cc driver code to override the default cache size, sets (and thus
+  associativity) settings from the auxilary control register. This is to be
+  used when the boot code does not set up these properties correctly.
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
index 5f2c988a06ac..8b4e54e3e18c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -945,6 +945,115 @@ static int l2_wt_override;
  * pass it though the device tree */
 static u32 cache_id_part_number_from_dt;
 
+/**
+ * l2x0_cache_size_of_parse() - read cache size parameters from DT
+ * @np: the device tree node for the l2 cache
+ * @aux_val: pointer to machine-supplied auxilary register value, to
+ * be augmented by the call (bits to be set to 1)
+ * @aux_mask: pointer to machine-supplied auxilary register mask, to
+ * be augmented by the call (bits to be set to 0)
+ * @associativity: variable to return the calculated associativity in
+ * @max_way_size: the maximum size in bytes for the cache ways
+ */
+static void __init l2x0_cache_size_of_parse(const struct device_node *np,
+					    u32 *aux_val, u32 *aux_mask,
+					    u32 *associativity,
+					    u32 max_way_size)
+{
+	u32 mask = 0, val = 0;
+	u32 cache_size = 0, sets = 0;
+	u32 way_size_bits = 1;
+	u32 way_size = 0;
+	u32 block_size = 0;
+	u32 line_size = 0;
+
+	if (!of_property_read_bool(np, "arm,override-auxreg"))
+		return;
+
+	of_property_read_u32(np, "cache-size", &cache_size);
+	of_property_read_u32(np, "cache-sets", &sets);
+	of_property_read_u32(np, "cache-block-size", &block_size);
+	of_property_read_u32(np, "cache-line-size", &line_size);
+
+	if (!cache_size || !sets)
+		return;
+
+	/* All these l2 caches have the same line = block size actually */
+	if (!line_size) {
+		if (block_size) {
+			/* If linesize if not given, it is equal to blocksize */
+			line_size = block_size;
+		} else {
+			/* Fall back to known size */
+			pr_warn("L2C OF: no cache block/line size given: "
+				"falling back to default size %d bytes\n",
+				CACHE_LINE_SIZE);
+			line_size = CACHE_LINE_SIZE;
+		}
+	}
+
+	if (line_size != CACHE_LINE_SIZE)
+		pr_warn("L2C OF: DT supplied line size %d bytes does "
+			"not match hardware line size of %d bytes\n",
+			line_size,
+			CACHE_LINE_SIZE);
+
+	/*
+	 * Since:
+	 * set size = cache size / sets
+	 * ways = cache size / (sets * line size)
+	 * way size = cache size / (cache size / (sets * line size))
+	 * way size = sets * line size
+	 * associativity = ways = cache size / way size
+	 */
+	way_size = sets * line_size;
+	*associativity = cache_size / way_size;
+
+	if (way_size > max_way_size) {
+		pr_err("L2C OF: set size %dKB is too large\n", way_size);
+		return;
+	}
+
+	pr_info("L2C OF: override cache size: %d bytes (%dKB)\n",
+		cache_size, cache_size >> 10);
+	pr_info("L2C OF: override line size: %d bytes\n", line_size);
+	pr_info("L2C OF: override way size: %d bytes (%dKB)\n",
+		way_size, way_size >> 10);
+	pr_info("L2C OF: override associativity: %d\n", *associativity);
+
+	switch (way_size >> 10) {
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
+		pr_err("L2C OF: cache way size illegal: %dKB is not mapped\n",
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
@@ -952,6 +1061,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 	u32 tag = 0;
 	u32 dirty = 0;
 	u32 val = 0, mask = 0;
+	u32 assoc;
 
 	of_property_read_u32(np, "arm,tag-latency", &tag);
 	if (tag) {
@@ -974,6 +1084,15 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
+	if (assoc > 8) {
+		pr_err("l2x0 of: cache setting yield too high associativity\n");
+		pr_err("l2x0 of: %d calculated, max 8\n", assoc);
+	} else {
+		mask |= L2X0_AUX_CTRL_ASSOC_MASK;
+		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
+	}
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
@@ -1021,6 +1140,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
 	u32 filter[2] = { 0, 0 };
+	u32 assoc;
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
@@ -1047,6 +1167,23 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
+
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_512K);
+	switch (assoc) {
+	case 16:
+		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		*aux_val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
+		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		break;
+	case 8:
+		*aux_val &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
+		break;
+	default:
+		pr_err("PL310 OF: cache setting yield illegal associativity\n");
+		pr_err("PL310 OF: %d calculated, only 8 and 16 legal\n", assoc);
+		break;
+	}
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
@@ -1238,6 +1375,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 {
 	u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
 	u32 mask =  AURORA_ACR_REPLACEMENT_MASK;
+	u32 assoc;
 
 	of_property_read_u32(np, "cache-id-part",
 			&cache_id_part_number_from_dt);
@@ -1250,6 +1388,15 @@ static void __init aurora_of_parse(const struct device_node *np,
 		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
 	}
 
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
+	if (assoc > 8) {
+		pr_err("l2x0 of: cache setting yield too high associativity\n");
+		pr_err("l2x0 of: %d calculated, max 8\n", assoc);
+	} else {
+		mask |= L2X0_AUX_CTRL_ASSOC_MASK;
+		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
+	}
+
 	*aux_val &= ~mask;
 	*aux_val |= val;
 	*aux_mask &= ~mask;
-- 
1.9.3

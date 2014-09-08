From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/7 v6] ARM: l2x0: calculate associativity from ePAPR cache props
Date: Mon,  8 Sep 2014 13:38:05 +0200
Message-ID: <1410176286-32533-7-git-send-email-linus.walleij@linaro.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34773 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbaIHLie (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 07:38:34 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so572513wgh.24
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 04:38:32 -0700 (PDT)
In-Reply-To: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

Using the cache size, number of sets and cache line size we can
calculate desired associativity of the L2 cache. This is done
by the calculation:

associativity = (cache size / cache sets) / cache line size

For most normal cache sizes this will quickly roof out to the
maximum associativity of 8 (L2x0 variants) or 16 (PL3x0 variants).
While all variants have a hard-coded line size of 32 bytes we also
support reading the "cache-line-size" ePAPR binding and complain
if it does not match the hardware.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/cache-l2x0.c | 62 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 61a684c743c6..f275cd4e5151 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -947,14 +947,18 @@ static u32 cache_id_part_number_from_dt;
 
 static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 					    u32 *aux_val, u32 *aux_mask,
-					    u32 max_way_size)
+					    u32 max_way_size,
+					    u32 max_associativity)
 {
 	u32 mask = 0, val = 0;
 	u32 size = 0, sets = 0;
 	u32 way_size = 0, way_size_bits = 1;
+	u32 linesize = 0;
+	u32 assoc = 0;
 
 	of_property_read_u32(np, "cache-size", &size);
 	of_property_read_u32(np, "cache-sets", &sets);
+	of_property_read_u32(np, "cache-line-size", &linesize);
 
 	if (!size || !sets)
 		return;
@@ -962,10 +966,56 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 	way_size = size / sets;
 
 	if (way_size > max_way_size) {
-		pr_warn("L2C: way size %dKB is too large\n", way_size >> 10);
+		pr_warn("L2C OF: way size %dKB is too large\n", way_size >> 10);
 		return;
 	}
 
+	/* All these l2 caches have the same line size actually */
+	if (!linesize)
+		linesize = CACHE_LINE_SIZE;
+	if (linesize != CACHE_LINE_SIZE)
+		pr_warn("L2C OF: DT supplied line size %d bytes does "
+			"not match hardware line size of %d bytes\n",
+			linesize,
+			CACHE_LINE_SIZE);
+
+	/*
+	 * This cache is set associative. By increasing associativity
+	 * we increase the number of blocks per set. Usually this
+	 * quickly hits the roof at 8 or 16 ways of associativity.
+	 */
+	assoc = way_size / linesize;
+	if (assoc > max_associativity)
+		assoc = max_associativity;
+
+	mask |= L2X0_AUX_CTRL_ASSOC_MASK;
+
+	/*
+	 * Special checks for the PL310 that only has two settings and
+	 * cannot be set to fully associative.
+	 */
+	if (max_associativity == 16) {
+		if (assoc <= 8) {
+			assoc = 8;
+			/* Leave bit 16 in associativity set to 0 */
+		}
+		if (assoc > 8 && assoc <= 16) {
+			assoc = 16;
+			val |= L310_AUX_CTRL_ASSOCIATIVITY_16;
+		}
+	} else {
+		if (sets == 1)
+			/* Direct-mapped cache */
+			assoc = 1;
+		val |= (assoc << L2X0_AUX_CTRL_ASSOC_SHIFT);
+	}
+
+	pr_info("L2C OF: size: %d bytes (%dKB)\n", size, size >> 10);
+	pr_info("L2C OF: way_size: %d bytes (%d KB)\n",
+		way_size, way_size >> 10);
+	pr_info("L2C OF: associativity: %d ways\n", assoc);
+
+	/* Convert to KB */
 	way_size >>= 10;
 	switch (way_size) {
 	case 512:
@@ -987,7 +1037,7 @@ static void __init l2x0_cache_size_of_parse(const struct device_node *np,
 		way_size_bits = 1;
 		break;
 	default:
-		pr_err("cache way size: %d KB is not mapped\n",
+		pr_err("L2C OF: cache way size: %d KB is not mapped\n",
 		       way_size);
 		break;
 	}
@@ -1029,7 +1079,7 @@ static void __init l2x0_of_parse(const struct device_node *np,
 		val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
 	}
 
-	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K, 8);
 
 	*aux_val &= ~mask;
 	*aux_val |= val;
@@ -1105,7 +1155,7 @@ static void __init l2c310_of_parse(const struct device_node *np,
 			       l2x0_base + L310_ADDR_FILTER_START);
 	}
 
-	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_512K);
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_512K, 16);
 }
 
 static const struct l2c_init_data of_l2c310_data __initconst = {
@@ -1313,7 +1363,7 @@ static void __init aurora_of_parse(const struct device_node *np,
 	*aux_val |= val;
 	*aux_mask &= ~mask;
 
-	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K);
+	l2x0_cache_size_of_parse(np, aux_val, aux_mask, SZ_256K, 8);
 }
 
 static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
-- 
1.9.3


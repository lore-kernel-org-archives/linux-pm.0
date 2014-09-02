From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/8] ARM: l2x0: move DT parsing for cache props
Date: Tue,  2 Sep 2014 14:02:31 +0200
Message-ID: <1409659354-23553-6-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:53849 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaIBMDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 08:03:06 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so14141270wib.14
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2014 05:03:05 -0700 (PDT)
In-Reply-To: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

The current diagnostic prints in the l2x0 driver will print
warnings like this if the AUX register i modified by the
mask and set words passed to the l2x0_init() function:

L2C: platform modifies aux control register: 0x02020fff -> 0x02730fff
L2C: DT/platform modifies aux control register: 0x02020fff -> 0x02730fff
L2C-220 cache controller enabled, 8 ways, 128 kB
L2C-220: CACHE_ID 0x41000486, AUX_CTRL 0x06730fff

However this is not printed properly if the DT modifies
the AUX register, even if the debug print says so. As the
call to ->of_parse for the cache variant is placed after this
print.

Move the ->of_parse call above the print so we get proper
diagnostics.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/cache-l2x0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5f2c988a06ac..363c27bee3f6 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1518,6 +1518,11 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	    of_property_read_bool(np, "arm,io-coherent"))
 		data = &of_l2c310_coherent_data;
 
+	/* L2 configuration can only be changed if the cache is disabled */
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
+		if (data->of_parse)
+			data->of_parse(np, &aux_val, &aux_mask);
+
 	old_aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 	if (old_aux != ((old_aux & aux_mask) | aux_val)) {
 		pr_warn("L2C: platform modifies aux control register: 0x%08x -> 0x%08x\n",
@@ -1530,11 +1535,6 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	if (!of_property_read_bool(np, "cache-unified"))
 		pr_err("L2C: device tree omits to specify unified cache\n");
 
-	/* L2 configuration can only be changed if the cache is disabled */
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN))
-		if (data->of_parse)
-			data->of_parse(np, &aux_val, &aux_mask);
-
 	if (cache_id_part_number_from_dt)
 		cache_id = cache_id_part_number_from_dt;
 	else
-- 
1.9.3


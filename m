From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 2/4] clk: samsung: Add support for runtime PM
Date: Fri, 30 Dec 2016 14:33:34 +0100
Message-ID: <1483104816-20885-3-git-send-email-m.szyprowski@samsung.com>
References: <1483104816-20885-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161230133345eucas1p22d8435055ed43b8c91cc3264d22467dd@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:13313 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbcL3Ndu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 08:33:50 -0500
In-reply-to: <1483104816-20885-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch adds struct device pointer to samsung_clk_provider and forwarding it
to clk_register_* functions, so drivers can register clocks, which use runtime
pm feature.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |  2 +-
 drivers/clk/samsung/clk.c     | 12 ++++++------
 drivers/clk/samsung/clk.h     |  1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 9617825daabb..f5249a7e545d 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1345,7 +1345,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	pll->lock_reg = base + pll_clk->lock_offset;
 	pll->con_reg = base + pll_clk->con_offset;
 
-	clk = clk_register(NULL, &pll->hw);
+	clk = clk_register(ctx->dev, &pll->hw);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register pll clock %s : %ld\n",
 			__func__, pll_clk->name, PTR_ERR(clk));
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index b7d87d6db9dc..e6923714f024 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -143,7 +143,7 @@ void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_fixed_rate(NULL, list->name,
+		clk = clk_register_fixed_rate(ctx->dev, list->name,
 			list->parent_name, list->flags, list->fixed_rate);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
@@ -172,7 +172,7 @@ void __init samsung_clk_register_fixed_factor(struct samsung_clk_provider *ctx,
 	unsigned int idx;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_fixed_factor(NULL, list->name,
+		clk = clk_register_fixed_factor(ctx->dev, list->name,
 			list->parent_name, list->flags, list->mult, list->div);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
@@ -193,7 +193,7 @@ void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_mux(NULL, list->name, list->parent_names,
+		clk = clk_register_mux(ctx->dev, list->name, list->parent_names,
 			list->num_parents, list->flags,
 			ctx->reg_base + list->offset,
 			list->shift, list->width, list->mux_flags, &ctx->lock);
@@ -226,13 +226,13 @@ void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		if (list->table)
-			clk = clk_register_divider_table(NULL, list->name,
+			clk = clk_register_divider_table(ctx->dev, list->name,
 				list->parent_name, list->flags,
 				ctx->reg_base + list->offset,
 				list->shift, list->width, list->div_flags,
 				list->table, &ctx->lock);
 		else
-			clk = clk_register_divider(NULL, list->name,
+			clk = clk_register_divider(ctx->dev, list->name,
 				list->parent_name, list->flags,
 				ctx->reg_base + list->offset, list->shift,
 				list->width, list->div_flags, &ctx->lock);
@@ -264,7 +264,7 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_gate(NULL, list->name, list->parent_name,
+		clk = clk_register_gate(ctx->dev, list->name, list->parent_name,
 				list->flags, ctx->reg_base + list->offset,
 				list->bit_idx, list->gate_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index da3bdebabf1e..9263d8a27c6b 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -26,6 +26,7 @@
  */
 struct samsung_clk_provider {
 	void __iomem *reg_base;
+	struct device *dev;
 	struct clk_onecell_data clk_data;
 	spinlock_t lock;
 };
-- 
1.9.1


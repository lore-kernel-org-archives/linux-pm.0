From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v4 02/12] clk: mux: Split out register accessors for reuse
Date: Fri,  8 Dec 2017 15:12:20 +0530
Message-ID: <1512726150-7204-3-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

We want to reuse the logic in clk-mux.c for other clock drivers
that don't use readl as register accessors. Fortunately, there
really isn't much to the mux code besides the table indirection
and quirk flags if you assume any bit shifting and masking has
been done already. Pull that logic out into reusable functions
that operate on an optional table and some flags so that other
drivers can use the same logic.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-mux.c        | 75 +++++++++++++++++++++++++++-----------------
 include/linux/clk-provider.h |  9 ++++--
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 39cabe1..22ebf99 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -26,35 +26,24 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
-static u8 clk_mux_get_parent(struct clk_hw *hw)
+unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
+				unsigned int *table, unsigned long flags)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
-	u32 val;
-
-	/*
-	 * FIXME need a mux-specific flag to determine if val is bitwise or numeric
-	 * e.g. sys_clkin_ck's clksel field is 3 bits wide, but ranges from 0x1
-	 * to 0x7 (index starts at one)
-	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
-	 * val = 0x4 really means "bit 2, index starts at bit 0"
-	 */
-	val = clk_readl(mux->reg) >> mux->shift;
-	val &= mux->mask;
 
-	if (mux->table) {
+	if (table) {
 		int i;
 
 		for (i = 0; i < num_parents; i++)
-			if (mux->table[i] == val)
+			if (table[i] == val)
 				return i;
 		return -EINVAL;
 	}
 
-	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
+	if (val && (flags & CLK_MUX_INDEX_BIT))
 		val = ffs(val) - 1;
 
-	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
+	if (val && (flags & CLK_MUX_INDEX_ONE))
 		val--;
 
 	if (val >= num_parents)
@@ -62,23 +51,53 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(clk_mux_get_parent);
 
-static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+static u8 _clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-	unsigned long flags = 0;
 
-	if (mux->table) {
-		index = mux->table[index];
+	/*
+	 * FIXME need a mux-specific flag to determine if val is bitwise or
+	 * numeric e.g. sys_clkin_ck's clksel field is 3 bits wide,
+	 * but ranges from 0x1 to 0x7 (index starts at one)
+	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
+	 * val = 0x4 really means "bit 2, index starts at bit 0"
+	 */
+	val = clk_readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_get_parent(hw, val, mux->table, mux->flags);
+}
+
+unsigned int clk_mux_reindex(u8 index, unsigned int *table,
+			     unsigned long flags)
+{
+	unsigned int val = index;
+
+	if (table) {
+		val = table[val];
 	} else {
-		if (mux->flags & CLK_MUX_INDEX_BIT)
-			index = 1 << index;
+		if (flags & CLK_MUX_INDEX_BIT)
+			val = 1 << index;
 
-		if (mux->flags & CLK_MUX_INDEX_ONE)
-			index++;
+		if (flags & CLK_MUX_INDEX_ONE)
+			val++;
 	}
 
+	return val;
+}
+EXPORT_SYMBOL_GPL(clk_mux_reindex);
+
+static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val;
+	unsigned long flags = 0;
+
+	index = clk_mux_reindex(index, mux->table, mux->flags);
+
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
 	else
@@ -102,14 +121,14 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 }
 
 const struct clk_ops clk_mux_ops = {
-	.get_parent = clk_mux_get_parent,
+	.get_parent = _clk_mux_get_parent,
 	.set_parent = clk_mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
 const struct clk_ops clk_mux_ro_ops = {
-	.get_parent = clk_mux_get_parent,
+	.get_parent = _clk_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
@@ -117,7 +136,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, unsigned int *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk_hw *hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7c925e6..9578411 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -468,7 +468,7 @@ struct clk_hw *clk_hw_register_divider_table(struct device *dev,
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
-	u32		*table;
+	unsigned int	*table;
 	u32		mask;
 	u8		shift;
 	u8		flags;
@@ -486,6 +486,11 @@ struct clk_mux {
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
+unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
+				unsigned int *table, unsigned long flags);
+unsigned int clk_mux_reindex(u8 index, unsigned int *table,
+			     unsigned long flags);
+
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
@@ -506,7 +511,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, unsigned int *table, spinlock_t *lock);
 
 void clk_unregister_mux(struct clk *clk);
 void clk_hw_unregister_mux(struct clk_hw *hw);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

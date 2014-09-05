From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 01/15] clk: mux: Add unregistration API
Date: Fri,  5 Sep 2014 15:47:20 -0700
Message-ID: <1409957256-23729-2-git-send-email-sboyd@codeaurora.org>
References: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409957256-23729-1-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some drivers want to remove clocks they register with
clk_unregister(). Unfortunately, calling clk_unregister()
directly on the clock returned by clk_register_mux() would result
in a memory leak of the clk_mux struct. Add an API to free that
allocation and unregister the clock.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-mux.c        | 15 +++++++++++++++
 include/linux/clk-provider.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 4f96ff3ba728..c0cf9db9effa 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -177,3 +177,18 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 				      NULL, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_mux);
+
+void clk_unregister_mux(struct clk *clk)
+{
+	struct clk_hw *hw;
+	struct clk_mux *mux;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	mux = to_clk_mux(hw);
+	clk_unregister(clk);
+	kfree(mux);
+}
+EXPORT_SYMBOL_GPL(clk_unregister_mux);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 411dd7eb2653..f0744b8de50a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -401,6 +401,8 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
+void clk_unregister_mux(struct clk *clk);
+
 void of_fixed_factor_clk_setup(struct device_node *node);
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

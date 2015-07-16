From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by
 SCP(System Control Processor)
Date: Thu, 16 Jul 2015 12:31:14 -0700
Message-ID: <20150716193114.GA17952@codeaurora.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-4-git-send-email-sudeep.holla@arm.com>
 <20150702172310.GF4301@codeaurora.org>
 <5596A1B6.8020307@arm.com>
 <559ADC94.4080505@codeaurora.org>
 <559BF858.1020301@arm.com>
 <20150708014606.GH30412@codeaurora.org>
 <55A7D79B.3080305@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46472 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbbGPTbQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2015 15:31:16 -0400
Content-Disposition: inline
In-Reply-To: <55A7D79B.3080305@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@baylibre.com>

On 07/16, Sudeep Holla wrote:
> On 08/07/15 02:46, Stephen Boyd wrote:
> >
> >Yes struct clk would have min/max, and struct clk_core would have
> >min/max. Then some sort of provider API (or possibly even
> >clk_init_data) would take the min/max fields and copy them over
> >to struct clk_core. Then during set_rate operations we would
> >aggregate the constraints from struct clk like we already do and
> >add in the constrains in struct clk_core.
> >
> >One downside to adding new fields to clk_init_data is that there
> >are drivers out there that aren't initializing that structure to
> >0, and they're putting it on the stack, so stack junk can come
> >through. Furthermore, min/max would mean that every driver needs
> >to specify some large number for max or we have to special case
> >min == max == 0 and ignore it. Somehow it needs to be opt-in. If
> >we want to go down the clk_init_data route then perhaps we need
> >some sort of rate_constraint struct pointer in there that drivers
> >can optionally setup.
> >
> >	struct clk_rate_constraint {
> >		unsigned long min;
> >		unsigned long max;
> >	};
> >
> >	struct clk_init_data {
> >		...
> >		struct clk_rate_constraint *rate_constraint;
> >	};
> >
> >I haven't thought it through completely, but I can probably write
> >up some patch tomorrow after I sleep on it.
> >
> 
> I am hoping to get this series for v4.3. In order to avoid using
> consumer API, I can revert back to the min,max check I had in the
> round_rate earlier if that's fine with you ? Let me know so that I can
> post the next version based on that. All the other comments are already
> addressed.

Ok. I'm fine with the consumer API being used, but it would be
nice if we didn't have to do so. Try out the patch below,
hopefully it's good enough for your purposes. It may need to be
more robust, and we may still want to use the init_data structure
to avoid races with providers and consumers, but we can leave
that for later after sweeping all the structure users.

> 
> Also since this series depends on SCPI, I was thinking to get it merged
> via ARM-SoC, but that might conflict with the round_rate prototype
> change. Do do plan to share a stable base with arm-soc guys or you
> expect all the changes to be contained in clk tree ?
> 

We can share a stable branch for the determine_rate change with
arm-soc. We already have it on a separate branch but haven't
published it so far because nobody has asked.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

-----8<------
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a1d34a2ed9c6..8760b743bb70 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -58,6 +58,8 @@ struct clk_core {
 	unsigned long		flags;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
+	unsigned long		min_rate;
+	unsigned long		max_rate;
 	unsigned long		accuracy;
 	int			phase;
 	struct hlist_head	children;
@@ -512,8 +514,8 @@ static void clk_core_get_boundaries(struct clk_core *core,
 {
 	struct clk *clk_user;
 
-	*min_rate = 0;
-	*max_rate = ULONG_MAX;
+	*min_rate = core->min_rate;
+	*max_rate = core->max_rate;
 
 	hlist_for_each_entry(clk_user, &core->clks, clks_node)
 		*min_rate = max(*min_rate, clk_user->min_rate);
@@ -522,6 +524,13 @@ static void clk_core_get_boundaries(struct clk_core *core,
 		*max_rate = min(*max_rate, clk_user->max_rate);
 }
 
+void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
+			   unsigned long max_rate)
+{
+	hw->core->min_rate = min_rate;
+	hw->core->max_rate = max_rate;
+}
+
 /*
  * Helper for finding best parent to provide a given frequency. This can be used
  * directly as a determine_rate callback (e.g. for a mux), or from a more
@@ -2496,6 +2505,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->hw = hw;
 	core->flags = hw->init->flags;
 	core->num_parents = hw->init->num_parents;
+	core->min_rate = 0;
+	core->max_rate = ULONG_MAX;
 	hw->core = core;
 
 	/* allocate local copy in case parent_names is __initdata */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2116e2b8a5f2..d62e7eab1dbe 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -619,6 +619,8 @@ int __clk_determine_rate(struct clk_hw *core, struct clk_rate_request *req);
 int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 				     struct clk_rate_request *req);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
+void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
+			   unsigned long max_rate);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

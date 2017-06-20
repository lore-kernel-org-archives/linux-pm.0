From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Add dev_pm_opp_{set|put}_clkname()
Date: Tue, 20 Jun 2017 14:08:20 -0700
Message-ID: <20170620210820.GU4493@codeaurora.org>
References: <e1ae46672cc137bf375349a6b9f7a5a3c9823e74.1497953043.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFTVIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 17:08:21 -0400
Content-Disposition: inline
In-Reply-To: <e1ae46672cc137bf375349a6b9f7a5a3c9823e74.1497953043.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org

On 06/20, Viresh Kumar wrote:
> + */
> +struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
> +{
> +	struct opp_table *opp_table;
> +	int ret;
> +
> +	opp_table = dev_pm_opp_get_opp_table(dev);
> +	if (!opp_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* This should be called before OPPs are initialized */
> +	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	/* Already have clkname set */
> +	if (opp_table->clk_name) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	opp_table->clk_name = kstrdup(name, GFP_KERNEL);
> +	if (!opp_table->clk_name) {

Is there a reason to duplicate clk_name instead of using the clk
structure returned from clk_get()? Is it because we may already
have opp_table->clk set from default init? Why can't we always
clk_put() the clk structure if it's !IS_ERR() and then allow
dev_pm_opp_set_clkname() to be called many times in succession?
Long story short, I don't see the benefit to allocating the name
again here just to use it as a mechanism to know if the APIs have
been called symmetrically.

> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/* Already have default clk set, free it */
> +	if (!IS_ERR(opp_table->clk))
> +		clk_put(opp_table->clk);
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

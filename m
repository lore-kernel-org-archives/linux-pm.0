From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Add dev_pm_opp_{set|put}_clkname()
Date: Wed, 21 Jun 2017 10:30:38 +0530
Message-ID: <20170621050038.GQ3942@vireshk-i7>
References: <e1ae46672cc137bf375349a6b9f7a5a3c9823e74.1497953043.git.viresh.kumar@linaro.org>
 <20170620210820.GU4493@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36098 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdFUFAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 01:00:42 -0400
Received: by mail-pg0-f47.google.com with SMTP id u62so53083288pgb.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jun 2017 22:00:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170620210820.GU4493@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org

On 20-06-17, 14:08, Stephen Boyd wrote:
> On 06/20, Viresh Kumar wrote:
> > + */
> > +struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
> > +{
> > +	struct opp_table *opp_table;
> > +	int ret;
> > +
> > +	opp_table = dev_pm_opp_get_opp_table(dev);
> > +	if (!opp_table)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	/* This should be called before OPPs are initialized */
> > +	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> > +		ret = -EBUSY;
> > +		goto err;
> > +	}
> > +
> > +	/* Already have clkname set */
> > +	if (opp_table->clk_name) {
> > +		ret = -EBUSY;
> > +		goto err;
> > +	}
> > +
> > +	opp_table->clk_name = kstrdup(name, GFP_KERNEL);
> > +	if (!opp_table->clk_name) {
> 
> Is there a reason to duplicate clk_name instead of using the clk
> structure returned from clk_get()? Is it because we may already
> have opp_table->clk set from default init? Why can't we always
> clk_put() the clk structure if it's !IS_ERR() and then allow
> dev_pm_opp_set_clkname() to be called many times in succession?
> Long story short, I don't see the benefit to allocating the name
> again here just to use it as a mechanism to know if the APIs have
> been called symmetrically.

Yeah, it was kind of required in what I was trying to do earlier, but
not anymore.

-- 
viresh

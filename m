From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/8] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Wed, 26 Oct 2016 11:35:12 +0530
Message-ID: <20161026060512.GI9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <32c1feabb59b1f00e1cefde606e3ec7ef738ac12.1476952750.git.viresh.kumar@linaro.org>
 <20161025164953.GT26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36125 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbcJZGFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 02:05:17 -0400
Received: by mail-pf0-f179.google.com with SMTP id e6so133279777pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 23:05:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161025164953.GT26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 25-10-16, 09:49, Stephen Boyd wrote:
> On 10/20, Viresh Kumar wrote:
> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index 37fad2eb0f47..45c70ce07864 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -235,21 +237,44 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> >  		return 0;
> >  	}
> >  
> > -	reg = opp_table->regulator;
> > -	if (IS_ERR(reg)) {
> > +	count = opp_table->regulator_count;
> > +
> > +	if (!count) {
> >  		/* Regulator may not be required for device */
> >  		rcu_read_unlock();
> >  		return 0;
> >  	}
> >  
> > -	list_for_each_entry_rcu(opp, &opp_table->opp_list, node) {
> > -		if (!opp->available)
> > -			continue;
> > +	size = count * sizeof(*regulators);
> > +	regulators = kmemdup(opp_table->regulators, size, GFP_KERNEL);
> 
> How do we allocate under RCU? Doesn't that spit out big warnings?

That doesn't. I even tried enabling several locking debug config options.

> > +	if (!regulators) {
> > +		rcu_read_unlock();
> > +		return 0;
> > +	}
> > +
> > +	min_uV = kmalloc(count * (sizeof(*min_uV) + sizeof(*max_uV)),
> 
> Do we imagine min_uV is going to be a different size from max_uV?
> It may be better to have a struct for min/max pair and then
> stride them. Then the kmalloc() can become a kmalloc_array().

done.

> > -	*opp_table = _add_opp_table(dev);
> > -	if (!*opp_table) {
> > -		kfree(opp);
> > +	/* allocate new OPP node + and supplies structures */
> > +	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
> > +	if (!opp) {
> > +		kfree(table);
> >  		return NULL;
> >  	}
> >  
> > +	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
> 
> So put the supplies at the end of the OPP structure as an empty
> array?

Yes. Added a comment to clarify as well.

> > -int dev_pm_opp_set_regulator(struct device *dev, const char *name)
> > +int dev_pm_opp_set_regulators(struct device *dev, const char *names[],
> 
> Make names a const char * const *?

Done.

> I seem to recall arrays as
> function arguments has some problem but my C mastery is failing
> right now.

I am not sure why it would be a problem, and of course what gets passed is the
address and not the array.

> > +	for (i = 0; i < count; i++) {
> > +		reg = regulator_get_optional(dev, names[i]);
> > +		pr_info("%s: %d: %p: %s\n", __func__, __LINE__, reg, names[i]);
> 
> Debug noise?

Yes.

> > +static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
> > +				      struct opp_table *opp_table,
> > +				      struct dentry *pdentry)
> > +{
> > +	struct dentry *d;
> > +	int i = 0;
> > +	char name[] = "supply-X"; /* support only 0-9 supplies */
> 
> But we don't verify that's the case? Why not use kasprintf() and
> free() and then there isn't any limit?

Done.

> > diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> > index b7fcd0a1b58b..c857fb07a5bc 100644
> > --- a/drivers/base/power/opp/of.c
> > +++ b/drivers/base/power/opp/of.c
> > @@ -105,12 +106,13 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
> >  static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
> >  			      struct opp_table *opp_table)
> >  {
> > -	u32 microvolt[3] = {0};
> > -	u32 val;
> > -	int count, ret;
> > +	u32 *microvolt, *microamp = NULL;
> > +	int supplies, vcount, icount, ret, i, j;
> >  	struct property *prop = NULL;
> >  	char name[NAME_MAX];
> >  
> > +	supplies = opp_table->regulator_count ? opp_table->regulator_count : 1;
> 
> We can't have regulator_count == 1 by default?

It is used at various places to distinguish if regulators are set by platform
code or not. The OPP core can still be used just for DT data, i.e. no opp-set.
And so it is important to support cases where the regulators aren't set.

> > @@ -155,7 +155,8 @@ enum opp_table_access {
> >   * @supported_hw_count: Number of elements in supported_hw array.
> >   * @prop_name: A name to postfix to many DT properties, while parsing them.
> >   * @clk: Device's clock handle
> > - * @regulator: Supply regulator
> > + * @regulators: Supply regulators
> > + * @regulator_count: Number of Power Supply regulators
> 
> Lowercase Power Supply please.

Done.

> >   * @dentry:	debugfs dentry pointer of the real device directory (not links).
> >   * @dentry_name: Name of the real dentry.
> >   *
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index 5c07ae05d69a..15cb26118dc7 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -186,7 +186,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	 */
> >  	name = find_supply_name(cpu_dev);
> >  	if (name) {
> > -		ret = dev_pm_opp_set_regulator(cpu_dev, name);
> > +		const char *names[] = {name};
> > +
> > +		ret = dev_pm_opp_set_regulators(cpu_dev, names,
> 
> We can't just do &names instead here? Hmm...

I don't think so. You sure we can do it ?

-- 
viresh

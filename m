From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
Date: Fri, 31 Jul 2015 09:22:40 -0700
Message-ID: <20150731162240.GG6519@usrtlx11787.corpusers.net>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
 <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:10790 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751250AbbGaQWr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 12:22:47 -0400
Content-Disposition: inline
In-Reply-To: <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org

On Tue 28 Jul 02:33 PDT 2015, Rajendra Nayak wrote:

[..]
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
[..]
> +static int gdsc_init(struct gdsc *sc)
> +{
> +	u32 mask, val;
> +	int on, ret;
> +
> +	/*
> +	 * Disable HW trigger: collapse/restore occur based on registers writes.
> +	 * Disable SW override: Use hardware state-machine for sequencing.
> +	 * Configure wait time between states.
> +	 */
> +	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
> +	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> +	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> +	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	on = gdsc_is_enabled(sc);
> +	if (on < 0)
> +		return on;
> +
> +	sc->pd.power_off = gdsc_disable;
> +	sc->pd.power_on = gdsc_enable;
> +	pm_genpd_init(&sc->pd, NULL, !on);
> +
> +	return 0;
> +}
> +
> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
> +		  struct regmap *regmap)
> +{
> +	int i, ret;
> +	struct genpd_onecell_data *data;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
> +				     GFP_KERNEL);
> +	if (!data->domains)
> +		return -ENOMEM;
> +
> +	data->num_domains = num;
> +	for (i = 0; i < num; i++) {
> +		if (!scs[i])
> +			continue;
> +		scs[i]->regmap = regmap;
> +		ret = gdsc_init(scs[i]);
> +		if (ret)
> +			return ret;

By this time we have disabled the HW control and here we just leave it
as that, do you expect any interesting consequences of this?
Or do we just not care (this shouldn't happen anyways).

> +		data->domains[i] = &scs[i]->pd;
> +	}
> +
> +	return of_genpd_add_provider_onecell(dev->of_node, data);
> +}
> +
> +void gdsc_unregister(struct device *dev)
> +{
> +	of_genpd_del_provider(dev->of_node);
> +}
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
[..]
> +#ifdef CONFIG_QCOM_GDSC
> +int gdsc_register(struct device *, struct gdsc **, size_t n, struct regmap *);
> +void gdsc_unregister(struct device *);
> +#else
> +static inline int gdsc_register(struct device *d, struct gdsc **g, size_t n,
> +				struct regmap *r)
> +{
> +	return -ENOSYS;

This will cause qcom_cc_really_probe() to abort and unregister both its
resets and clocks. I think you should just pretend that everything went
fine and return 0...

> +}
> +

Regards,
Bjorn

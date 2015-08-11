From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 11/13] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
Date: Mon, 10 Aug 2015 23:52:24 -0700
Message-ID: <20150811065224.GA2839@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-12-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60824 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbbHKGw0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 02:52:26 -0400
Content-Disposition: inline
In-Reply-To: <1438857474-20262-12-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 08/06, Rajendra Nayak wrote:
> +
> +static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
> +{
> +	int ret, i = 0, j = 0;
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	struct of_phandle_args clkspec;
> +	struct device_node *np = dev->of_node;
> +
> +	if (!sc->clock_count)
> +		return 0;
> +
> +	ret = pm_clk_create(dev);
> +	if (ret) {
> +		dev_dbg(dev, "pm_clk_create failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	sc->clks = devm_kcalloc(dev, sc->clock_count, sizeof(sc->clks),
> +				       GFP_KERNEL);
> +	if (!sc->clks)
> +		return -ENOMEM;
> +
> +	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
> +					   &clkspec)) {
> +		if (match(clkspec.args[0], sc->clocks, sc->clock_count)) {

I'm lost. I was hoping we could just make up a clkspec on the
stack and pass it over to of_clk_get_from_provider() without
having to go through the np of the client device. The point being
to avoid forcing this code from knowing about the consumer
binding or connection name choice for each device. Instead, it
assumes that it's a #clock-cells=<1> binding and gets the clocks
by passing the 1 cell data without calling
of_parse_phandle_with_args().

Now, one downside of that approach is that it's DT centric (also
of_clk_get_from_provider() is not an exported symbol yet). So I'm
really starting to lean towards exposing __clk_create_clk() (or
some better named "provider" function) that will allow clk
providers to turn their clk_hw structure into a struct clk
pointer. That avoids the DT centric design, and avoids binding
the provider to the connection ids too.

> +			sc->clks[j] = of_clk_get_from_provider(&clkspec);
> +			pm_clk_add_clk(dev, sc->clks[j]);
> +			j++;
> +		}
> +		i++;
> +	}
> +	return 0;
> +};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

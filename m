From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 03/13] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
Date: Wed, 22 Jul 2015 18:01:29 -0700
Message-ID: <55B03CE9.4050903@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-4-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47875 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbGWBBb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 21:01:31 -0400
In-Reply-To: <1437549069-29655-4-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 07/22/2015 12:10 AM, Rajendra Nayak wrote:
> @@ -104,6 +105,37 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>   	return gdsc_toggle_logic(sc, false);
>   }
>   
> +static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
> +{
> +	int ret;
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	char **con_id, *con_ids[] = { "core", "iface", NULL };

const?

This is where I get scared of sniffing too much SoC glue. What's to 
enforce the "core", and "iface" naming scheme? What's to enforce there 
being two clocks vs. one? Maybe a better approach would be to use 
of_clk_get() and iterate through all clocks of the device, or to encode 
the clock names in the gdsc structure.

The problem I'm getting at is that we're going through the consumer 
struct device's mapping of names to clks when we're inside this SoC glue 
code that has to know about what the consumer has decided to do. This 
code becomes tightly coupled with that decision that doesn't seem to be 
under the glue code's control. Using of_clk_get() sidesteps that 
problem, with the loss of flexibility of deciding which clock does what 
so at least it's a step in the right direction. But if we want to 
control individual clocks then we have to know which clock is which. 
Maybe we should associate clk_hw pointers with the gdscs and then export 
__clk_hw_create_clk() so that drivers can turn clk_hw pointers into clocks?

> +
> +	ret = pm_clk_create(dev);
> +	if (ret) {
> +		dev_err(dev, "pm_clk_create failed %d\n", ret);

Who cares? debug?

> +		return ret;
> +	}
> +
> +	for (con_id = con_ids; *con_id; con_id++) {
> +		ret = pm_clk_add(dev, *con_id);
> +		if (ret) {
> +			dev_err(dev, "pm_clk_add failed %d\n", ret);

Who cares? debug?

> +			goto fail;
> +		}
> +	}
> +	return 0;
> +fail:
> +	pm_clk_destroy(dev);
> +	return ret;
> +};
> +
> +static void gdsc_detach(struct generic_pm_domain *domain, struct device *dev)
> +{
> +	pm_clk_destroy(dev);
> +	return;

useless return

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project


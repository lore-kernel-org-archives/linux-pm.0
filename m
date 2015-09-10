From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: tegra: dfll: Properly protect OPP list
Date: Thu, 10 Sep 2015 10:51:44 -0700
Message-ID: <20150910175144.GB15099@codeaurora.org>
References: <1441893321-4563-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49860 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbIJRvq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 13:51:46 -0400
Content-Disposition: inline
In-Reply-To: <1441893321-4563-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org

On 09/10, Thierry Reding wrote:
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Fixes: ?

> ---
>  drivers/clk/tegra/clk-dfll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index aa026bcf5b00..8e25bd52da8c 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -632,11 +632,15 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  	struct dev_pm_opp *opp;
>  	int i, uv;
>  
> +	rcu_read_lock();
> +
>  	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  	uv = dev_pm_opp_get_voltage(opp);
>  
> +	rcu_read_unlock();
> +
>  	for (i = 0; i < td->i2c_lut_size; i++) {
>  		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
>  			return i;
> @@ -1450,6 +1454,8 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
>  	td->i2c_lut[0] = lut;
>  
>  	for (j = 1, rate = 0; ; rate++) {
> +		rcu_read_lock();

Don't we already have an rcu_read_lock() at the beginning of this
function? I don't understand why we need to nest them in the same
function.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

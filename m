From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 12/16] PM / OPP: add dev_pm_opp_is_turbo() helper
Date: Thu, 30 Jul 2015 23:10:23 -0700
Message-ID: <20150731061023.GL3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <1e1445bc7f79eb4adc5bf1a0f5eddf118dc60345.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1e1445bc7f79eb4adc5bf1a0f5eddf118dc60345.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 07/29, Viresh Kumar wrote:
> +bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
> +{
> +	struct dev_pm_opp *tmp_opp;
> +
> +	opp_rcu_lockdep_assert();
> +
> +	tmp_opp = rcu_dereference(opp);
> +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available) {

IS_ERR_OR_NULL already has unlikely inside it on the error
pointer path so it seems redundant here.

Otherwise

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

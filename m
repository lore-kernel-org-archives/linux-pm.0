From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Date: Tue, 4 Dec 2018 13:51:58 +0530
Message-ID: <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Fan <Nick.Fan@mediatek.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, tfiga@chromium.org, Chiawen.Lee@mediatek.com, erin.lo@mediatek.com
List-Id: linux-pm@vger.kernel.org

On 04-12-18, 14:59, Nick Fan wrote:
> Add API to get voltage for multiple supplies from opp table

And who needs to use this new API ? It would be better to add the user in the
same series to make sure this really gets used.

> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> ---
>  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e..ee73546 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>  
>  /**
> + * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
> + * with index
> + * @opp:        opp for which voltage has to be returned for
> + * @index:      index to specify the returned supplies
> + *
> + * Return: voltage in micro volt corresponding to the opp with index, else
> + * return 0
> + *
> + * This is useful for devices with multiple power supplies.
> + */
> +unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
> +					    unsigned int index)

How will the users of this API get the index ?

> +{
> +	if (IS_ERR_OR_NULL(opp)) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	if (index >= opp->opp_table->regulator_count) {
> +		pr_err("%s: Invalid supply index: %u\n", __func__, index);
> +		return 0;
> +	}
> +
> +	return opp->supplies[index].u_volt;

-- 
viresh

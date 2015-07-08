From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Wed, 08 Jul 2015 15:41:34 +0200
Message-ID: <2910042.ys2zsBBKt2@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46078 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbbGHNlp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 09:41:45 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NR602P4O8PJ6990@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 08 Jul 2015 22:41:43 +0900 (KST)
In-reply-to: <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


Hi,

On Monday, June 15, 2015 05:27:31 PM Viresh Kumar wrote:
> This adds support in OPP library to parse and create list of OPPs from
> operating-points-v2 bindings. It takes care of most of the properties of
> new bindings (except shared-opp, which will be handled separately).
> 
> For backward compatibility, we keep supporting earlier bindings. We try
> to search for the new bindings first, in case they aren't present we
> look for the old deprecated ones.
> 
> There are few things marked as TODO:
> - Support for multiple OPP tables
> - Support for multiple regulators
> 
> They should be fixed separately.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp.c | 238 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 213 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 2ac48ff9c1ef..3198c3e77224 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c

[...]

> @@ -675,6 +692,100 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  }
>  
>  /**
> + * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
> + * @dev:	device for which we do this operation
> + * @np:		device node
> + *
> + * This function adds an opp definition to the opp list and returns status. The
> + * opp can be controlled using dev_pm_opp_enable/disable functions and may be
> + * removed by dev_pm_opp_remove.
> + *
> + * Locking: The internal device_opp and opp structures are RCU protected.
> + * Hence this function internally uses RCU updater strategy with mutex locks
> + * to keep the integrity of the internal data structures. Callers should ensure
> + * that this function is *NOT* called under RCU protection or in contexts where
> + * mutex cannot be locked.
> + *
> + * Return:
> + * 0		On success OR
> + *		Duplicate OPPs (both freq and volt are same) and opp->available
> + * -EEXIST	Freq are same and volt are different OR
> + *		Duplicate OPPs (both freq and volt are same) and !opp->available
> + * -ENOMEM	Memory allocation failure
> + * -EINVAL	Failed parsing the OPP node
> + */
> +static int _opp_add_static_v2(struct device *dev, struct device_node *np)
> +{
> +	struct device_opp *dev_opp;
> +	struct dev_pm_opp *new_opp;
> +	int ret;
> +
> +	/* Hold our list modification lock here */
> +	mutex_lock(&dev_opp_list_lock);
> +
> +	new_opp = _allocate_opp(dev, &dev_opp);
> +	if (!new_opp) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	ret = of_property_read_u32(np, "opp-hz", (u32 *)&new_opp->rate);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: opp-hz not found\n", __func__);
> +		goto free_opp;
> +	}

Isn't using u32 for storing frequency (in Hz) too small by today's
standards?

[ Please note that the old v1 binding uses kHz not Hz. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


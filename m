From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 08/11] opp: Add OPP sharing information to OPP library
Date: Mon, 27 Jul 2015 16:48:59 +0200
Message-ID: <1564699.gQjhqzf5VE@amdc1976>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <f92bd33dcaa2094dfc99aa9656487c6f08f160fe.1437972635.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52331 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbbG0Otg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 10:49:36 -0400
In-reply-to: <f92bd33dcaa2094dfc99aa9656487c6f08f160fe.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>


Hi,

Two very minor nits:

On Monday, July 27, 2015 10:32:38 AM Viresh Kumar wrote:
> An opp can be shared by multiple devices, for example its very common
> for CPUs to share the OPPs, i.e. when they share clock/voltage rails.
> 
> This patch adds support of shared OPPs to the OPP library.
> 
> Instead of a single device, dev_opp will not contain a list of devices

s/will not/will now/ ?

> that use it. It also senses if the device (we are trying to initialize
> OPPs for) shares OPPs with a device added earlier and in that case we
> update the list of devices managed by OPPs instead of duplicating OPPs
> again.
> 
> The same infrastructure will be used for the old OPP bindings, with
> later patches.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> +static struct device_list_opp *_add_list_dev(const struct device *dev,
> +					     struct device_opp *dev_opp)
> +{
> +	struct device_list_opp *list_dev;
> +
> +	list_dev = kzalloc(sizeof(*list_dev), GFP_KERNEL);
> +	if (!list_dev)
> +		return NULL;
> +
> +	/* Initialize list-dev */
> +	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
> +	list_dev->dev = dev;

Probably doesn't matter currently but how's about:

	list_dev->dev = dev;
	list_add_rcu(&list_dev->node, &dev_opp->dev_list);

?

> +
> +	return list_dev;
> +}

Otherwise:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


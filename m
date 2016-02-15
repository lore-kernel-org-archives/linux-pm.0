From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Mon, 15 Feb 2016 21:38:14 +0100
Message-ID: <17646703.2nZXD4icYj@wuerfel>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com> <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 15 February 2016 21:56:42 Viresh Kumar wrote:
> We are currently required to do two checks for regulator pointer:
> IS_ERR() and IS_NULL().
> 
> And multiple instances are reported, about both of these not being used
> consistently and so resulting in crashes.
> 
> Fix that by initializing regulator pointer with an error value and
> checking it only against an error.
> 
> This makes code consistent and efficient.

There is usually something else wrong if you have to check for both.
Why exactly do you need to check for both IS_ERR and NULL?

> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index d7cd4e265766..146b6197d598 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -257,7 +257,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
>  	}
>  
>  	reg = dev_opp->regulator;
> -	if (IS_ERR_OR_NULL(reg)) {
> +	if (IS_ERR(reg)) {
>  		/* Regulator may not be required for device */
>  		if (reg)
>  			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
> @@ -798,6 +798,9 @@ static struct device_opp *_add_device_opp(struct device *dev)
>  		of_node_put(np);
>  	}
>  
> +	/* Set regulator to a non-NULL error value */
> +	dev_opp->regulator = ERR_PTR(-EFAULT);
> +
>  	/* Find clk for the device */
>  	dev_opp->clk = clk_get(dev, NULL);
>  	if (IS_ERR(dev_opp->clk)) {

-EFAULT has a very specific meaning (accessing an invalid pointer from
user space), I don't think you want that one.

	Arnd

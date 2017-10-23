From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq/exynos-bus: Use common error handling code in
 exynos_bus_target()
Date: Mon, 23 Oct 2017 10:17:07 +0900
Message-ID: <59ED4313.701@samsung.com>
References: <CGME20171022134057epcas4p43e6f37b8994c28f6ef240536349811a8@epcas4p4.samsung.com>
        <4a407cd6-020c-1750-019a-6c0ceb40e245@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13945 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbdJWBRK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 21:17:10 -0400
In-reply-to: <4a407cd6-020c-1750-019a-6c0ceb40e245@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Hi Markus,

As I already commented on your other patch related to extcon-max14577,
this patch might remove the redundant error message. But, it makes
the code more complicated in side of readability. I prefer existing code.

On 2017년 10월 22일 22:40, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Oct 2017 15:33:06 +0200
> 
> Adjust jump targets so that a bit of exception handling can be better
> reused at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/devfreq/exynos-bus.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 49f68929e024..e38d456b2d7d 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -124,34 +124,33 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>  
>  	if (old_freq < new_freq) {
>  		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
> -		if (ret < 0) {
> -			dev_err(bus->dev, "failed to set voltage\n");
> -			goto out;
> -		}
> +		if (ret < 0)
> +			goto report_failure;
>  	}
>  
>  	ret = clk_set_rate(bus->clk, new_freq);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to change clock of bus\n");
>  		clk_set_rate(bus->clk, old_freq);
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	if (old_freq > new_freq) {
>  		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
> -		if (ret < 0) {
> -			dev_err(bus->dev, "failed to set voltage\n");
> -			goto out;
> -		}
> +		if (ret < 0)
> +			goto report_failure;
>  	}
>  	bus->curr_freq = new_freq;
>  
>  	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>  			old_freq, new_freq, clk_get_rate(bus->clk));
> -out:
> +unlock:
>  	mutex_unlock(&bus->lock);
> -
>  	return ret;
> +
> +report_failure:
> +	dev_err(bus->dev, "failed to set voltage\n");
> +	goto unlock;
>  }
>  
>  static int exynos_bus_get_dev_status(struct device *dev,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

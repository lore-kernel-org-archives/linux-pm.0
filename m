From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 3/4] PM / devfreq: exynos-bus: add support for suspend OPP
Date: Thu, 24 Nov 2016 10:38:32 +0900
Message-ID: <58364498.50206@samsung.com>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <CGME20161123135254epcas3p450320a1f3187f749994add2a9a0284b5@epcas3p4.samsung.com>
 <1479909087-22659-4-git-send-email-tjakobi@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1479909087-22659-4-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Tobias,

On 2016년 11월 23일 22:51, Tobias Jakobi wrote:
> TODO: write desc
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/devfreq/exynos-bus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 29866f7..8a91970 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -335,6 +335,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>  			      struct exynos_bus *bus)
>  {
>  	struct device *dev = bus->dev;
> +	struct dev_pm_opp *suspend_opp;
>  	unsigned long rate;
>  	int ret;
>  
> @@ -368,6 +369,13 @@ static int exynos_bus_parse_of(struct device_node *np,
>  		ret = PTR_ERR(bus->curr_opp);
>  		goto err_opp;
>  	}
> +
> +	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
> +	if (suspend_opp) {
> +		bus->devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
> +		printk("DEBUG: suspend opp found!\n");
> +	}

Looks good to me. But, you have to move this code
in the exynos_bus_parent_parse_of() because the passive devfreq
don't need to get the suspend_opp. The suspend_opp is necessary
only for parent devfreq device.

If parent devfreq device change the frequency/voltage,
the passive devfreq device will change the their frequency/voltage
according to parent devfreq.

> +
>  	rcu_read_unlock();
>  
>  	return 0;
> 

-- 
Best Regards,
Chanwoo Choi

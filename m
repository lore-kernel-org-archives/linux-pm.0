From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Don't use OPP structures outside of
 RCU locks
Date: Fri, 02 Dec 2016 17:42:33 +0900
Message-ID: <584133F9.4080006@samsung.com>
References: <CGME20161201103813epcas4p116430ac17cea842a7f09b35f0969ccb0@epcas4p1.samsung.com>
 <22bf6dfc155a6a241c2ee4e2b44a615d0e82064d.1480588658.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60596 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757941AbcLBImf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 03:42:35 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHJ02H0KUU8JVA0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 02 Dec 2016 17:42:33 +0900 (KST)
In-reply-to: <22bf6dfc155a6a241c2ee4e2b44a615d0e82064d.1480588658.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

On 2016년 12월 01일 19:38, Viresh Kumar wrote:
> The OPP structures are abused to the best here, without understanding
> how the OPP core and RCU locks work.
> 
> In short, the OPP pointer saved in 'rk3399_dmcfreq' can become invalid
> under your nose, as the OPP core may free it.
> 
> Fix various abuses around OPP structures and calls.
> 
> Compile tested only.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> I would like it to go via the PM tree. Perhaps that's already the
> default tree for this.
> 
>  drivers/devfreq/rk3399_dmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 5063ac1a5939..cf14631b1945 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -80,7 +80,6 @@ struct rk3399_dmcfreq {
>  	struct regulator *vdd_center;
>  	unsigned long rate, target_rate;
>  	unsigned long volt, target_volt;
> -	struct dev_pm_opp *curr_opp;
>  };
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -102,9 +101,6 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	target_rate = dev_pm_opp_get_freq(opp);
>  	target_volt = dev_pm_opp_get_voltage(opp);
>  
> -	dmcfreq->rate = dev_pm_opp_get_freq(dmcfreq->curr_opp);
> -	dmcfreq->volt = dev_pm_opp_get_voltage(dmcfreq->curr_opp);
> -
>  	rcu_read_unlock();
>  
>  	if (dmcfreq->rate == target_rate)

dmcfreq->rate is used on here.
Maybe struct rk3399_dmcfreq need to add the new 'curr_freq' field.


> @@ -165,7 +161,9 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	if (err)
>  		dev_err(dev, "Cannot to set vol %lu uV\n", target_volt);
>  
> -	dmcfreq->curr_opp = opp;
> +	dmcfreq->rate = target_rate;
> +	dmcfreq->volt = target_volt;
> +
>  out:
>  	mutex_unlock(&dmcfreq->lock);
>  	return err;
> @@ -431,8 +429,9 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		rcu_read_unlock();
>  		return PTR_ERR(opp);
>  	}
> +	dmcfreq->rate = dev_pm_opp_get_freq(opp);
> +	dmcfreq->volt = dev_pm_opp_get_voltage(opp);
>  	rcu_read_unlock();
> -	data->curr_opp = opp;
>  
>  	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
>  
> 

-- 
Best Regards,
Chanwoo Choi

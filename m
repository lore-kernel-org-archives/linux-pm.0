From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Remove dangling rcu_read_unlock()
Date: Fri, 02 Dec 2016 17:43:59 +0900
Message-ID: <5841344F.807@samsung.com>
References: <CGME20161201104229epcas5p19eecb1b4fd77eef05ad8b4ee02f3267b@epcas5p1.samsung.com>
 <2958843865a6ed790ff9ecfc9cacd54d752cace5.1480588927.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44189 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755825AbcLBIoC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 03:44:02 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHJ010DVUWPWFB0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 02 Dec 2016 17:44:00 +0900 (KST)
In-reply-to: <2958843865a6ed790ff9ecfc9cacd54d752cace5.1480588927.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

On 2016년 12월 01일 19:42, Viresh Kumar wrote:
> This call never had the rcu_read_lock() counterpart. Remove the unlock
> part as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/devfreq/rk3399_dmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 192240423fee..4cc5be08720a 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -408,7 +408,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  	 */
>  	if (dev_pm_opp_of_add_table(dev)) {
>  		dev_err(dev, "Invalid operating-points in device tree.\n");
> -		rcu_read_unlock();
>  		return -EINVAL;
>  	}
>  
> 

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi

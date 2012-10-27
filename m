From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH -next] PM / OPP: using kfree_rcu() to simplify the code
Date: Fri, 26 Oct 2012 19:14:25 -0500
Message-ID: <20121027001425.GA28617@kahuna>
References: <CAPgLHd_HvceXF4pNhnrKH3px8h59S7zTwToAjAZzjCBm3AEmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43245 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934312Ab2J0AOn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Oct 2012 20:14:43 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd_HvceXF4pNhnrKH3px8h59S7zTwToAjAZzjCBm3AEmRw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

On 22:57-20121026, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The callback function of call_rcu() just calls a kfree(), so we
> can use kfree_rcu() instead of call_rcu() + callback function.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/base/power/opp.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index c8a908b..50b2831 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -461,17 +461,6 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
>  }
>  
>  /**
> - * opp_free_rcu() - helper to clear the struct opp when grace period has
> - * elapsed without blocking the the caller of opp_set_availability
> - */
> -static void opp_free_rcu(struct rcu_head *head)
> -{
> -	struct opp *opp = container_of(head, struct opp, head);
> -
> -	kfree(opp);
> -}
> -
> -/**
>   * opp_set_availability() - helper to set the availability of an opp
>   * @dev:		device for which we do this operation
>   * @freq:		OPP frequency to modify availability
> @@ -542,7 +531,7 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
>  
>  	list_replace_rcu(&opp->node, &new_opp->node);
>  	mutex_unlock(&dev_opp_list_lock);
> -	call_rcu(&opp->head, opp_free_rcu);
> +	kfree_rcu(opp, head);
>  
>  	/* Notify the change of the OPP availability */
>  	if (availability_req)
A good idea. thanks.
I wonder if we might squash this with
https://patchwork.kernel.org/patch/1504361/
on a side note:
struct opp {
	struct list_head node;

	bool available;
	unsigned long rate;
	unsigned long u_volt;

	struct device_opp *dev_opp;
	struct rcu_head;
};
we could move rcu_head to the top of the struct .. just to avoid
revisiting this at a later point in time *if* struct opp expands..

If we are squashing it, we might consider fixing the kern-doc for
"head"..
-- 
Regards,
Nishanth Menon

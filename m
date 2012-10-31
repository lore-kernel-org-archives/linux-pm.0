From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -next] PM / OPP: using kfree_rcu() to simplify the code
Date: Wed, 31 Oct 2012 01:43:47 +0100
Message-ID: <9532043.CirjgQiJQ8@vostro.rjw.lan>
References: <CAPgLHd_HvceXF4pNhnrKH3px8h59S7zTwToAjAZzjCBm3AEmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47269 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932758Ab2JaAjo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Oct 2012 20:39:44 -0400
In-Reply-To: <CAPgLHd_HvceXF4pNhnrKH3px8h59S7zTwToAjAZzjCBm3AEmRw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

On Friday, October 26, 2012 10:57:41 PM Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The callback function of call_rcu() just calls a kfree(), so we
> can use kfree_rcu() instead of call_rcu() + callback function.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied to the linux-next branch of linux-pm.git as v3.8 material.

Thanks,
Rafael


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
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

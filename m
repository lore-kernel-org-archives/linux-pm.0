From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] opp: set new_opp->dev_opp to a valid dev_opp
Date: Thu, 11 Dec 2014 00:01:49 +0100
Message-ID: <3587930.6xX0Y3mfAI@vostro.rjw.lan>
References: <92ee61e091ccc336e6937f7af093f7ce569f5485.1418104004.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59790 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932623AbaLJWkN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 17:40:13 -0500
In-Reply-To: <92ee61e091ccc336e6937f7af093f7ce569f5485.1418104004.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tuesday, December 09, 2014 11:18:51 AM Viresh Kumar wrote:
> We find/allocate dev_opp after using its value to fill new_opp->dev_opp right
> now. Move this to a later point where dev_opp is valid.
> 
> Fixes: a7470db6fec4 ("PM / OPP don't match for existing OPPs when list is empty")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

> ---
>  drivers/base/power/opp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 2d195f3a1998..c2020520b2bf 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -400,7 +400,6 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
>  	mutex_lock(&dev_opp_list_lock);
>  
>  	/* populate the opp table */
> -	new_opp->dev_opp = dev_opp;
>  	new_opp->rate = freq;
>  	new_opp->u_volt = u_volt;
>  	new_opp->available = true;
> @@ -460,6 +459,7 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
>  	}
>  
>  list_add:
> +	new_opp->dev_opp = dev_opp;
>  	list_add_rcu(&new_opp->node, head);
>  	mutex_unlock(&dev_opp_list_lock);
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

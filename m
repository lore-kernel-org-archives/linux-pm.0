From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Fri, 09 Feb 2018 12:56:50 +0100
Message-ID: <66016771.HTTzQvm2zL@aspire.rjw.lan>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:58682 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeBIL6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 06:58:34 -0500
In-Reply-To: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, khilman@kernel.org, ulf.hansson@linaro.org
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, January 26, 2018 9:38:19 AM CET Jia-Ju Bai wrote:
> After checking all possible call chains to genpd_dev_pm_detach() and
> genpd_dev_pm_attach() here,
> my tool finds that these functions are never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> Thus mdelay can be replaced with msleep to avoid busy wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/base/power/domain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0c80bea..f84ac72 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  		if (ret != -EAGAIN)
>  			break;
>  
> -		mdelay(i);
> +		msleep(i);
>  		cond_resched();
>  	}
>  
> @@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  		if (ret != -EAGAIN)
>  			break;
>  
> -		mdelay(i);
> +		msleep(i);
>  		cond_resched();
>  	}
>  	mutex_unlock(&gpd_list_lock);
> 

Ulf, Kevin, any concerns or objections?

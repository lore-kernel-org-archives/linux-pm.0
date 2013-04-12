From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Runtime: Improve prepare handling at system suspend for genpd
Date: Fri, 12 Apr 2013 13:50:36 +0200
Message-ID: <1844674.ZBv3XGts1U@vostro.rjw.lan>
References: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56966 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab3DLLms (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Apr 2013 07:42:48 -0400
In-Reply-To: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

On Friday, April 12, 2013 11:41:44 AM Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> When genpd prepares for a system suspend it will fetch a runtime
> reference for the device. When returning it we now use the
> asyncronous runtime PM API. Thus we don't have to wait for the
> device to become idle|suspended before we move on and handle the
> next device in queue.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>

All three patches applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
>  drivers/base/power/domain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a6b05a..e6ec4a7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -920,7 +920,7 @@ static int pm_genpd_prepare(struct device *dev)
>  		pm_wakeup_event(dev, 0);
>  
>  	if (pm_wakeup_pending()) {
> -		pm_runtime_put_sync(dev);
> +		pm_runtime_put(dev);
>  		return -EBUSY;
>  	}
>  
> @@ -961,7 +961,7 @@ static int pm_genpd_prepare(struct device *dev)
>  		pm_runtime_enable(dev);
>  	}
>  
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_put(dev);
>  	return ret;
>  }
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

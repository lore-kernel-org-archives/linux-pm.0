From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] pm: make device_prepare() use dpm_run_callback()
Date: Thu, 13 Jun 2013 20:12:38 +0200
Message-ID: <6990358.bdIEejFSap@vostro.rjw.lan>
References: <1371133239-12054-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36304 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab3FMSD2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 13 Jun 2013 14:03:28 -0400
In-Reply-To: <1371133239-12054-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

On Thursday, June 13, 2013 04:20:39 PM Sebastian Andrzej Siewior wrote:
> After looking at device_prepare() I was curious why the info parameter
> isn't used. Then I noticed that others call dpm_run_callback() which
> takes the info parameter and is actually doing something with it and it
> does the same (cb) check as here.
> So maybe, maybe the intention here was to use the function in the first
> place.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

No, it wasn't.

We've just discussed a similar patch on linux-pm, please look into the
archives.

Thanks,
Rafael


> ---
>  drivers/base/power/main.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 5a9b656..521029e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1223,7 +1223,7 @@ int dpm_suspend(pm_message_t state)
>   */
>  static int device_prepare(struct device *dev, pm_message_t state)
>  {
> -	int (*callback)(struct device *) = NULL;
> +	pm_callback_t callback = NULL;
>  	char *info = NULL;
>  	int error = 0;
>  
> @@ -1261,10 +1261,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  		callback = dev->driver->pm->prepare;
>  	}
>  
> -	if (callback) {
> -		error = callback(dev);
> -		suspend_report_result(callback, error);
> -	}
> +	error = dpm_run_callback(callback, dev, state, info);
>  
>  	device_unlock(dev);
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

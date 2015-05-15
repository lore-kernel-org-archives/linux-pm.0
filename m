From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] power: validate wakeup source before activating it.
Date: Fri, 15 May 2015 02:22:01 +0200
Message-ID: <1816596.LjGsP0DkBO@vostro.rjw.lan>
References: <1430951216-3003-1-git-send-email-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53436 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1423067AbbENX4t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:56:49 -0400
In-Reply-To: <1430951216-3003-1-git-send-email-jinqian@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, May 06, 2015 03:26:56 PM Jin Qian wrote:
> A rogue wakeup source not registered in wakeup_sources list is not visible
> from wakeup_sources_stats_show. Check if the wakeup source is registered
> properly by looking at the timer struct.
> 
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  drivers/base/power/wakeup.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7726200..7b5ad9a 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -351,6 +351,20 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>  
> +/**
> + * wakeup_source_not_registered - validate the given wakeup source.
> + * @ws: Wakeup source to be validated.
> + */
> +static bool wakeup_source_not_registered(struct wakeup_source *ws)
> +{
> +	/*
> +	 * Use timer struct to check if the given source is initialized
> +	 * by wakeup_source_add.
> +	 */
> +	return ws->timer.function != pm_wakeup_timer_fn ||
> +		   ws->timer.data != (unsigned long)ws;
> +}
> +
>  /*
>   * The functions below use the observation that each wakeup event starts a
>   * period in which the system should not be suspended.  The moment this period
> @@ -391,6 +405,10 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  {
>  	unsigned int cec;
>  
> +	if (WARN_ONCE(wakeup_source_not_registered(ws),
> +			"unregistered wakeup source\n"))
> +		return;
> +
>  	/*
>  	 * active wakeup source should bring the system
>  	 * out of PM_SUSPEND_FREEZE state

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

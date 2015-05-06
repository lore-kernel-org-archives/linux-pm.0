From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] power: validate wakeup source before activating it.
Date: Thu, 07 May 2015 00:00:44 +0200
Message-ID: <2043095.ifDvYKem54@vostro.rjw.lan>
References: <1430938267-14951-1-git-send-email-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430938267-14951-1-git-send-email-jinqian@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 06, 2015 11:51:07 AM Jin Qian wrote:
> A rogue wakeup source not registered in wakeup_sources list is not visible
> from wakeup_sources_stats_show. Check if the wakeup source is registered
> properly by looking at the timer struct.
> 
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  drivers/base/power/wakeup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7726200..aead738 100644
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
> @@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  {
>  	unsigned int cec;
>  
> +	if (WARN_ONCE(wakeup_source_not_registered(ws),
> +			"unregistered wakeup source\n")) {
> +		return;
> +	}

The braces are not necessary and you can use format strings with WARN_ONCE()
too IIRC.

> +
>  	/*
>  	 * active wakeup source should bring the system
>  	 * out of PM_SUSPEND_FREEZE state
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

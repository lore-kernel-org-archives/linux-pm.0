From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] power: validate wakeup source before activating it.
Date: Wed, 06 May 2015 01:16:54 +0200
Message-ID: <15414731.3GD5zMQpzQ@vostro.rjw.lan>
References: <1430864653-5582-1-git-send-email-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58044 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754382AbbEEWvx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 18:51:53 -0400
In-Reply-To: <1430864653-5582-1-git-send-email-jinqian@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, May 05, 2015 03:24:13 PM Jin Qian wrote:
> A rogue wakeup source not registered in wakeup_sources list is not visible
> from wakeup_sources_stats_show. Check if the wakeup source is registered
> properly by looking at the timer function.
> 
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  drivers/base/power/wakeup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7726200..5d866b9 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -14,6 +14,7 @@
>  #include <linux/suspend.h>
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
> +#include <linux/types.h>

What's that for?

>  #include <trace/events/power.h>
>  
>  #include "power.h"
> @@ -351,6 +352,19 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>  
> +/**
> + * validate_wakeup_source - validate the given wakeup source.
> + * @ws: Wakeup source to be validated.
> + */
> +static bool validate_wakeup_source(struct wakeup_source *ws)

I would call that wakeup_source_not_registered() and do the reverse check.
The extra logical negation below wouldn't be necessary then.

> +{
> +	/*
> +	 * Use timer function to check if the given source is initialized
> +	 * by wakeup_source_add.
> +	 */
> +	return ws->timer.function == pm_wakeup_timer_fn;

You can also verify if timer.data is equal to ws.

> +}
> +
>  /*
>   * The functions below use the observation that each wakeup event starts a
>   * period in which the system should not be suspended.  The moment this period
> @@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  {
>  	unsigned int cec;
>  
> +	if (WARN_ON(!validate_wakeup_source(ws))) {

WARN_ONCE() would be better, so you can make it print the message and you
won't need the extra statement.

> +		pr_err("unregistered wakeup source: %s\n", ws->name);
> +		return;
> +	}
> +
>  	/*
>  	 * active wakeup source should bring the system
>  	 * out of PM_SUSPEND_FREEZE state
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

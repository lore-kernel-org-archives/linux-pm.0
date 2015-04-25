From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] power: validate wakeup source before activating it.
Date: Sat, 25 Apr 2015 22:12:25 +0200
Message-ID: <20150425201225.GB3008@amd>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
 <1429750212-28659-2-git-send-email-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37420 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbDYUM3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2015 16:12:29 -0400
Content-Disposition: inline
In-Reply-To: <1429750212-28659-2-git-send-email-jinqian@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed 2015-04-22 17:50:10, Jin Qian wrote:
> A rogue wakeup source not registered in wakeup_sources list is not visible
> from wakeup_sources_stats_show. Check if the wakeup source is registered
> properly by looking at the timer function.

How often does that happen?

Will people on your systems actually notice that pr_err()?
								Pavel

> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  drivers/base/power/wakeup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7726200..f24c622 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -14,6 +14,7 @@
>  #include <linux/suspend.h>
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
> +#include <linux/types.h>
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
> +{
> +	/*
> +	 * Use timer function to check if the given source is initialized
> +	 * by wakeup_source_add.
> +	 */
> +	return ws->timer.function == pm_wakeup_timer_fn;
> +}
> +
>  /*
>   * The functions below use the observation that each wakeup event starts a
>   * period in which the system should not be suspended.  The moment this period
> @@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  {
>  	unsigned int cec;
>  
> +	if (!validate_wakeup_source(ws)) {
> +		pr_err("unregistered wakeup source: %s\n", ws->name);
> +		return;
> +	}
> +
>  	/*
>  	 * active wakeup source should bring the system
>  	 * out of PM_SUSPEND_FREEZE state

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

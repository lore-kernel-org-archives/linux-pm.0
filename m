From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: print function name of callbacks
Date: Sun, 4 Oct 2015 17:15:59 +0200
Message-ID: <20151004151559.GC12607@xo-6d-61-c0.localdomain>
References: <1442942797-17433-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50444 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbJDPQH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Oct 2015 11:16:07 -0400
Content-Disposition: inline
In-Reply-To: <1442942797-17433-1-git-send-email-dianders@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: rjw@rjwysocki.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue 2015-09-22 10:26:37, Douglas Anderson wrote:
> The printouts writen to the logs by suspend can be a bit opaque: it can
> be hard to track them down to the actual function called.  You might
> see:

It seems simple enough.

Acked-by: Pavel Machek <pavel@ucw.cz>

> +static ktime_t initcall_debug_start(struct device *dev, void *cb)
>  {
>  	ktime_t calltime = ktime_set(0, 0);
>  
>  	if (pm_print_times_enabled) {
> -		pr_info("calling  %s+ @ %i, parent: %s\n",
> +		pr_info("calling  %s+ @ %i, parent: %s, cb: %pf\n",
>  			dev_name(dev), task_pid_nr(current),
> -			dev->parent ? dev_name(dev->parent) : "none");
> +			dev->parent ? dev_name(dev->parent) : "none", cb);
>  		calltime = ktime_get();
>  	}
>  
> @@ -382,7 +382,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
>  	if (!cb)
>  		return 0;
>  
> -	calltime = initcall_debug_start(dev);
> +	calltime = initcall_debug_start(dev, cb);
>  
>  	pm_dev_dbg(dev, state, info);
>  	trace_device_pm_callback_start(dev, info, state.event);
> @@ -1324,7 +1324,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
>  	int error;
>  	ktime_t calltime;
>  
> -	calltime = initcall_debug_start(dev);
> +	calltime = initcall_debug_start(dev, cb);
>  
>  	trace_device_pm_callback_start(dev, info, state.event);
>  	error = cb(dev, state);
> -- 
> 2.6.0.rc0.131.gf624c3d

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

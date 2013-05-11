From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCHv2 2/2] PM: compile-time configuration of device
 suspend/resume watchdogs.
Date: Sat, 11 May 2013 11:28:07 +0200
Message-ID: <20130511092807.GB10045@amd.pavel.ucw.cz>
References: <1368221329-1841-1-git-send-email-zoran.markovic@linaro.org>
 <1368221329-1841-3-git-send-email-zoran.markovic@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368221329-1841-3-git-send-email-zoran.markovic@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zoran Markovic <zoran.markovic@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>, Colin Cross <ccross@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, Benoit Goby <benoit@android.com>, John Stultz <john.stultz@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Power management debug option to configure device suspend/resume watchdogs.
> Available options are:
>   1. Enable/disable the feature.
>   2. Select triggered watchdog action between:
>         - system panic (default)
>         - dump stacktrace
>         - log event
>   3. Select timeout value for the watchdog(s).

People disliked the previous behaviour, so you add 10 config
options... with different behaviours. Also 1 second timeout is not
acceptable for endusers (will break the system), so it should not be
offered. In fact, remove that option, too. People doing that kind of
debugging can modify the sources, right?

(Maybe it would make sense to do same action regular watchdog does,
but...)

That's not the way to go. If "panic" is right behaviour, just go with
panic.

> @@ -402,13 +422,9 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
>  static void dpm_wd_handler(unsigned long data)
>  {
>  	struct dpm_watchdog *wd = (void *)data;
> -	struct device *dev      = wd->dev;
> -	struct task_struct *tsk = wd->tsk;
> -
> -	dev_emerg(dev, "**** DPM device timeout ****\n");
> -	show_stack(tsk, NULL);
>  
> -	BUG();
> +	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> +	dpm_wd_action(wd);
>  }
>  
>  /**

And merge this to previous patch. Introducing the code then redoing it
in next patch does not help review.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

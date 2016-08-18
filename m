From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH][RFC v4] timekeeping: ignore the bogus sleep time if
 pm_trace is enabled
Date: Thu, 18 Aug 2016 12:36:51 +0200
Message-ID: <1471516611.2157.22.camel@suse.com>
References: <1471517019-15216-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36005 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcHRKlm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Aug 2016 06:41:42 -0400
In-Reply-To: <1471517019-15216-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Xunlei Pang <xlpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

On Thu, 2016-08-18 at 18:43 +0800, Chen Yu wrote:
> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, please refer to:
> https://patchwork.kernel.org/patch/9286365/
> It's improper in the first place to call __timekeeping_inject_sleeptime()
> in case that pm_trace is enabled simply because that "hash" time value
> will wreckage the timekeeping subsystem.

Hi,

do you know since when this bug exists?

>  /**
> @@ -1662,6 +1668,12 @@ void timekeeping_resume(void)
>  	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
>  		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
>  		sleeptime_injected = true;
> +		/*
> +		 * If rtc is used as persist clock thus it
> +		 * would be bogus when pm_trace is enabled.
> +		 */
> +		if (!persistent_clock_is_usable())
> +			sleeptime_injected = false;
>  	}
>  
>  	if (sleeptime_injected)

How about

sleeptime_injected = persistent_clock_is_usable();

	Regards
		Oliver



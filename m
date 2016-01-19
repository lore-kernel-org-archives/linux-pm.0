From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v1] refining the rpm_suspend function
Date: Tue, 19 Jan 2016 20:54:12 +0100
Message-ID: <20160119195412.GA8414@amd>
References: <1453194858-17416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56225 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208AbcASTyP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 14:54:15 -0500
Content-Disposition: inline
In-Reply-To: <1453194858-17416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: zhaoyang.huang@spreadtrum.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

Hi!

> +		else{

missing space.

> +			while (dev->power.runtime_status ==
> +				RPM_SUSPENDING) {
> +				if (dev->power.irq_safe) {
> +					spin_unlock(&dev->power.lock);
> +
> +					cpu_relax();
> +
> +					spin_lock(&dev->power.lock);
> +					continue;
> +				}
> +
> +				/* Wait for the other suspend
> +				running in parallel with us. */
> +				for (;;) {
> +					prepare_to_wait(&dev->power.wait_queue,
> +					&wait,	TASK_UNINTERRUPTIBLE);
> +					if (dev->power.runtime_status
> +						!= RPM_SUSPENDING)
> +						break;

You really need to restructure the code so that you don't get
indentation _this_ deep.


> -	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);
> +	might_sleep_if (!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe);

Original was right. Function -> no space.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

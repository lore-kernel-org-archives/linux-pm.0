From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V3 11/11] power: charger-manager: Support to change
 polling rate in runtime.
Date: Sat, 20 Dec 2014 01:29:08 +0100
Message-ID: <20141220002908.GD1694@amd>
References: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
 <1418979323-7188-12-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46598 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaLTA3M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 19:29:12 -0500
Content-Disposition: inline
In-Reply-To: <1418979323-7188-12-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com


> Add 'polling_ms' sysfs node to change charger-manager's monitoring rate
> in runtime. It can set only bigger than 2 jiffies (for 200 HZ system it
> is 10 msecs.) as it's allowed for minimum poling rate in previous.

New sysfs filesneed documentation.

> It resets poller and re-configure polling rate based on new input if next

re-configures...", if"

> polling time is far enough. Otherwise, it just waits expiration of timer

"waits for"

> and new polling rate will affects the next scheduling.

"affect"?


> +static ssize_t show_polling_ms(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct charger_manager *cm;
> +	ssize_t len;
> +
> +	list_for_each_entry(cm, &cm_list, entry)
> +		if (cm->charger_psy.dev == dev)
> +			break;
> +
> +	if (cm->charger_psy.dev != dev)
> +		return -EINVAL;

Any chance to reorganize data structures so that this kind of list
walking is not neccessary?

> +static ssize_t store_polling_ms(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	struct charger_manager *cm;
> +	int polling_ms;
> +	int ret;
> +
> +	ret = sscanf(buf, "%d", &polling_ms);

"kstrtoul"?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

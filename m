From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 07/19] cpufreq: assert locking when accessing
 cpufreq_governor_list
Date: Tue, 12 Jan 2016 15:31:22 +0530
Message-ID: <20160112100122.GY1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-8-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32939 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933472AbcALKB1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 05:01:27 -0500
Received: by mail-pf0-f170.google.com with SMTP id e65so60708859pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 02:01:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452533760-13787-8-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 11-01-16, 17:35, Juri Lelli wrote:
> @@ -2025,6 +2027,7 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
>  	err = -EBUSY;
>  	if (!find_governor(governor->name)) {
>  		err = 0;
> +		lockdep_assert_held(&cpufreq_governor_mutex);
>  		list_add(&governor->governor_list, &cpufreq_governor_list);
>  	}

Why here? This is how the routine looks like:

int cpufreq_register_governor(struct cpufreq_governor *governor)
{
	int err;

	if (!governor)
		return -EINVAL;

	if (cpufreq_disabled())
		return -ENODEV;

	mutex_lock(&cpufreq_governor_mutex);

	governor->initialized = 0;
	err = -EBUSY;
	if (!find_governor(governor->name)) {
		err = 0;
		list_add(&governor->governor_list, &cpufreq_governor_list);
	}

	mutex_unlock(&cpufreq_governor_mutex);
	return err;
}


-- 
viresh

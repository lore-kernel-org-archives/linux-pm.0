From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 08/19] cpufreq: fix warning for cpufreq_init_policy
 unlocked access to cpufreq_governor_list
Date: Mon, 18 Jan 2016 10:53:36 +0530
Message-ID: <20160118052336.GB30762@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
 <20160112100945.GZ1084@ubuntu>
 <20160112155200.GC18734@e106622-lin>
 <20160113060746.GI6050@ubuntu>
 <20160114163511.GA4246@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36460 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcARFXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 00:23:39 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so335157517pab.3
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2016 21:23:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160114163511.GA4246@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 14-01-16, 16:35, Juri Lelli wrote:
> But, don't we have to guarantee consinstency between multiple operations
> on cpufreq_governor_list?
> 
> In cpufreq_register_governor() we have:
> 
>  mutex_lock(&cpufreq_governor_mutex);
>  
>  governor->initialized = 0;
>  err = -EBUSY;
>  if (!find_governor(governor->name)) {
>  	err = 0;
>  	list_add(&governor->governor_list, &cpufreq_governor_list);
>  }
>  
>  mutex_unlock(&cpufreq_governor_mutex);
> 
> IIUC, find_governor and list_add have to be atomic. Couldn't someone
> slip in right after find_governor and add the same governor to the list?

Yeah, I was wrong that cpufreq_register_governor() doesn't need a
lock. We already have that in place ..

But most of the other places are really useless and shows that we
haven't implemented it well.

I would suggest that we move the lock within find_governor() and
create another find_governor_unlocked() or __find_governor() that will
be used only from cpufreq_register_governor(), with an outer lock.

Looks reasonable ?

-- 
viresh

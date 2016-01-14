From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 08/19] cpufreq: fix warning for cpufreq_init_policy
 unlocked access to cpufreq_governor_list
Date: Thu, 14 Jan 2016 16:35:11 +0000
Message-ID: <20160114163511.GA4246@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
 <20160112100945.GZ1084@ubuntu>
 <20160112155200.GC18734@e106622-lin>
 <20160113060746.GI6050@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47783 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbcANQev (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jan 2016 11:34:51 -0500
Content-Disposition: inline
In-Reply-To: <20160113060746.GI6050@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 13/01/16 11:37, Viresh Kumar wrote:
> On 12-01-16, 15:52, Juri Lelli wrote:
> > Other users (i.e., cpufreq_parse_governor and cpufreq_register_governor)
> > needs to take the mutex externally. So, we need to unify this behaviour.
> 
> No they don't have to.
> 
> And that's why I have been saying that we better nail down the exact
> thing the mutex is supposed to protect.
> 
> There can be two cases here:
> - It protects the governor list, in that case we can move it to
>   find_governor().
> - It guarantees that the governor pointer stays valid: That's not true
>   as we are using the governor pointer outside of the lock.
> 
> And so I said, "No they don't have to" :)
> 

But, don't we have to guarantee consinstency between multiple operations
on cpufreq_governor_list?

In cpufreq_register_governor() we have:

 mutex_lock(&cpufreq_governor_mutex);
 
 governor->initialized = 0;
 err = -EBUSY;
 if (!find_governor(governor->name)) {
 	err = 0;
 	list_add(&governor->governor_list, &cpufreq_governor_list);
 }
 
 mutex_unlock(&cpufreq_governor_mutex);

IIUC, find_governor and list_add have to be atomic. Couldn't someone
slip in right after find_governor and add the same governor to the list?

Thanks,

- Juri

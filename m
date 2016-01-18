From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 08/19] cpufreq: fix warning for cpufreq_init_policy
 unlocked access to cpufreq_governor_list
Date: Mon, 18 Jan 2016 15:19:38 +0000
Message-ID: <20160118151938.GF7159@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
 <20160112100945.GZ1084@ubuntu>
 <20160112155200.GC18734@e106622-lin>
 <20160113060746.GI6050@ubuntu>
 <20160114163511.GA4246@e106622-lin>
 <20160118052336.GB30762@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35187 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbcARPTM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jan 2016 10:19:12 -0500
Content-Disposition: inline
In-Reply-To: <20160118052336.GB30762@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 18/01/16 10:53, Viresh Kumar wrote:
> On 14-01-16, 16:35, Juri Lelli wrote:
> > But, don't we have to guarantee consinstency between multiple operations
> > on cpufreq_governor_list?
> > 
> > In cpufreq_register_governor() we have:
> > 
> >  mutex_lock(&cpufreq_governor_mutex);
> >  
> >  governor->initialized = 0;
> >  err = -EBUSY;
> >  if (!find_governor(governor->name)) {
> >  	err = 0;
> >  	list_add(&governor->governor_list, &cpufreq_governor_list);
> >  }
> >  
> >  mutex_unlock(&cpufreq_governor_mutex);
> > 
> > IIUC, find_governor and list_add have to be atomic. Couldn't someone
> > slip in right after find_governor and add the same governor to the list?
> 
> Yeah, I was wrong that cpufreq_register_governor() doesn't need a
> lock. We already have that in place ..
> 
> But most of the other places are really useless and shows that we
> haven't implemented it well.
> 
> I would suggest that we move the lock within find_governor() and
> create another find_governor_unlocked() or __find_governor() that will
> be used only from cpufreq_register_governor(), with an outer lock.
> 
> Looks reasonable ?
> 

Yes it does. I'll look into doing that.

Thanks,

- Juri

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race
 conditions
Date: Tue, 2 Jun 2015 12:37:08 +0530
Message-ID: <20150602070708.GG10443@linux>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com>
 <20150601071934.GC4242@linux>
 <556D3FAA.3080703@linux.vnet.ibm.com>
 <20150602053956.GD10443@linux>
 <556D4748.7040105@linux.vnet.ibm.com>
 <20150602061133.GE10443@linux>
 <556D4B32.3000407@linux.vnet.ibm.com>
 <20150602062724.GF10443@linux>
 <556D53A0.1050109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556D53A0.1050109@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02-06-15, 12:26, Preeti U Murthy wrote:
> dbs_data->mutex_lock is used to serialize only START,STOP,LIMIT calls.
> It does not serialize EXIT/INIT with these operations, but that is

Yeah, we need to fix that.

To be honest, locking is in real bad shape in cpufreq core and its
required to get it fixed. I had some patches and was waiting for my
current series to get applied first, which would make life simpler.

> understandable. We need to note that EXIT can proceed in parallel with
> START/STOP/LIMIT operations which can result in null pointer
> dereferences of dbs_data.

That should be fixed, yeah.

> Yet again, this is due to the reason that you pointed out. One such case
> is __cpufreq_remove_dev_finish(). It also drops policy locks before
> calling into START/LIMIT. So this can proceed in parallel with an EXIT
> operation from a store. So dbs_data->mutex does not help serialize these
> two and START can refer a freed dbs_data. Consider the scenario today
> where CPUFREQ_HAVE_GOVERNOR_PER_POLICY is set itself.
> 
> CPU0					CPU1
> 
> cpufreq_set_policy()
> 
> __cpufreq_governor
> (CPUFREQ_GOV_POLICY_EXIT)
> since the only usage
> becomes 0.
> 				__cpufreq_remove_dev_finish()
> 
> free(dbs_data)			__cpufreq_governor
> 				(CPUFRQ_GOV_START)
> 
> 				dbs_data->mutex <= NULL dereference
> 
> This is what we hit initially.

That's why we shouldn't drop policy->rwsem lock at all for calling
governor-thing..

> So we will need the policy wide lock even for those drivers that have a
> governor per policy, before calls to __cpufreq_governor() in order to
> avoid such scenarios. So, your patch at

For all drivers actually.

> https://git.linaro.org/people/viresh.kumar/linux.git/patch/57714d5b1778f2f610bcc5c74d85b29ba1cc1995
> can lead to above races between different store operations themselves,
> won't it ?

Not sure, and I am not in real good touch right now around locking in
cpufreq core, need to spend enough time on that before getting that
resolved.

But the above patch + all the patches in that branch:
cpufreq/core/locking were an attempt to get the ABBA thing out of the
way. But I was still getting those warnings. One of the issues I faced
was that I never saw these ABBA warnings on my hardware :( and so was
difficult to get this tested.

> An EXIT on one of the policy cpus, followed by a STOP on
> another will lead to null dereference of dbs_data(For
> GOVERNOR_PER_POLICY). Today stores are serialized through the policy lock.
> 
> Anyway, since taking the policy lock leads to ABBA deadlock and

We need to solve this ABBA problem first. And things will simplify
then.

-- 
viresh

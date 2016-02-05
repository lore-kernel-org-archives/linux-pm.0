From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Fri, 5 Feb 2016 15:19:25 +0530
Message-ID: <20160205094925.GN21792@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <56B38E14.5060705@codeaurora.org>
 <CAJZ5v0hG2CickrbnTn8qJdFHJZ4cuZg1nxJ=8OXN8YFuw=qSFQ@mail.gmail.com>
 <3866963.E19P3EGEHd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3866963.E19P3EGEHd@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Shilpa Bhat <shilpabhatppc@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 04:54, Rafael J. Wysocki wrote:
> Having actually posted that series again after cleaning it up I can say
> what I'm thinking about hopefully without confusing anyone too much.  So
> please bear in mind that I'm going to refer to this series below:
> 
> http://marc.info/?l=linux-pm&m=145463901630950&w=4
> 
> Also this is more of a brain dump rather than actual design description,
> so there may be holes etc in it.  Please let me know if you can see any.
> 
> The problem at hand is that policy->rwsem needs to be held around *all*
> operations in cpufreq_set_policy().  In particular, it cannot be dropped
> around invocations of __cpufreq_governor() with the event arg equal to
> _EXIT as that leads to interesting races.
> 
> Unfortunately, we know that holding policy->rwsem in those places leads
> to a deadlock with governor sysfs attributes removal in cpufreq_governor_exit().
> 
> Viresh attempted to fix this by avoiding to acquire policy->rwsem for governor
> attributes access (as holding it is not necessary for them in principle).  That
> was a nice try, but it turned out to be insufficient because of another deadlock
> scenario uncovered by it.

Not really.

The other deadlock wasn't uncovered by it, its just that Shilpa tested
directly after my patches and reported the issue. Later yesterday, she
was hitting the exactly same issue on pm/linux-next as well (i.e.
without my patches). And ofcourse Juri has also reported the same
issue on linux-next few days back.

> Namely, since the ondemand governor's update_sampling_rate()
> acquires the governor mutex (called dbs_data_mutex after my patches mentioned
> above), it may deadlock with exactly the same piece of code in cpufreq_governor_exit()
> in almost exactly the same way.

Right.

> To avoid that other deadlock, we'd either need to drop dbs_data_mutex from
> update_sampling_rate(),

And my so called 'ugly' 8th patch tried to do just that :)

But as I also mentioned in reply to the update-util patchset of yours,
its possible somewhat.

> or drop it for the removal of the governor sysfs
> attributes in cpufreq_governor_exit().  I don't think the former is an option
> at least at this point, so it looks like we pretty much have to do the latter.
> 
> With that in mind, I'd start with the changes made by Viresh (maybe without the
> first patch which really isn't essential here).

That was just to cleanup the macro mess a bit, nothing more. Over
that, I think the first 7 patches can be picked as it is without any
changes. Ofcourse they are required to be rebased over your 13
patches, if those are going in first :)

> That is, introduce a separate
> kobject type for the governor attributes kobject and register that in
> cpufreq_governor_init().  The show/store callbacks for that kobject type won't
> acquire policy->rwsem so the first deadlock will be avoided.
> 
> But in addition to that, I'd drop dbs_data_mutex before the removal of governor
> sysfs attributes.  That actually happens in two places, in cpufreq_governor_exit()
> and in the error path of cpufreq_governor_init().
> 
> To that end, I'd move the locking from cpufreq_governor_dbs() to the functions
> called by it.  That should be readily doable and they can do all of the
> necessary checks themselves.  cpufreq_governor_dbs() would become a pure mux then,
> but that's not such a big deal.
> 
> With that, cpufreq_governor_exit() may just drop the lock before it does the
> final kobject_put().  The danger here is that the sysfs show/store callbacks of
> the governor attributes kobject may see invalid dbs_data for a while, after the
> lock has been dropped and before the kobject is deleted.  That may be addressed
> by checking, for example, the presence of the dbs_data's "tuners" pointer in those
> callbacks.  If it is NULL, they can simply return -EAGAIN or similar.

So you mean something like this (consider only !governor_per_policy
case with ondemand governor for now):

exit()
{
       lock-dbs_data_mutex;
       ...
       dbs_data->tuners = NULL; //so that sysfs files can return early
       dbs_governor->gdbs_data = NULL; //For !governor_per_policy case
       unlock-dbs_data_mutex;

       /*
        * Problem: Who is stopping us to set ondemand as governor for
        * another policy, which can try create a kobject which will
        * try to create sysfs directory at the same path ?
        *
        * Though another field in dbs_governor can be used to fix this
        * I think, which needs to block the other INIT operation.
        */
        
       kobject_put(dbs_data->kobj); //This should wait for all sysfs operations to end.

       kfree(dbs_data);
}

And the sysfs operations show/store need to take dbs_data_mutex() for
their entire operations.

??

-- 
viresh

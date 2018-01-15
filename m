From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] thermal: Add cooling device's statistics in sysfs
Date: Mon, 15 Jan 2018 10:16:16 +0530
Message-ID: <20180115044616.GC22978@vireshk-i7>
References: <087186fecdfd85bead58e110cf8bf7ccdfab517b.1515663078.git.viresh.kumar@linaro.org>
 <20180112174606.GA11076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37679 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeAOEqT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jan 2018 23:46:19 -0500
Received: by mail-pg0-f66.google.com with SMTP id z17so7422867pgc.4
        for <linux-pm@vger.kernel.org>; Sun, 14 Jan 2018 20:46:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180112174606.GA11076@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12-01-18, 09:46, Eduardo Valentin wrote:
> On Thu, Jan 11, 2018 at 03:06:09PM +0530, Viresh Kumar wrote:
> > $ ls -R /sys/class/thermal/cooling_device0/
> > /sys/class/thermal/cooling_device0/:
> > cur_state  max_state  power  stats  subsystem  type  uevent
> > 
> > /sys/class/thermal/cooling_device0/power:
> > autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> > control               runtime_status
> > 
> > /sys/class/thermal/cooling_device0/stats:
> > reset  time_in_state_ms  total_trans
> > 
> 
> I guess the only missing node from the cpufreq design copy was the
> transition table.

I don't think it would be very useful here and so didn't add it.

> Also, I think the stats per thermal zone is also useful, sometimes
> more than per cooling device, as I have been using in
> the past, but that is just a comment, not really to block your patch.

Sure, that can be added in a separate patch. What kind of stats are you
expecting there ?

> > diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> > index 8cdf75adcce1..eb03d7e099bb 100644
> > --- a/drivers/thermal/thermal_helpers.c
> > +++ b/drivers/thermal/thermal_helpers.c
> > @@ -187,7 +187,10 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
> >  		if (instance->target > target)
> >  			target = instance->target;
> >  	}
> > -	cdev->ops->set_cur_state(cdev, target);
> > +
> > +	if (!cdev->ops->set_cur_state(cdev, target))
> > +		thermal_cooling_device_stats_update(cdev, target);
> > +
> 
> I might be wrong but, this will maybe double account for cases the same
> cooling state is selected.

No because I am exiting early for same sates in that routine.

> >  void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *cdev)
> >  {
> > +	struct cooling_dev_stats *stats;
> > +	unsigned long states;
> > +	int ret, size;
> > +
> > +	ret = cdev->ops->get_max_state(cdev, &states);
> > +	if (ret)
> > +		return;
> > +
> > +	states++; /* Total number of states is highest state + 1 */
> > +	size = sizeof(*stats);
> > +	size += sizeof(*stats->time_in_state) * states;
> > +
> > +	stats = kzalloc(size, GFP_KERNEL);
> > +	if (!stats)
> > +		return;
> > +
> > +	stats->time_in_state = (ktime_t *)(stats + 1);
> > +	cdev->stats = stats;
> > +	stats->last_time = ktime_get();
> > +	stats->max_states = states;
> > +	cdev->stats = stats;
> > +
> > +	spin_lock_init(&stats->lock);
> 
> I would say, the cooling device stat initialization deserves its own
> initialization function, don't you think?

Hmm, I am not sure if we need it right away. This function is only for cooling
device's sysfs setup and initializing the "stats" structure kind of falls in the
setup category. Of course if we want this function to handle sysfs setup for
thermal zones as well, then yes we better split it up.

The other thing was with thermal_cooling_device_remove_sysfs() as that would
also need to call a separate routine to do the cleanup and that would be the
only thing it will end up doing. So it would more be like a dummy caller.

> Also, I see nothing about sysfs on the lines added to
> thermal_cooling_device_setup_sysfs().

Well, it is allocating structure to keep the values showed while reading sysfs
files, so it is kind of sysfs related to me :)

-- 
viresh

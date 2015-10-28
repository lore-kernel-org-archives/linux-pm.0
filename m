From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 4/5] cpufreq: governor: Quit work-handlers early if governor is stopped
Date: Wed, 28 Oct 2015 16:12:33 +0100
Message-ID: <1463739.8uKY7njy7x@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <11662041.x9fsKCWszL@vostro.rjw.lan> <20151028082559.GD30039@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151028082559.GD30039@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 28, 2015 01:55:59 PM Viresh Kumar wrote:
> On 28-10-15, 08:10, Rafael J. Wysocki wrote:
> > I have a hard time figuring out what the patch is supposed to achieve from
> > the above.
> 
> We had a problem earlier, where even after stopping the governor for a
> policy, the work was still queued for some of its CPUs.
> 
> We failed to understand the real problem then, and so abused the wider
> cpufreq_governor_lock.
> 
> I understood the problem much better now, and got a straight forward,
> and precise solution for that.
> 
> > Do we eventually want to get rid of cpufreq_governor_lock and that's why we're
> > doing this?
> 
> That's another benefit we get out of this change.
> 
> > > +	mutex_lock(&shared->timer_mutex);
> > > +	shared->policy = NULL;
> > > +	mutex_unlock(&shared->timer_mutex);
> 
> Right.
> 
> > So this assumes that dbs_timer() will acquire the mutex and see that
> > shared->policy is now NULL, so it will bail out immediately, but ->
> > 
> > > +
> > >  	gov_cancel_work(dbs_data, policy);
> > >  
> > > -	shared->policy = NULL;
> > >  	mutex_destroy(&shared->timer_mutex);
> > 
> > -> the mutex is destroyed here, so what the guarantee that the mutex will
> > still be around when dbs_timer() runs?
> 
> You really got me worried for few minutes :)
> 
> The earlier update of shared->policy = NULL, makes sure that no
> work-handler can start real work. After the unlock the work handlers
> will start executing but will return early.

That's not sufficient, because it doesn't guarantee that the lock will be
dropped before we destroy it.

> We also have gov_cancel_work(), which will until the time all the
> current handlers have finished executing and no work is queued.
> 
> And so we are sure that there are no users of the mutex when it is
> destroyed.

OK, so the gov_cancel_work() provides the guarantee.

So this is a changelog matching your patch:

"gov_queue_work() acquires cpufreq_governor_lock to allow cpufreq_governor_stop()
to drain delayed work items possibly scheduled on CPUs that share the policy with
a CPU being taken offline.

However, the same goal may be achieved in a more straightforward way if the
policy pointer in the struct cpu_dbs_info matching the policy CPU is reset
upfront by cpufreq_governor_stop() under the timer_mutex belonging to it and
checked against NULL, under the same lock, at the beginning of dbs_timer().

In that case every instance of dbs_timer() run for a struct cpu_dbs_info
sharing the policy pointer in question after cpufreq_governor_stop() has started
will notice that that pointer is NULL and bail out immediately without queuing up
any new work items.  In turn, gov_cancel_work() called by cpufreq_governor_stop()
before destroying timer_mutex will wait for all of the delayed work items
currently running on the CPUs sharing the policy to drop the mutex, so it may
be destroyed safely.

Make cpufreq_governor_stop() and dbs_timer() work as described and modify
gov_queue_work() so it does not acquire cpufreq_governor_lock any more."

Thanks,
Rafael

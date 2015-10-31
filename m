From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/6] cpufreq: governor: replace per-cpu delayed work with
 timers
Date: Sat, 31 Oct 2015 08:06:15 +0530
Message-ID: <20151031023615.GX3716@ubuntu>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
 <e83291bcb6fcb69280f265194801510cf2e02c41.1446121217.git.viresh.kumar@linaro.org>
 <CAJ5Y-ebyMg1KUSCJ9+5UVN=6TNAMufGP9S4PqQWS0vnfX6XXOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ5Y-ebyMg1KUSCJ9+5UVN=6TNAMufGP9S4PqQWS0vnfX6XXOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ashwin,

On 30-10-15, 16:46, Ashwin Chaugule wrote:
> On 29 October 2015 at 08:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > This could be made lightweight by keeping per-cpu deferred timers with a
> > single work item, which is scheduled by the first timer that expires.
> 
> Single shared work item - would perhaps make it a bit more clear.

Okay, in case that I need to repost this, I will reword it.

> > +void gov_cancel_work(struct cpu_common_dbs_info *shared)
> > +{
> > +       unsigned long flags;
> > +
> > +       /*
> > +        * No work will be queued from timer handlers after skip_work is
> > +        * updated. And so we can safely cancel the work first and then the
> > +        * timers.
> > +        */
> > +       spin_lock_irqsave(&shared->timer_lock, flags);
> > +       shared->skip_work++;
> > +       spin_unlock_irqrestore(&shared->timer_lock, flags);
> > +
> > +       cancel_work_sync(&shared->work);
> > +
> > +       gov_cancel_timers(shared->policy);
> > +
> > +       shared->skip_work = 0;
> 
> Why doesnt this require the spin_lock protection?

Because there is no race here. We have already removed all
queued-timers and the shared work.

> > -static void dbs_timer(struct work_struct *work)
> > +static void dbs_work_handler(struct work_struct *work)
> >  {

> > +       mutex_lock(&shared->timer_mutex);
> > +       delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
> > +       mutex_unlock(&shared->timer_mutex);
> > +
> > +       shared->skip_work--;
> 
> Ditto.

Again, there is no race here. We have already removed the
queued-timers for the entire policy. The only other user is the
gov_cancel_work() thread (which is called while stopping the governor
or updating the sampling rate), which doesn't depend on this being
decremented as that will wait for the work to finish.

> > +       gov_add_timers(policy, delay);
> > +}
> > +
> > +static void dbs_timer_handler(unsigned long data)
> > +{
> > +       struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
> > +       struct cpu_common_dbs_info *shared = cdbs->shared;
> > +       struct cpufreq_policy *policy;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&shared->timer_lock, flags);
> > +       policy = shared->policy;
> > +
> > +       /*
> > +        * Timer handler isn't allowed to queue work at the moment, because:
> > +        * - Another timer handler has done that
> > +        * - We are stopping the governor
> > +        * - Or we are updating the sampling rate of ondemand governor
> > +        */
> > +       if (shared->skip_work)
> > +               goto unlock;
> > +
> > +       shared->skip_work++;
> > +       queue_work(system_wq, &shared->work);
> >
> 
> So, IIUC, in the event that this function gets called back to back and
> the first Work hasn't dequeued yet, then this queue_work() will not
> really enqueue, since queue_work_on() will return False?

In that case we wouldn't reach queue_work() in the first place as
skip_work will be incremented on the first call and the second call
will simply return early.

> If so, then
> does it mean we're skipping more recent CPU freq requests? Should we
> cancel past Work if it hasn't been serviced?

It doesn't matter. Its only the work handler that is going to do some
useful work, and there is no difference in the first or the second
request.

-- 
viresh

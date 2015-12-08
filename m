From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable for synchronization
Date: Tue, 08 Dec 2015 14:30:51 +0100
Message-ID: <5461074.Yz9lhOaAu0@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <4910771.IIQSzHPqps@vostro.rjw.lan> <20151208065905.GA3294@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58513 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756131AbbLHNAx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 08:00:53 -0500
In-Reply-To: <20151208065905.GA3294@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, December 08, 2015 12:29:05 PM Viresh Kumar wrote:
> On 08-12-15, 01:39, Rafael J. Wysocki wrote:
> > @@ -269,9 +259,6 @@ static void dbs_timer_handler(unsigned l
> >  {
> >  	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
> >  	struct cpu_common_dbs_info *shared = cdbs->shared;
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&shared->timer_lock, flags);
> >  
> >  	/*
> >  	 * Timer handler isn't allowed to queue work at the moment, because:
> > @@ -279,12 +266,10 @@ static void dbs_timer_handler(unsigned l
> >  	 * - We are stopping the governor
> >  	 * - Or we are updating the sampling rate of ondemand governor
> >  	 */
> > -	if (!shared->skip_work) {
> > -		shared->skip_work++;
> > +	if (atomic_inc_return(&shared->skip_work) > 1)
> > +		atomic_dec(&shared->skip_work);
> > +	else
> >  		queue_work(system_wq, &shared->work);
> > -	}
> 
> As explained in the other email, this is wrong..

OK, but instead of relying on the spinlock to wait for the already running
dbs_timer_handler() in gov_cancel_work() (which is really easy to overlook
and should at least be mentioned in a comment) we can wait for it explicitly.

That is, if the relevant code in gov_cancel_work() is like this:


	atomic_inc(&shared->skip_work);
	gov_cancel_timers(shared->policy);
	cancel_work_sync(&shared->work);
	gov_cancel_timers(shared->policy);
	atomic_set(&shared->skip_work, 0);

then the work item should not be leaked behind the cancel_work_sync() any more
AFAICS.

Thanks,
Rafael


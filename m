From: Steve Muckle <smuckle.linux@gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Sun, 13 Nov 2016 11:47:22 -0800
Message-ID: <20161113194722.GC29583@graphite.smuckle.net>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
 <582670FD.7080203@codeaurora.org>
 <CAJZ5v0gdZZ-h5JvRYacv2OH+gzG-wwHWevRmp04GNPNzUWwYeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdZZ-h5JvRYacv2OH+gzG-wwHWevRmp04GNPNzUWwYeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Nov 13, 2016 at 03:37:18PM +0100, Rafael J. Wysocki wrote:
> > Hold on a sec. I thought during LPC someone (Peter?) made a point that when
> > RT thread run, we should bump the frequency to max? So, schedutil is going
> > to trigger schedutil to bump up the frequency to max, right?
> 
> No, it isn't, or at least that is unlikely.
> 
> sugov_update_commit() sets sg_policy->work_in_progress before queuing
> the IRQ work and it is not cleared until the frequency changes in
> sugov_work().
> 
> OTOH, sugov_should_update_freq() checks sg_policy->work_in_progress
> upfront and returns false when it is set, so the governor won't see
> its own worker threads run, unless I'm overlooking something highly
> non-obvious.

FWIW my intention with the original version of this patch (which I
neglected to communicate to Viresh) was that it would depend on changing
the frequency policy for RT. I had been using rt_avg. It sounds like
during LPC there were talks of using another metric.

It does appear things would work okay without that but it also seems
a bit fragile. There's the window between when the work_in_progress
gets cleared and the RT kthread yields. I have not thought through the
various scenarios there, what is possible and tested to see if it is
significant enough to impact power-sensitive platforms.

thanks,
Steve

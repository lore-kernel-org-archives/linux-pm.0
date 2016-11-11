From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Fri, 11 Nov 2016 23:55:20 +0100
Message-ID: <20161111225520.GC3142@twins.programming.kicks-ass.net>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
 <20161111141952.GJ3117@twins.programming.kicks-ass.net>
 <CAJZ5v0jem_tAOJM-zHyQ4kAmF+gmv85E3KnG9M1=1qi6vVQitA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60987 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935421AbcKKWzV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 17:55:21 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jem_tAOJM-zHyQ4kAmF+gmv85E3KnG9M1=1qi6vVQitA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On Fri, Nov 11, 2016 at 10:52:27PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 11, 2016 at 3:19 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Nov 11, 2016 at 03:52:21PM +0530, Viresh Kumar wrote:
> >> @@ -456,8 +460,6 @@ static int sugov_init(struct cpufreq_policy *policy)
> >>
> >>   out:
> >>       mutex_unlock(&global_tunables_lock);
> >> -
> >> -     cpufreq_enable_fast_switch(policy);
> >>       return 0;
> >>
> >>   fail:
> >> @@ -468,6 +470,10 @@ static int sugov_init(struct cpufreq_policy *policy)
> >>       mutex_unlock(&global_tunables_lock);
> >>
> >>       sugov_policy_free(sg_policy);
> >> +
> >> + disable_fast_switch:
> >> +     cpufreq_disable_fast_switch(policy);
> >> +
> >>       pr_err("initialization failed (error %d)\n", ret);
> >>       return ret;
> >>  }
> >
> > Argh, no indented labels please. Please fix the 3 that snuck in while
> > you're there.
> 
> Well, you didn't tell me you didn't like them. :-)
> 
> Anyway, I can fix this up easily enough.
> 
> Any other concerns regarding the patch?

No, looked fine I think, as did the others.

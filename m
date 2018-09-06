From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Thu, 6 Sep 2018 15:38:44 +0100
Message-ID: <20180906143842.xlxcg5notwdaflww@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-14-quentin.perret@arm.com>
 <20180904105906.t5i7twyyt2omc45b@queper01-lin>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Thursday 06 Sep 2018 at 11:18:55 (+0200), Rafael J. Wysocki wrote:
> I'm not a particular fan of notifiers to be honest and you don't need
> to add an extra chain just in order to be able to register a callback
> from a single user.

Right. I agree there are alternatives to using notifiers. I used them
because they're existing infrastructure, and because they let me do what
I want without too much troubles, which are two important points.

> That can be achieved with a single callback
> pointer too, but also you could just call a function exported by the
> scheduler directly from where in the cpufreq code it needs to be
> called.

Are you thinking about something comparable to what is done in
cpufreq_add_update_util_hook() (kernel/sched/cpufreq.c) for example ?
That would probably have the same drawback as my current implementation,
that is that the scheduler is notified of _all_ governor changes, not
only changes to/from sugov although this is the only thing we care about
for EAS.

We could also hook things in sugov_start & sugov_stop directly, and keep
all changes into the scheduler ... That is slightly harder to implement
on the scheduler topology side, though.

Thoughts ?

> > Also, is there any hope that the 12 first patches could make it in 4.20
> > on their own ? Or is it already too late ?
> 
> I'm walking through them right now, albeit somewhat slowly due to
> various distractions, so we'll see.

Thanks !
Quentin

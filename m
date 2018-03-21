From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Wed, 21 Mar 2018 15:50:32 +0100
Message-ID: <20180321145032.GD15165@localhost.localdomain>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321123921.GB13951@e110439-lin>
 <20180321142630.GB2168@queper01-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321142630.GB2168@queper01-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 21/03/18 14:26, Quentin Perret wrote:
> On Wednesday 21 Mar 2018 at 12:39:21 (+0000), Patrick Bellasi wrote:
> > On 20-Mar 09:43, Dietmar Eggemann wrote:

[...]

> > 
> > If that's the case then, in the previous function, you can certainly
> > avoid the initialization of *cs and maybe also add an explicit:
> > 
> >     BUG_ON(em->nb_cap_states == 0);
> > 
> > which helps even just as "in code documentation".
> > 
> > But, I'm not sure if maintainers like BUG_ON in scheduler code :)
> 
> Yes, I'm not sure about the BUG_ON either :). I agree that it would be
> nice to document somewhere that compute_energy() is unsafe to call
> without sched_energy_present. I can simply add a proper doc comment to
> this function actually. Would that work ?

If it is something that must not happen and it is also non recoverable
at runtime, then...

$ git grep BUG_ON -- kernel/sched/ | wc -l
50

:)

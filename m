From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Wed, 10 Oct 2018 14:11:26 +0100
Message-ID: <20181010131124.isexblzzvkcp26q4@queper01-lin>
References: <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
 <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010125033.GP9130@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ionela Voinescu <ionela.voinescu@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 Oct 2018 at 14:50:33 (+0200), Juri Lelli wrote:
> On 10/10/18 14:34, Vincent Guittot wrote:
> > Hi  Juri,
> > 
> > On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
> > >
> > > On 10/10/18 14:04, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > > The problem was the same with RT, the cfs utilization was lower than
> > > > reality because RT steals soem cycle to CFS
> > > > So schedutil was selecting a lower frequency when cfs was running
> > > > whereas the CPU was fully used.
> > > > The same can happen with thermal:
> > > > cap the max freq because of thermal
> > > > the utilization with decrease.
> > > > remove the cap
> > > > the utilization is still low and you will select a low OPP because you
> > > > don't take into account cycle stolen by thermal like with RT
> > >
> > > What if we scale frequency component considering the capped temporary
> > > max?
> > 
> > Do you mean using a kind of scale_thermal_capacity in accumulate_sum
> > when computing utilization ?
> 
> Yeah, something like that I guess. So that we account for temporary
> "fake" 1024..

But wouldn't that break frequency invariance ? A task would look bigger
on a capped CPU than a non-capped one no ?

From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Date: Thu, 9 Aug 2018 10:38:09 +0100
Message-ID: <20180809093808.dkhf53a7gecv3djo@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
 <CAKfTPtBxWheWa4igKtwUmQR3x=7Zojnb65uFpeFUqxHmSkOh5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtBxWheWa4igKtwUmQR3x=7Zojnb65uFpeFUqxHmSkOh5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thursday 09 Aug 2018 at 11:30:57 (+0200), Vincent Guittot wrote:
> On Tue, 24 Jul 2018 at 14:26, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > From: Morten Rasmussen <morten.rasmussen@arm.com>
> >
> > Energy-aware scheduling is only meant to be active while the system is
> > _not_ over-utilized. That is, there are spare cycles available to shift
> > tasks around based on their actual utilization to get a more
> > energy-efficient task distribution without depriving any tasks. When
> > above the tipping point task placement is done the traditional way based
> > on load_avg, spreading the tasks across as many cpus as possible based
> > on priority scaled load to preserve smp_nice. Below the tipping point we
> > want to use util_avg instead. We need to define a criteria for when we
> > make the switch.
> >
> > The util_avg for each cpu converges towards 100% (1024) regardless of
> 
> remove the "(1024)" because util_avg converges to max cpu capacity
> which can be different from 1024

Good point, will be fixed in v6.

Thanks,
Quentin

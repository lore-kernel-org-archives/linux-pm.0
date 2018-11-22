From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 09/15] sched: Introduce sched_energy_present static key
Date: Thu, 22 Nov 2018 11:25:45 +0100
Message-ID: <20181122102545.GQ2131@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-10-quentin.perret@arm.com>
 <20181121130822.GE2113@hirez.programming.kicks-ass.net>
 <20181121151444.t3zye5l5iycfni2s@queper01-lin>
 <20181122091715.6kvhcbgoqrd54nbs@queper01-lin>
 <20181122093237.goxmr4p5l4h2izid@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122093237.goxmr4p5l4h2izid@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 22, 2018 at 09:32:39AM +0000, Quentin Perret wrote:
> Hmm, I went too fast, that's totally broken. But there's still something
> we can do with static_branch_{inc,dec} I think. I'll come back later
> with a better solution.

Right; if you count the rd's that have pd set, it should work-ish. Yes,
much cleaner if you can get it to work.

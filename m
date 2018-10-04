From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v7 12/14] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Thu, 4 Oct 2018 11:55:09 +0100
Message-ID: <20181004105507.ordjpa3hsb6zoelc@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-13-quentin.perret@arm.com>
 <20181004094412.GD19252@hirez.programming.kicks-ass.net>
 <20181004102722.izp7y42cvayq4pqg@queper01-lin>
 <20181004104107.GN19272@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004104107.GN19272@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 04 Oct 2018 at 12:41:07 (+0200), Peter Zijlstra wrote:
> Not sure, see what it looks like ;-) My main concern here was to get rid
> of that giant blob in select_task_rq_fair().

OK, got it. I'll probably just move the checks into the function and
merge that large comment into the already massive comment above
find_energy_efficient_cpu() or something. We'll see :-)

And do you actually care about the function name ? We've been using
find_energy_efficient_cpu() for some time in Android now, so that's just
slightly easier for us if that can be re-used. Not a big deal either,
though.

Thanks,
Quentin

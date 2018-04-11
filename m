From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Date: Wed, 11 Apr 2018 16:53:16 +0200
Message-ID: <20180411145316.GJ4043@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406172835.20078-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 06:28:35PM +0100, Patrick Bellasi wrote:
> is maintained although there are not actual usages so far in mainline
> for this hint... do we really need it?

There were intel_pstate patches that I expected to have shown up
already, and I meant to have a look at sugov, except I got side-tracked
again :/

From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Date: Wed, 7 Mar 2018 18:35:04 +0100
Message-ID: <20180307173504.GP25181@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
 <20180307113149.GA2211@e110439-lin>
 <20180307122437.GM25181@hirez.programming.kicks-ass.net>
 <20180307152458.GE2211@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180307152458.GE2211@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 07, 2018 at 03:24:58PM +0000, Patrick Bellasi wrote:

> Maybe that's the tricky bit: we remove the value we enqueued, _not_
> the current util_avg. Notice we use _task_util_est(p)... with the
> leading "_".

ARGH, ok let me try that again ;-)

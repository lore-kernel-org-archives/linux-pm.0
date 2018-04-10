From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
Date: Tue, 10 Apr 2018 13:54:57 +0200
Message-ID: <20180410115457.GB4043@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-3-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 04:36:03PM +0100, Dietmar Eggemann wrote:
> +		/*
> +		 * Build the energy model of one CPU, and link it to all CPUs
> +		 * in its frequency domain. This should be correct as long as
> +		 * they share the same micro-architecture.
> +		 */

Aside from the whole PM_OPP question; you should assert that assumption.
Put an explicit check for the uarch in and FAIL the init if that isn't
met.

I don't think it makes _ANY_ kind of sense to share a frequency domain
across uarchs and we should be very clear we're not going to support
anything like that.

I know DynamiQ strictly speaking allows that, but since it's insane, we
should consider that a bug in DynamiQ.

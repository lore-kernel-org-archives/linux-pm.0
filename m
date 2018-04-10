From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Tue, 10 Apr 2018 10:31:35 +0100
Message-ID: <20180410093022.GA26106@e108498-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
 <20180409153233.GA4082@hirez.programming.kicks-ass.net>
 <20180409164205.GA3520@e108498-lin.cambridge.arm.com>
 <CAJZ5v0hEvQ1jJYErGCa2d6pcydMYrD9_+uh7eM2F6v08NyGQ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hEvQ1jJYErGCa2d6pcydMYrD9_+uh7eM2F6v08NyGQ6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 Apr 2018 at 08:55:14 (+0200), Rafael J. Wysocki wrote:
> On Mon, Apr 9, 2018 at 6:42 PM, Quentin Perret <quentin.perret@arm.com> wrote:
> > On Monday 09 Apr 2018 at 17:32:33 (+0200), Peter Zijlstra wrote:
> >> On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:

[...]

> > I quiet like the first idea from a pure design standpoint, but I could
> > also understand if maintainers of other archs were reluctant to
> > have new dependencies on PM_OPP ...
> 
> Not just reluctant I would think.
> 
> Depending on PM_OPP directly here is like depending on ACPI directly.
> Would you agree with the latter?

Right, I see your point. I was suggesting to use PM_OPP only to make the
OPPs *visible*, nothing else. That doesn't mean all archs would have
to use dev_pm_opp_set_rate() or anything, they could just keep on doing
DVFS their own way. PM_OPP would just be a common way to make OPPs
visible outside of their subsystem, which should be harmless. The point
is to keep the energy model loading code common to all archs.

Another solution would be to let the archs populate the energy model
data-structures themselves, and turn the current energy.c file into
arm/arm64-specific code for ex.

Overall, I guess the question is whether or not PM_OPP is the right
interface for EAS of multiple archs ... That sounds like an interesting
discussion topic for OSPM next week, so thanks a lot for raising this
point !

Regards,
Quentin

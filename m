From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Tue, 5 Mar 2019 12:52:57 +0100
Message-ID: <CAJZ5v0iMLtnab0m56PfXHo9icg-tvSjyf8yKSiTfjuChtQbvrA@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan> <20190305114406.GV32494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305114406.GV32494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 5, 2019 at 12:44 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 05, 2019 at 11:58:37AM +0100, Rafael J. Wysocki wrote:
> > So after the Peter's patch "sched/cpufreq: Fix 32bit math overflow"
> > I will need to recompute sg_cpu->min in sugov_limits().
>
> So there's still an open question; do we want that ->min thing to depend
> on available frequencies _at_all_ ?
>
> I'm thinking it might be a good thing to have the iowait boost curve be
> independent of all that.
>
> Like said; if we set it at 128 (static), it takes 9 consequtive wake-ups
> for it to reach 1024 (max). While now the curve depends on how wide the
> gap is between min_freq and max_freq. And it seems weird to have this
> behaviour depend on that. To me at least.
>
> Now, I don't know if 128/9 is the right curve, it is just a random
> number I pulled out of a hat. But it seems to make more sense than
> depending on frequencies.

I agree.

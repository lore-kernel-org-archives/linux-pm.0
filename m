From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Tue, 8 Mar 2016 20:26:40 +0100
Message-ID: <20160308192640.GD6344@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
 <56D8AEB7.2050100@linaro.org>
 <36459679.vzZnOsAVeg@vostro.rjw.lan>
 <20160308112759.GF6356@twins.programming.kicks-ass.net>
 <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 08, 2016 at 07:00:57PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 8, 2016 at 12:27 PM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Seeing how frequency invariance is an arch feature, and cpufreq drivers
> > are also typically arch specific, do we really need a flag at this
> > level?
> 
> The next frequency is selected by the governor and that's why.  The
> driver gets a frequency to set only.
> 
> Now, the governor needs to work with different platforms, so it needs
> to know how to deal with the given one.

Ah, indeed. In any case, the availability of arch_sched_scale_freq() is
a compile time thingy, so we can, at compile time, know what to use.

> > In any case, I think the only difference between the two formula should
> > be the addition of (1) for the platforms that do not already implement
> > frequency invariance.
> 
> OK
> 
> So I'm reading this as a statement that linear is a better
> approximation for frequency invariant utilization.

Well, (1) is what the scheduler does with frequency invariance, except
that allows a more flexible definition of 'current frequency' by asking
for it every time we update the util stats.

But if a platform doesn't need this, ie. it has a fixed frequency, or
simply doesn't provide anything like this, assuming we run at the
frequency we asked for is a reasonable assumption no?

> This means that on platforms where the utilization is frequency
> invariant we should use
> 
>   next_freq = a * x
> 
> (where x is given by (2) above) and for platforms where the
> utilization is not frequency invariant
> 
>   next_freq = a * x * current_freq / max_freq
> 
> and all boils down to finding a.

Right.

> Now, it seems reasonable for a to be something like (1 + 1/n) *
> max_freq, so for non-frequency invariant we get
> 
>   nex_freq = (1 + 1/n) * current_freq * x

This seems like a big leap; where does:

  (1 + 1/n) * max_freq

come from? And what is 'n'?

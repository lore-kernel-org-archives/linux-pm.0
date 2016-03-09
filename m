From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Wed, 9 Mar 2016 17:15:19 +0700
Message-ID: <20160309101519.GA26402@pablo>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com>
 <56D8AEB7.2050100@linaro.org>
 <36459679.vzZnOsAVeg@vostro.rjw.lan>
 <20160308112759.GF6356@twins.programming.kicks-ass.net>
 <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
 <20160308192640.GD6344@twins.programming.kicks-ass.net>
 <CAJZ5v0g=dXmoPr0jR6AVuynVYbSwJvnS2dFhb7QnUKq9LRRnrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=dXmoPr0jR6AVuynVYbSwJvnS2dFhb7QnUKq9LRRnrQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

sorry if I didn't reply yet. Trying to cope with jetlag and
talks/meetings these days :-). Let me see if I'm getting what you are
discussing, though.

On 08/03/16 21:05, Rafael J. Wysocki wrote:
> On Tue, Mar 8, 2016 at 8:26 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Mar 08, 2016 at 07:00:57PM +0100, Rafael J. Wysocki wrote:
> >> On Tue, Mar 8, 2016 at 12:27 PM, Peter Zijlstra <peterz@infradead.org> wrote:

[...]

> a = max_freq gives next_freq = max_freq for x = 1, but with that
> choice of a you may never get to x = 1 with frequency invariant
> because of the feedback effect mentioned above, so the 1/n produces
> the extra boost needed for that (n is a positive integer).
> 
> Quite frankly, to me it looks like linear really is a better
> approximation for "raw" utilization.  That is, for frequency invariant
> x we should take:
> 
>   next_freq = a * x * max_freq / current_freq
> 
> (and if x is not frequency invariant, the right-hand side becomes a *
> x).  Then, the extra boost needed to get to x = 1 for frequency
> invariant is produced by the (max_freq / current_freq) factor that is
> greater than 1 as long as we are not running at max_freq and a can be
> chosen as max_freq.
> 

Expanding terms again, your original formula (without the 1.1 factor of
the last version) was:

 next_freq = util / max_cap * max_freq

and this doesn't work when we have freq invariance since util won't go
over curr_cap.

What you propose above is to add another factor, so that we have:

 next_freq = util / max_cap * max_freq / curr_freq * max_freq

which should give us the opportunity to reach max_freq also with freq
invariance.

This should actually be the same of doing:

 next_freq = util / max_cap * max_cap / curr_cap * max_freq

We are basically scaling how much the cpu is busy at curr_cap back to
the 0..1024 scale. And we use this to select next_freq. Also, we can
simplify this to:

 next_freq = util / curr_cap * max_freq

and we save some ops.

However, if that is correct, I think we might have a problem, as we are
skewing OPP selection towards higher frequencies. Let's suppose we have
a platform with 3 OPPs:

  freq     cap
  1200     1024
  900      768
  600      512

As soon a task reaches an utilization of 257 we will be selecting the
second OPP as

 next_freq = 257 / 512 * 1200 ~ 602

While the cpu is only 50% busy in this case. And we will go at max OPP
when reaching ~492 (~64% of 768).

That said, I guess this might work as a first solution, but we will
probably need something better in the future. I understand Rafael's
concerns regardin margins, but it seems to me that some kind of
additional parameter will be probably needed anyway to fix this.
Just to say again how we handle this in schedfreq, with a -20% margin
applied to the lowest OPP we will get to the next one when utilization
reaches ~410 (80% busy at curr OPP), and so on for the subsequent ones,
which is less aggressive and might be better IMHO.

Best,

- Juri

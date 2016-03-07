From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Mon, 07 Mar 2016 03:41:15 +0100
Message-ID: <36459679.vzZnOsAVeg@vostro.rjw.lan>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan> <CAJZ5v0h47h-xW6a4jzwRuOOOSG+qsD9hegM7QCzbD8Wb-yPVKQ@mail.gmail.com> <56D8AEB7.2050100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64894 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752185AbcCGCj1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Mar 2016 21:39:27 -0500
In-Reply-To: <56D8AEB7.2050100@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>

On Thursday, March 03, 2016 01:37:59 PM Steve Muckle wrote:
> On 03/03/2016 12:20 PM, Rafael J. Wysocki wrote:
> >> Here is a comparison, with frequency invariance, of ondemand and
> >> interactive with schedfreq and schedutil. The first two columns (run and
> >> period) are omitted so the table will fit.
> >>
> >>         ondemand        interactive     schedfreq       schedutil
> >> busy %  OR      OH      OR      OH      OR      OH      OR      OH
> >> 1.00%   0       68.96%  0       100.04% 0       78.49%  0       95.86%
> >> 1.00%   0       25.04%  0       22.59%  0       72.56%  0       71.61%
> >> 10.00%  0       21.75%  0       63.08%  0       52.40%  0       41.78%
> >> 10.00%  0       12.17%  0       14.41%  0       17.33%  0       47.96%
> >> 10.00%  0       2.57%   0       2.17%   0       0.29%   0       26.03%
> >> 18.18%  0       12.39%  0       9.39%   0       17.34%  0       31.61%
> >> 19.82%  0       3.74%   0       3.42%   0       12.26%  0       29.46%
> >> 40.00%  2       6.26%   1       12.23%  0       6.15%   0       12.93%
> >> 40.00%  0       0.47%   0       0.05%   0       2.68%   2       14.08%
> >> 40.00%  0       0.60%   0       0.50%   0       1.22%   0       11.58%
> >> 55.56%  2       4.25%   5       5.97%   0       2.51%   0       7.70%
> >> 55.56%  0       1.89%   0       0.04%   0       1.71%   6       8.06%
> >> 55.56%  0       0.50%   0       0.47%   0       1.82%   5       6.94%
> >> 75.00%  2       1.65%   1       0.46%   0       0.26%   56      3.59%
> >> 75.00%  0       1.68%   0       0.05%   0       0.49%   21      3.94%
> >> 75.00%  0       0.28%   0       0.23%   0       0.62%   4       4.41%
> >>
> >> Aside from the 2nd and 3rd tests schedutil is showing decreased
> >> performance across the board. The fifth test is particularly bad.
> > 
> > I guess you mean performance in terms of the overhead?
> 
> Correct. This overhead metric describes how fast the workload completes,
> with 0% equaling the perf governor and 100% equaling the powersave
> governor. So it's a reflection of general performance using the
> governor. It's called "overhead" I imagine (the metric predates my
> involvement) as it is something introduced/caused by the policy of the
> governor.

If my understanding of the requency invariant utilization idea is correct,
it is about re-scaling utilization so it is always relative to the capacity
at the max frequency.  If that's the case, then instead of using x = util_raw / max
we will use something like y = (util_raw / max) * (f / max_freq) (f - current
frequency).  This means that

(1) x = y * max_freq / f

Now, say we have an agreed-on (linear) formula for f depending on x:

f = a * x + b

and if you say "Look, if I substitute y for x in this formula, it doesn't
produce correct results", then I can only say "It doesn't, because it can't".

It *obviously* won't work, because instead of substituting y for x, you
need to substitute the right-hand side of (1) for it.  They you'll get

f = a * y * max_freq / f + b

which is obviously nonlinear, so there's no hope that the same formula
will ever work for both "raw" and "frequency invariant" utilization.

To me this means that looking for a formula that will work for both is
just pointless and there are 3 possibilities:

(a) Look for a good enough formula to apply to "raw" utilization and then
    switch over when all architectures start to use "frequency invariant"
    utilization.
(b) Make all architecuters use "frequency invariant" and then look for a
    working formula (seems rather less than realistic to me to be honest).
(c) Code for using either "raw" or "frequency invariant" depending on
    a callback flag or something like that.

I, personally, would go for (a) at this point, because that's the easiest
one, but (c) would be doable too IMO, so I don't care that much as long
as it is not (b).

Thanks,
Rafael


From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/5] intel_pstate: Use C0 time, calculate target pstate
 directly
Date: Mon, 13 Apr 2015 09:32:14 -0700
Message-ID: <20150413093214.63dc6184@kcaccard-desk.amr.corp.intel.com>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43397 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbbDMQcQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Apr 2015 12:32:16 -0400
In-Reply-To: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: rjw@rjwysocki.net, dsmythies@telus.net, linux-pm@vger.kernel.org

Hi Doug,

On Sat, 11 Apr 2015 21:10:25 -0700
Doug Smythies <doug.smythies@gmail.com> wrote:

> This patch set attempts to address some issues with
> the intel_pstate driver:
> 
> The driver has a finicky tradeoffs between fixed point
> integer math and gain settings and the setpoint.
> 
> The application is not really best suited to a PID
> (Proportional Integral Derivative) controller.

Agree!

> 
> The duration method can incorrectly drive the target
> pstate downwards, because a long duration might not
> be due to idle.
> 
> The driver can incorrectly drive the target pstate
> upwards, when the C0 time is virtually 0.
> 
> The patch set brings back the use of C0 time as the driving
> input as to what to do next in terms of target pstate.
> Recall that C0 time was used once before and was eventually
> removed due to situations of pstate lockup at a low pstate.
> Why is this time better? Because it is scaled properly,
> whereas it was not before. Also the response curve is
> flexible and adjustable.
> 
> Patch 1 basically adds better debug information to the
> perf data. It was originally requested in June, and Dirk agreed
> to include it in September. Regardless of the acceptance or
> rejection of this whole patch set, please accept this one.
> scripts/checkpatch.pl complains about one line as over 80
> characters, not sure how to split the line.
> 
> Patch 2 brings back the use of C0 time for the calculation
> of core_busy. Floor and ceiling hold values can be adjusted
> Once the floor load is reached the response is linear until
> the ceiling load is reached. The equations are just a simple
> y=mx+b line, where m = slope and b = intercept.
> Equation 1: min = m * floor + b
> Equation 2: max = m * ceiling + b
> Two equations and two unknowns, solved and coded.
> scripts/checkpatch.pl O.K.
> 
> Patch 3 bypasses the PID controller and calculates the
> target pstate directly. An IIR (Infinite Impulse
> Response) filter takes care of filtering.
> Again a simple y=mx+b line.
> Equation 1: pmin = m * min + b
> Equation 2: pmax = m * max + b
> Again, two simple equations and two unknowns, solved
> and coded.
> scripts/checkpatch.pl O.K.
> Note: not the same min and max as in patch 2.
> 
> Note: There are two definitions of percent within
> this driver, one goes to 100% at the max turbo (if
> it is enabled) and the other is 100% at the max
> non-turbo (enabled or not). It can be very confusing.
> The min used in patch 3 must be the mathematical min
> for the processor under the current turbo enabled or
> disabled state, which might not be the same
> as /sys/devices/system/cpu/intel_pstate/min_perf_pct
> when turbo is enabled.
> 
> Patch 4 adds weighting to longer duration events to,
> at least partially, compensate for the asymmetric
> rising and falling load typical durations.
> scripts/checkpatch.pl O.K.
> 
> Patch 5 just adjusts the default IIR gain.
> 10 percent gives a rising edge response time similar
> to the current version of the driver.
> scripts/checkpatch.pl O.K.
> 
> Anticipated questions:
> 
> Q: Shouldn't the response curve be normalized to a reference
> pstate, perhaps the max non-turbo pstate?
> 
> A: Doing so can create a lockup scenario, depending on the
> response curve settings and the overall pstate range of the
> particular processor. A downside to not normalizing has not been
> detected.
> 
> Q: One of the patches in the set is titled V2. What was V1?
> 
> A: To a limit, V1 ran the IIR filter N times when the duration
> was N times nominal. The method was expensive in terms of
> multiplies and divides. V2 saves a lot of clock cycles, and
> is good enough.
> 
> Migration path:
> 
> It should not be assumed that the current pstate is actually
> what was in effect during the last sample time. If a higher
> pstate was actually used, due to another active CPU, then
> that should override the use of the current pstate in the filter.
> This issue also exists in the current version of the driver,
> and was only discovered a few days ago. see also:
> https://bugzilla.kernel.org/show_bug.cgi?id=93521#c55
> This will be addressed, if possible, in a future patch.
> 
> There are likely some math (multiply and divide) savings that
> can be realized in future patches.
> 
> While the use of the PID controller has been eliminated, and
> because the change is likely to be controversial, the
> code has been left intact. It will be removed in a future patch.

I am completely supportive of removing the PID controller.

> 
> Doug Smythies (5):
>   intel_pstate: Add tsc collection and keep previous target pstate. Add
>     both to trace.
>   intel_pstate: Use C0 time for busy calculations (again).
>   intel_pstate: Calculate target pstate directly.
>   intel_pstate: Compensate for intermediate durations (v2).
>   intel_pstate: Adjust default IIR filter gain.
> 
>  Documentation/cpu-freq/intel-pstate.txt |   2 +
>  drivers/cpufreq/intel_pstate.c          | 188 ++++++++++++++++++++++++--------
>  include/trace/events/power.h            |  25 +++--
>  3 files changed, 163 insertions(+), 52 deletions(-)
> 

Thanks for your patches, I'll be doing some testing and review and let
you know how things go.

Kristen

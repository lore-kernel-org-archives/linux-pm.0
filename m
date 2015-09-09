From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Wed, 9 Sep 2015 13:16:10 -0700
Message-ID: <55F0938A.9000607@linaro.org>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com> <20150903091849.GB15649@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35572 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbbIIUQN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 16:16:13 -0400
Received: by pacfv12 with SMTP id fv12so20007886pac.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 13:16:12 -0700 (PDT)
In-Reply-To: <20150903091849.GB15649@e105326-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Patrick,

On 09/03/2015 02:18 AM, Patrick Bellasi wrote:
> In my view, one of the main goals of sched-DVFS is actually that to be
> a solid and generic replacement of different CPUFreq governors.
> Being driven by the scheduler, sched-DVFS can exploit information on
> CPU demand of active tasks in order to select the optimal Operating
> Performance Point (OPP) using a "proactive" approach instead of the
> "reactive" approach commonly used by existing governors.

I'd agree that with knowledge of CPU demand on a per-task basis, rather
than the aggregate per-CPU demand that cpufreq governors use today, it
is possible to proactively address changes in CPU demand which result
from task migrations, task creation and exit, etc.

That said I believe setting the OPP based on a particular given
historical profile of task load still relies on a heuristic algorithm of
some sort where there is no single right answer. I am concerned about
whether sched-dvfs and SchedTune, as currently proposed, will support
enough of a range of possible heuristics/policies to effectively replace
the existing cpufreq governors.

The two most popular governors for normal operation in the mobile world:

* ondemand: Samples periodically, CPU usage calculated as simple busy
fraction of last X ms window of time. Goes straight to fmax when load
exceeds up_threshold tunable %, otherwise scales frequency
proportionally with load. Can stay at fmax longer if requested before
re-evaluating by configuring the sampling_down_factor tunable.

* interactive: Samples periodically, CPU usage calculated as simple busy
fraction of last Xms window of time. Goes to an intermediate tunable
freq (hispeed_freq) when load exceeds a user definable threshold
(go_hispeed_load). Otherwise strives to maintain the CPU usage set by
the user in the "target_loads" array. Other knobs that affect behavior
include min_sample_time (min time to spend at a freq before slowing
down) and above_hispeed_delay (allows various delays to further raise
speed above hispeed freq).

It's also worth noting that mobile vendors typically add all sorts of
hacks on top of the existing cpufreq governors which further complicate
policy.

The current proposal:

* sched-dvfs/schedtune: Event driven, CPU usage calculated using
exponential moving average. AFAICS tries to maintain some % of idle
headroom, but if that headroom doesn't exist at task_tick_fair(), goes
to max frequency. Schedtune provides a way to boost/inflate the demand
of individual tasks or overall system demand.

This looks a bit like ondemand to me but without the
sampling_down_factor functionality and using per-entity load tracking
instead of a simple window-based aggregate CPU usage. The interactive
functionality would require additional knobs. I don't think schedtune
will allow for tuning the latency of CPU frequency changes
(min_sample_time, above_hispeed_delay, etc).

A separate but related concern - in the (IMO likely, given the above)
case that folks want to tinker with that policy, it now means they're
hacking the scheduler as opposed to a self-contained frequency policy
plugin.

Another issue with policy (but not specific to this proposal) is that
putting a bunch of it in the CPU frequency selection may derail the
efforts of the EAS algorithm, which I'm still working on digesting.
Perhaps a unified sched/cpufreq policy could go there.

thanks,
Steve


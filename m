From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC 08/14] sched/tune: add detailed documentation
Date: Tue, 15 Sep 2015 16:55:12 -0700
Message-ID: <55F8AFE0.2040303@linaro.org>
References: <1440010044-3402-9-git-send-email-patrick.bellasi@arm.com>
 <20150902064958.GA18664@google.com> <20150903091849.GB15649@e105326-lin>
 <55F0938A.9000607@linaro.org> <20150911110959.GA22876@e105326-lin>
 <55F72773.9090001@linaro.org> <20150915150044.GD3206@e105326-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34761 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbbIOXzP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 19:55:15 -0400
Received: by padhy16 with SMTP id hy16so190143459pad.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2015 16:55:15 -0700 (PDT)
In-Reply-To: <20150915150044.GD3206@e105326-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ricky Liang <jcliang@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 09/15/2015 08:00 AM, Patrick Bellasi wrote:
>> Agreed, though I also think those tunable values might also change for a
>> given set of tasks in different circumstances.
> 
> Could you provide an example?
>
> In my view the per-task support should be exploited just for quite
> specialized tasks, which are usually not subject to many different
> phases during their execution.

The surfaceflinger task in Android is a possible example. It can have
the same issue as the graphics controller task you mentioned - needing
to finish quickly so the overall display pipeline can meet its deadline,
but often not exerting enough CPU demand by itself to raise the
frequency high enough.

Since mobile platforms are so power sensitive though, it won't be
possible to boost surfaceflinger all the time. Perhaps the
surfaceflinger boost could be managed by some sort of userspace daemon
monitoring the sort of usecase running and/or whether display deadlines
are being missed, and updating a schedtune boost cgroup.

> For example, in a graphics rendering pipeline usually we have a host
...
> With SchedTune we would like to get a similar result to the one you
> describe using min_sample_time and above_hispeed_delay by linking
> somehow the "interpretation" of the PELT signal with the boost value.
> 
> Right now we have in sched-DVFS an idle % headroom which is hardcoded
> to be ~20% of the current OPP capacity. When we cross that boundary
> that threshold with the CPU usage, we switch straight to the max OPP.
> If we could figure out a proper mechanism to link the boost signal to
> both the idle % headroom and the target OPP, I think we could achieve
> quite similar results than what you can get with the knobs offered by
> the interactive governor.
> The more you boost a task the bigger is the idle % headroom and
> the higher is the OPP you will jump.

Let's say I have a system with one task (to set aside the per-task vs.
global policy issue temporarily) and I want to define a policy which

 - quickly goes to 1.2GHz when the current frequency is less than
   that and demand exceeds capacity

 - waits at least 40ms (or just "a longer time") before increasing the
   frequency if the current frequency is 1.2GHz or higher

This is similar to (though a simplification of) what interactive is
often configured to do on mobile platforms. AFAIK it's a fairly common
strategy due to the power-perf curves and OPPs available on CPUs, and at
the same time striving to maintain decent UI responsiveness.

Even with the proposed modification to link boost with idle % and target
OPP I don't think there'd currently be a way to express this policy,
which goes beyond the linear scaling of the magnitude of CPU demand
requested by a task, idle headroom or target OPP.

> 
...
>> The hardcoded values in the
>> task load tracking algorithm seem concerning though from a tuning
>> standpoint.
> 
> I agree, that's why we are thinking about the solution described
> before. Exploit the boost value to replace the hardcoded thresholds
> should allow to get more flexibility while being per-task defined.
> Hopefully, tuning per task can be more easy and effective than
> selection a single value fitting all needs.
> 
>>
>>>> The interactive functionality would require additional knobs. I
>> ...
>>> However, regarding specifically the latency on OPP changes, there are
>>> a couple of extension we was thinking about:
>>> 1. link the SchedTune boost value with the % of idle headroom which
>>>    triggers an OPP increase
>>> 2. use the SchedTune boost value to defined the high frequency to jump
>>>    at when a CPU crosses the % of idle headroom
>>
>> Hmmm... This may be useful (only testing/profiling would tell) though it
>> may be nice to be able to tune these values.
> 
> Again, in my view the tuning should be per task with a single knob.
> The value of the knob should than be properly mapped on other internal
> values to obtain a well defined behavior driven by information shared
> with the scheduler, i.e. a PELT signal.
> 
>>> These are tunables which allows to parameterize the way the PELT
>>> signal for CPU usage is interpreted by the sched-DVFS governor.
>>>
>>> How such tunables should be exposed and tuned is to be discussed.
>>> Indeed, one of the main goals of the sched-DVFS and SchedTune
>>> specifically, is to simplify the tuning of a platform by exposing to
>>> userspace a reduced number of tunables, preferably just one.
>>
>> This last point (the desire for a single tunable) is perhaps at the root
>> of my main concern. There are users/vendors for whom the current
>> tunables are insufficient, resulting in their hacking the governors to
>> add more tunables or features in the policy.
> 
> We should also consider that we are proposing not only a single
> tunable but also a completely different standpoint. Not more a "blind"
> system-wide view on the average system behaviors, but instead a more
> detailed view on tasks behaviors. A single tunable used to "tag" tasks
> maybe it's not such a limited solution in this design.

I think the algorithm is still fairly blind. There still has to be a
heuristic for future CPU usage, it's now just per-task and in the
scheduler (PELT), whereas it used to be per-CPU and in the governor.

This allows for good features like adjusting frequency right away on
task migration/creation/exit or per task boosting etc., but I think
policy will still be important. Tasks change their behavior all the
time, at least in the mobile usecases I've seen.

>> Consolidating CPU frequency and idle management in the scheduler will
>> clean things up and probably make things more effective, but I don't
>> think it will remove the need for a highly configurable policy.
> 
> This can be verified only by starting to use sched-DVFS + SchedTune on
> real/synthetic setup to verify which features are eventually missing,
> or specific use-cases not properly managed.
> If we are able to setup these experiments perhaps we will be able to
> identify a better design for a scheduler driver solution.

Agree. I hope to be able to run some of these experiments to help.

>> I'm curious about the drive for one tunable. Is that something there's
...
> We have plenty of experience, collected on the past years, on CPUFreq
> governors and customer specific mods.
> Don't you think we can exploit that experience to reason around a
> fresh new design that allows to satisfy all requirements while
> providing possibly a simpler interface?

Sure. I'm just communicating requirements I've seen :) .

> I agree with you that all the current scenarios must be supported by
> the new proposal. We should probably start by listing them and come
> out with a set of test cases that allow to verify where we are wrt
> the state of the art.

Sounds like a good plan to me... Perhaps we could discuss some mobile
usecases next week at Linaro Connect?

cheers,
Steve


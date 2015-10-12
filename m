From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 43/46] sched/{fair,cpufreq_sched}: add
 reset_capacity interface
Date: Mon, 12 Oct 2015 12:02:09 -0700
Message-ID: <561C03B1.7060205@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-44-git-send-email-morten.rasmussen@arm.com>
 <5616D4D9.6060609@linaro.org> <56178560.8060502@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32978 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbJLTCM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 15:02:12 -0400
Received: by pabrc13 with SMTP id rc13so26009073pab.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2015 12:02:12 -0700 (PDT)
In-Reply-To: <56178560.8060502@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 10/09/2015 02:14 AM, Juri Lelli wrote:
>> Though I understand the initial stated motivation here (avoiding a
>> > redundant capacity request upon idle entry), releasing the CPU's
>> > capacity request altogether on idle seems like it could be a contentious
>> > policy decision.
>> > 
>> > An example to illustrate my concern:
>> > - 2 CPU single frequency domain topology
>> > - task A is a small frequently-running task on CPU0
>> > - task B is a heavier intermittent task running on CPU1
>> > 
>> > Task B is driving the frequency of the cluster high, but whenever it
>> > sleeps CPU1 becomes idle and the capacity request is dropped. If there's
>> > any activity on CPU0 that causes cpufreq_sched_set_cap() to be called
>> > (which is likely, given task A runs often) the cluster frequency will be
>> > lowered. Task B's performance will be impacted when it wakes up because
>> > initially the OPP will be insufficient. Power may or may not be
>
> With the current implementation you are right: B's util will be decayed
> and it will have to build it up again, loosing in performance. What
> about we try to change this as discussed at Connect? At enqueue time we
> use pre-decayed B's util, so that it will generate an OPP transition
> at the required capacity on wakeup.

Actually I wasn't even really considering the decay of B's utilization -
just that the CPU OPP will have been lowered due to the reset of CPU1's
reservation when B slept and subsequent task activity on CPU0, and then
will have to be raised (to something, depending on whether pre or post
decayed utilization is used) when B wakes. The latency of OPP
transitions may be considerable, or at least nontrivial, compared to a
task's wake/sleep pattern, meaning that a good portion of the task
activity may occur while the OPP is suboptimal for that task. Frequent
OPP transitions may also have a nontrivial overhead in terms of CPU
usage and energy.

I don't have an opinion to offer at the moment on using the pre or post
decayed utilization in enqueue. That seems like a tough policy choice
which may require a lot of power/perf data to clearly justify either
way. My concern here is limited to whether a CPU's dvfs
contribution/vote should be entirely removed when the last task on it is
dequeued, or removed gradually (decayed) over time, or removed entirely
after some timeout etc.

>> > The decision of when a CPU's vote should be decayed or removed is more
>> > policy where I believe there's no single right answer and in the past,
>> > has been solved with tunables. The interactive governor's slack timer
>> > controls how long it will allow an idle CPU to request a frequency > fmin.
>> > 
>
> Mmm, IMHO there is still a bit of space for trying to make the current
> implementation better, before we give up and go to add a tunable :-).

Agreed. As a tunable apologist my attempt to offer background on one way
this is solved today ended up looking more like a request :) .

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpufreq: governor: Be friendly towards latency-sensitive
 bursty workloads
Date: Sat, 07 Jun 2014 02:55:32 +0530
Message-ID: <539231CC.8070803@linux.vnet.ibm.com>
References: <20140603214625.723.58779.stgit@srivatsabhat.in.ibm.com> <1574521.TWqGMgFGby@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:54571 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaFFV05 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jun 2014 17:26:57 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 7 Jun 2014 02:56:55 +0530
In-Reply-To: <1574521.TWqGMgFGby@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/07/2014 03:07 AM, Rafael J. Wysocki wrote:
> On Wednesday, June 04, 2014 03:17:00 AM Srivatsa S. Bhat wrote:
>> Cpufreq governors like the ondemand governor calculate the load on the CPU
>> periodically by employing deferrable timers. A deferrable timer won't fire
>> if the CPU is completely idle (and there are no other timers to be run), in
>> order to avoid unnecessary wakeups and thus save CPU power.
>>
>> However, the load calculation logic is agnostic to all this, and this can
>> lead to the problem described below.
>>
>>
>> Time (ms)               CPU 1
>>
>> 100                Task-A running
>>
>> 110                Governor's timer fires, finds load as 100% in the last
>>                    10ms interval and increases the CPU frequency.
>>
>> 110.5              Task-A running
>>
>> 120		   Governor's timer fires, finds load as 100% in the last
>> 		   10ms interval and increases the CPU frequency.
>>
>> 125		   Task-A went to sleep. With nothing else to do, CPU 1
>> 		   went completely idle.
>>
>> 200		   Task-A woke up and started running again.
>>
>> 200.5		   Governor's deferred timer (which was originally programmed
>> 		   to fire at time 130) fires now. It calculates load for the
>> 		   time period 120 to 200.5, and finds the load is almost zero.
>> 		   Hence it decreases the CPU frequency to the minimum.
>>
>> 210		   Governor's timer fires, finds load as 100% in the last
>> 		   10ms interval and increases the CPU frequency.
>>
>>
>> So, after the workload woke up and started running, the frequency was suddenly
>> dropped to absolute minimum, and after that, there was an unnecessary delay of
>> 10ms (sampling period) to increase the CPU frequency back to a reasonable value.
>> And this pattern repeats for every wake-up-from-cpu-idle for that workload.
>> This can be quite undesirable for latency- or response-time sensitive bursty
>> workloads. So we need to fix the governor's logic to detect such wake-up-from-
>> cpu-idle scenarios and start the workload at a reasonably high CPU frequency.
>>
>> One extreme solution would be to fake a load of 100% in such scenarios. But
>> that might lead to undesirable side-effects such as frequency spikes (which
>> might also need voltage changes) especially if the previous frequency happened
>> to be very low.
>>
>> We just want to avoid the stupidity of dropping down the frequency to a minimum
>> and then enduring a needless (and long) delay before ramping it up back again.
>> So, let us simply carry forward the previous load - that is, let us just pretend
>> that the 'load' for the current time-window is the same as the load for the
>> previous window. That way, the frequency and voltage will continue to be set
>> to whatever values they were set at previously. This means that bursty workloads
>> will get a chance to influence the CPU frequency at which they wake up from
>> cpu-idle, based on their past execution history. Thus, they might be able to
>> avoid suffering from slow wakeups and long response-times.
>>
>> [ The right way to solve this problem is to teach the CPU frequency governors
>> to track load on a per-task basis, not a per-CPU basis, and set the appropriate
>> frequency on whichever CPU the task executes. But that involves redesigning
>> the cpufreq subsystem, so this patch should make the situation bearable until
>> then. ]
>>
>> Experimental results:
>> ====================
> 
> This formatting of the changelog evidently confused Patchwork.
> 

Oh, I didn't realize that that would create problems!

> That's not a big deal, but please try to avoid that in the future if possible.
> 

Sorry, I'll be careful next time. Thanks for letting me know!

Regards,
Srivatsa S. Bhat


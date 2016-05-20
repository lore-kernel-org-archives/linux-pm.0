From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Fri, 20 May 2016 17:53:41 +0530
Message-ID: <201605201223.u4KCNaTI025072@mx0a-001b2d01.pphosted.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com> <20160519114029.GW3193@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160519114029.GW3193@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 05/19/2016 05:10 PM, Peter Zijlstra wrote:
> On Wed, May 18, 2016 at 11:11:51PM +0200, Rafael J. Wysocki wrote:
>> On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
>> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>>> This patch adds driver callback for fast_switch and below observations
>>> on schedutil governor are done with this patch.
>>>
>>> In POWER8 there is a regression observed with schedutil compared to
>>> ondemand. With schedutil the frequency is not ramping down and is
>>> mostly stuck at max frequency during idle . This is because of the
>>> watchdog timer, an RT task which is fired every 4 seconds which
>>> results in requesting max frequency.
>>
>> Well, yes, that would be problematic.
>>
> 
> Right; we need to come up with something for RT tasks; but what happens
> if you disable the watchdog? This should be entirely doable and might
> give a better comparison.
> 

Below are the comparisons by disabling watchdog.
Both schedutil and ondemand have a similar ramp-down trend. And in both the
cases I can see that frequency of the cpu is not reduced in deterministic
fashion. In a observation window of 30 seconds after running a workload I can
see that the frequency is not ramped down on some cpus in the system and are
idling at max frequency.

Below are the sample trace showcasing the frequency request when the cpu enters
idle with schedutil.
<...>-3528  7650.011010: cpu_frequency: state=4322000 cpu_id=120
<...>-3528  7650.027540: sched_switch: prev_comm=ppc64_cpu prev_state=x ==>
			next_comm=swapper/120
<idle>-0    7650.035017: cpu_frequency: state=4322000 cpu_id=120
<idle>-0    7729.683536: cpu_frequency: state=4322000 cpu_id=120
<idle>-0    7729.683552: sched_switch: prev_comm=swapper/120 prev_state=R ==>
			next_comm=kworker/120:1
kworker/120  7729.683565: sched_switch: prev_comm=kworker/120:1 prev_state=S ==>
			 next_comm=swapper/120

However ondemand governor(with watchdog enabled) benefits from the noise created
by watchdog timer and is able to brig down the frequency.

Thanks and Regards,
Shilpa

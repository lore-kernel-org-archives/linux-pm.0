From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
Date: Thu, 16 May 2019 11:06:59 +0530
Message-ID: <20190516053659.GA20396@in.ibm.com>
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
 <1557291178.ow4spjzq5t.astroid@bobo.none>
 <b2fcf69a-aecd-ea81-b497-737642354736@linux.vnet.ibm.com>
 <1557981860.eltms77ctp.astroid@bobo.none>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557981860.eltms77ctp.astroid@bobo.none>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Abhishek <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, daniel.lezcano@linaro.org, dja@axtens.net, ego@linux.vnet.ibm.com, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hello Nicholas,


On Thu, May 16, 2019 at 02:55:42PM +1000, Nicholas Piggin wrote:
> Abhishek's on May 13, 2019 7:49 pm:
> > On 05/08/2019 10:29 AM, Nicholas Piggin wrote:
> >> Abhishek Goel's on April 22, 2019 4:32 pm:
> >>> Currently, the cpuidle governors determine what idle state a idling CPU
> >>> should enter into based on heuristics that depend on the idle history on
> >>> that CPU. Given that no predictive heuristic is perfect, there are cases
> >>> where the governor predicts a shallow idle state, hoping that the CPU will
> >>> be busy soon. However, if no new workload is scheduled on that CPU in the
> >>> near future, the CPU will end up in the shallow state.
> >>>
> >>> Motivation
> >>> ----------
> >>> In case of POWER, this is problematic, when the predicted state in the
> >>> aforementioned scenario is a lite stop state, as such lite states will
> >>> inhibit SMT folding, thereby depriving the other threads in the core from
> >>> using the core resources.
> >>>
> >>> So we do not want to get stucked in such states for longer duration. To
> >>> address this, the cpuidle-core can queue timer to correspond with the
> >>> residency value of the next available state. This timer will forcefully
> >>> wakeup the cpu. Few such iterations will essentially train the governor to
> >>> select a deeper state for that cpu, as the timer here corresponds to the
> >>> next available cpuidle state residency. Cpu will be kicked out of the lite
> >>> state and end up in a non-lite state.
> >>>
> >>> Experiment
> >>> ----------
> >>> I performed experiments for three scenarios to collect some data.
> >>>
> >>> case 1 :
> >>> Without this patch and without tick retained, i.e. in a upstream kernel,
> >>> It would spend more than even a second to get out of stop0_lite.
> >>>
> >>> case 2 : With tick retained in a upstream kernel -
> >>>
> >>> Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
> >>> it to take 8 sched tick to get out of stop0_lite. Experimentally,
> >>> observation was
> >>>
> >>> =========================================================
> >>> sample          min            max           99percentile
> >>> 20              4ms            12ms          4ms
> >>> =========================================================
> >>>
> >>> It would take atleast one sched tick to get out of stop0_lite.
> >>>
> >>> case 2 :  With this patch (not stopping tick, but explicitly queuing a
> >>>            timer)
> >>>
> >>> ============================================================
> >>> sample          min             max             99percentile
> >>> ============================================================
> >>> 20              144us           192us           144us
> >>> ============================================================
> >>>
> >>> In this patch, we queue a timer just before entering into a stop0_lite
> >>> state. The timer fires at (residency of next available state + exit latency
> >>> of next available state * 2). Let's say if next state(stop0) is available
> >>> which has residency of 20us, it should get out in as low as (20+2*2)*8
> >>> [Based on the forumla (residency + 2xlatency)*history length] microseconds
> >>> = 192us. Ideally we would expect 8 iterations, it was observed to get out
> >>> in 6-7 iterations. Even if let's say stop2 is next available state(stop0
> >>> and stop1 both are unavailable), it would take (100+2*10)*8 = 960us to get
> >>> into stop2.
> >>>
> >>> So, We are able to get out of stop0_lite generally in 150us(with this
> >>> patch) as compared to 4ms(with tick retained). As stated earlier, we do not
> >>> want to get stuck into stop0_lite as it inhibits SMT folding for other
> >>> sibling threads, depriving them of core resources. Current patch is using
> >>> forced-wakeup only for stop0_lite, as it gives performance benefit(primary
> >>> reason) along with lowering down power consumption. We may extend this
> >>> model for other states in future.
> >> I still have to wonder, between our snooze loop and stop0, what does
> >> stop0_lite buy us.
> >>
> >> That said, the problem you're solving here is a generic one that all
> >> stop states have, I think. Doesn't the same thing apply going from
> >> stop0 to stop5? You might under estimate the sleep time and lose power
> >> savings and therefore performance there too. Shouldn't we make it
> >> generic for all stop states?
> >>
> >> Thanks,
> >> Nick
> >>
> >>
> > When a cpu is in snooze, it takes both space and time of core. When in 
> > stop0_lite,
> > it free up time but it still takes space.
> 
> True, but snooze should only be taking less than 1% of front end
> cycles. I appreciate there is some non-zero difference here, I just
> wonder in practice what exactly we gain by it.

The idea behind implementing a lite-state was that on the future
platforms it can be made to wait on a flag and hence act as a
replacement for snooze. On POWER9 we don't have this feature.

The motivation behind this patch was a HPC customer issue where they
were observing some CPUs in the core getting stuck at stop0_lite
state, thereby lowering the performance on the other CPUs of the core
which were running the application.

Disabling stop0_lite via sysfs didn't help since we would fallback to
snooze and it would make matters worse.

> 
> We should always have fewer states unless proven otherwise.

I agree.

> 
> That said, we enable it today so I don't want to argue this point
> here, because it is a different issue from your patch.
> 
> > When it is in stop0 or deeper, 
> > it free up both
> > space and time slice of core.
> > In stop0_lite, cpu doesn't free up the core resources and thus inhibits 
> > thread
> > folding. When a cpu goes to stop0, it will free up the core resources 
> > thus increasing
> > the single thread performance of other sibling thread.
> > Hence, we do not want to get stuck in stop0_lite for long duration, and 
> > want to quickly
> > move onto the next state.
> > If we get stuck in any other state we would possibly be losing on to 
> > power saving,
> > but will still be able to gain the performance benefits for other 
> > sibling threads.
> 
> That's true, but stop0 -> deeper stop is also a benefit (for
> performance if we have some power/thermal constraints, and/or for power
> usage).
> 
> Sure it may not be so noticable as the SMT switch, but I just wonder
> if the infrastructure should be there for the same reason.
> 
> I was testing interrupt frequency on some tickless workloads configs,
> and without too much trouble you can get CPUs to sleep with no
> interrupts for many minutes. Hours even. We wouldn't want the CPU to
> stay in stop0 for that long.

If it stays in stop0 or even stop2 for that long, we would want to
"promote" it to a deeper state, such as say STOP5 which allows the
other cores to run at higher frequencies.

> 
> Just thinking about the patch itself, I wonder do you need a full
> kernel timer, or could we just set the decrementer? Is there much 
> performance cost here?
>

Good point. A decrementer would do actually.

> Thanks,
> Nick

--
Thanks and Regards
gautham.

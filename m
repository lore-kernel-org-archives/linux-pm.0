From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/1] Forced-wakeup for stop lite states on Powernv
Date: Thu, 16 May 2019 13:52:38 +0530
Message-ID: <20190516082238.GB20396@in.ibm.com>
References: <20190422063231.51043-1-huntbag@linux.vnet.ibm.com>
 <1557291178.ow4spjzq5t.astroid@bobo.none>
 <b2fcf69a-aecd-ea81-b497-737642354736@linux.vnet.ibm.com>
 <1557981860.eltms77ctp.astroid@bobo.none>
 <20190516053659.GA20396@in.ibm.com>
 <1557986956.6pmjz10b9z.astroid@bobo.none>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557986956.6pmjz10b9z.astroid@bobo.none>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: ego@linux.vnet.ibm.com, daniel.lezcano@linaro.org, dja@axtens.net, Abhishek <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hi Nicholas,

On Thu, May 16, 2019 at 04:13:17PM +1000, Nicholas Piggin wrote:

> 
> > The motivation behind this patch was a HPC customer issue where they
> > were observing some CPUs in the core getting stuck at stop0_lite
> > state, thereby lowering the performance on the other CPUs of the core
> > which were running the application.
> > 
> > Disabling stop0_lite via sysfs didn't help since we would fallback to
> > snooze and it would make matters worse.
> 
> snooze has the timeout though, so it should kick into stop0 properly
> (and if it doesn't that's another issue that should be fixed in this
> series).
>
> I'm not questioning the patch for stop0_lite, to be clear. I think
> the logic is sound. I just raise one urelated issue that happens to
> be for stop0_lite as well (should we even enable it on P9?), and one
> peripheral issue (should we make a similar fix for deeper stop states?)
>

I think it makes sense to generalize this from the point of view of
CPUs remaining in shallower idle states for long durations on tickless
kernels.

> > 
> >> 
> >> We should always have fewer states unless proven otherwise.
> > 
> > I agree.
> > 
> >> 
> >> That said, we enable it today so I don't want to argue this point
> >> here, because it is a different issue from your patch.
> >> 
> >> > When it is in stop0 or deeper, 
> >> > it free up both
> >> > space and time slice of core.
> >> > In stop0_lite, cpu doesn't free up the core resources and thus inhibits 
> >> > thread
> >> > folding. When a cpu goes to stop0, it will free up the core resources 
> >> > thus increasing
> >> > the single thread performance of other sibling thread.
> >> > Hence, we do not want to get stuck in stop0_lite for long duration, and 
> >> > want to quickly
> >> > move onto the next state.
> >> > If we get stuck in any other state we would possibly be losing on to 
> >> > power saving,
> >> > but will still be able to gain the performance benefits for other 
> >> > sibling threads.
> >> 
> >> That's true, but stop0 -> deeper stop is also a benefit (for
> >> performance if we have some power/thermal constraints, and/or for power
> >> usage).
> >> 
> >> Sure it may not be so noticable as the SMT switch, but I just wonder
> >> if the infrastructure should be there for the same reason.
> >> 
> >> I was testing interrupt frequency on some tickless workloads configs,
> >> and without too much trouble you can get CPUs to sleep with no
> >> interrupts for many minutes. Hours even. We wouldn't want the CPU to
> >> stay in stop0 for that long.
> > 
> > If it stays in stop0 or even stop2 for that long, we would want to
> > "promote" it to a deeper state, such as say STOP5 which allows the
> > other cores to run at higher frequencies.
> 
> So we would want this same logic for all but the deepest runtime
> stop state?

Yes. We can, in steps, promote individual threads of the core to
eventually request a deeper state such as stop4/5. On a completely
idle tickless system, eventually we should see the core go to the
deeper idle state.

> 
> >> Just thinking about the patch itself, I wonder do you need a full
> >> kernel timer, or could we just set the decrementer? Is there much 
> >> performance cost here?
> >>
> > 
> > Good point. A decrementer would do actually.
> 
> That would be good if it does, might save a few cycles.
> 
> Thanks,
> Nick
>

--
Thanks and Regards
gautham.

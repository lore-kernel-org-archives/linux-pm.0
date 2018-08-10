From: leo.yan@linaro.org
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
Date: Fri, 10 Aug 2018 17:03:28 +0800
Message-ID: <20180810090327.GE11817@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
 <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810084906.GD11817@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 10, 2018 at 04:49:06PM +0800, Leo Yan wrote:
> On Fri, Aug 10, 2018 at 09:22:10AM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 10, 2018 at 9:13 AM,  <leo.yan@linaro.org> wrote:
> > > On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
> > >> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > 
> > [cut]
> > 
> > >> And that will cause the tick to be stopped unnecessarily in certain
> > >> situations, so why is this better?
> > >
> > > Let's see below two cases, the first one case we configure
> > > TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
> > > (4ms).
> > >
> > > Let's assume we do the testing one the same platform and have two runs,
> > > in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
> > > is 3ms and deepest idle state target residency is 2ms, finally the idle
> > > governor will choose the deepest state and skip to calibrate to shallow
> > > state caused by 'expected_interval' > TICK_USEC;
> > >
> > > In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
> > > (3ms) and deepest idle state target residency (2ms) are same with the
> > > Case 1; but because expected_interval < TICK_USEC so the idle governor
> > > will do calibration to select a shallower state.  If we image on one
> > > platform, the deepest idle state's target residency is smaller value,
> > > then it has bigger gap with TICK_USEC, the deepest idle state is harder
> > > to be selected due 'expected_interval' can be easily hit the range
> > > [Deepest target residency..TICK_USEC).
> > >
> > > This patch has no any change for Case 1 and it wants to optimize for
> > > Case 2 so Case 2 has chance to stay in deepest idle state.  I
> > > understand from the performance pespective, we need to avoid to stop
> > > tick for shallow states; on the other hand we cannot prevent CPU run
> > > into deepest idle state just only we want to keep the tick running,
> > > especially the expected interval is longer than the deepest state
> > > target residency.
> > >
> > > Case 1:
> > >       Deepest idle state's target residency=2ms
> > >                      |
> > >                      V
> > > |--------------------------------------------------------> time (ms)
> > >       ^                              ^
> > >       |                              |
> > > TICK_USEC=1ms           expected_interval=3ms
> > >
> > >
> > > Case 2:
> > >       Deepest idle state's target residency = 2ms
> > >                      |
> > >                      V
> > > |--------------------------------------------------------> time (ms)
> > >                                      ^                  ^
> > >                                      |                  |
> > >                           expected_interval = 3ms   TICK_USEC = 4ms
> > >
> > >
> > >
> > >> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
> > >> >
> > >> >                 *stop_tick = false;
> > >> > --
> > 
> > Well, I don't quite agree with the approach here, then.
> > 
> > As I said in the previous reply, IMO restarting the stopped tick
> > before leaving the loop in do_idle() is pointless overhead.  It is not
> > necessary to do that to avoid leaving CPUs in shallow idle states for
> > too long (I'll send an alternative patch to fix this issue shortly).
> > 
> > While you may think that pointless overhead is not a problem, I don't
> > quite agree with that.
> 
> I disagree this patch will introduce any extra overhead.
> 
> Firstly, the idle loop doesn't support restarting tick even this patch
> tells idle loop to restart the tick; secondly this patch is mainly to
> resolve issue for the CPU cannot stay in deepest state in Case 2, as a
> side effect it also can tell idle loop to restart the tick for case 3
> in below, actually IMHO this makes sense to tell the idle loop to
> enable the tick but idle loop can ignore this info.
> 
> Furthermore, we have another thread for the patch to always stop
> tick after the the tick has been stopped in the idle loop.
> 
> So this patch is still valid.

Correct for Case 3 as below, actually this case will disappear if we
force to set expected_interval=ktime_to_us(delta_next) in another
proposaled patch.  If so, this patch will have no any chance to
introduce extra ticks.

 expected_interval                             Deepest idle state's
 = min(TICK_USEC,ktime_to_us(delta_next))      target residency = 2ms
 = TICK_USEC = 1ms                                    |
      |                                               |
      V                                               V
|--------------------------------------------------------> time (ms)
      ^
      |
TICK_USEC=1ms

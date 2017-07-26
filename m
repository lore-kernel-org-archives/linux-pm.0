From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: [RFC PATCH v1 8/8] sched/deadline: make bandwidth enforcement
 scale-invariant
Date: Wed, 26 Jul 2017 15:50:20 +0200
Message-ID: <20170726155020.18d773a9@nowhere>
References: <20170705085905.6558-1-juri.lelli@arm.com>
        <20170705085905.6558-9-juri.lelli@arm.com>
        <20170719072143.lploljodns3kfucf@hirez.programming.kicks-ass.net>
        <20170719092029.oakmetq3u52e4rfw@e106622-lin>
        <20170719110028.uggud56bg2jh45ge@hirez.programming.kicks-ass.net>
        <20170719111624.fwcydcklmfeesfgb@e106622-lin>
        <20170724164349.clzsajrwxtobyqkm@hirez.programming.kicks-ass.net>
        <20170725090308.2cca53c0@luca>
        <20170725135105.akkwwsf3r65jy3pa@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725135105.akkwwsf3r65jy3pa@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Jul 2017 15:51:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jul 25, 2017 at 09:03:08AM +0200, Luca Abeni wrote:
> 
> > > I'm still confused..
> > > 
> > > So GRUB does:
> > > 
> > > 	dq = Uact -dt
> > > 
> > > right?  
> > 
> > Right. This is what the original (single processor) GRUB did. And
> > this was used by the "GRUB-PA" algorithm:
> > https://www.researchgate.net/profile/Giuseppe_Lipari/publication/220800940_Using_resource_reservation_techniques_for_power-aware_scheduling/links/09e41513639b2703fc000000.pdf
> > 
> > (basically, GRUB-PA uses GRUB for reclaiming, and scales the CPU
> > frequency based on Uact)
> > 
> >   
> > > Now, you do DVFS using that same Uact. If we lower the clock, we
> > > need more time, so would we then not end up with something like:
> > > 
> > > 	dq = 1/Uact -dt  
> > 
> > Well, in the GRUB-PA algorithm GRUB reclaiming is the mechanism
> > used to give more runtime to the task... Since Uact is < 1, doing
> > 	dq = - Uact * dt
> > means that we decrease the current runtime by a smaller amount of
> > time. And so we end up giving more runtime to the task: instead of
> > giving dl_runtime every dl_period, we give "dl_runtime / Uact" every
> > dl_period... And since the CPU is slower (by a ratio Uact), this is
> > equivalent to giving dl_runtime at the maximum CPU speed / frequency
> > (at least, in theory :).
> > 
> >   
> > > After all; our budget assignment is such that we're able to
> > > complete our work at max freq. Therefore, when we lower the
> > > frequency, we'll have to increase budget pro rata, otherwise
> > > we'll not complete our work and badness happens.  
> > 
> > Right. But instead of increasing dl_runtime, GRUB-PA decreases the
> > amount of time accounted to the current runtime.
> > 
> >   
> > > Say we have a 1 Ghz part and Uact=0.5 we'd select 500 Mhz and need
> > > double the time to complete.
> > > 
> > > Now, if we fold these two together, you'd get:
> > > 
> > > 	dq = Uact/Uact -dt = -dt  
> > 
> > Not sure why " / Uact"... According to the GRUB-PA algorithm, you
> > just do
> > 	dq = - Uact * dt = -0.5dt
> > and you end up giving the CPU to the task for 2 * dl_runtime every
> > dl_period (as expected)  
> 
> Yeah, I seem to have gone off the rails there... Bah I'm terminally
> confused now. Let me try and get my brain the right way up.

This stuff always confuses me too... :)

The parts that gives me more headaches is how to combine GRUB-PA with
non-reclaiming tasks, and how to cope with "real world issues" (such as
an actual DVFS frequency different from the theoretical one, GRUB
reclaiming less than 100% of the CPU time, etc...)

Anyway, Claudio is running some experiments with this patchset,
measuring power saving and missed deadlines for various sets of
periodic real-time tasks... We hope to present the results at RTLWS.


			Luca

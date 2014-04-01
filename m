From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle info
Date: Wed, 02 Apr 2014 01:01:11 +0200
Message-ID: <22904760.5rGZuP5nsx@vostro.rjw.lan>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, March 28, 2014 01:29:53 PM Daniel Lezcano wrote:
> The following patchset provides an interaction between cpuidle and the scheduler.
> 
> The first patch encapsulate the needed information for the scheduler in a
> separate cpuidle structure. The second one stores the pointer to this structure
> when entering idle. The third one, use this information to take the decision to
> find the idlest cpu.
> 
> After some basic testing with hackbench, it appears there is an improvement for
> the performances (small) and for the duration of the idle states (which provides
> a better power saving).
> 
> The measurement has been done with the 'idlestat' tool previously posted in this
> mailing list.
> 
> So the benefit is good for both sides performance and power saving.
> 
> The select_idle_sibling could be also improved in the same way.

Well, quite frankly, I don't really like this series.  Not the idea itself, but
the way it has been implemented.

First off, if the scheduler is to access idle state data stored in struct
cpuidle_state, I'm not sure why we need a separate new structure for that?
Couldn't there be a pointer to a whole struct cpuidle_state from struct rq
instead?  [->exit_latency is the only field that find_idlest_cpu() in your
third patch seems to be using anyway.]

Second, is accessing the idle state information for all CPUs from find_idlest_cpu()
guaranteed to be non-racy?  I mean, what if a CPU changes its state from idle to
non-idle while another one is executing find_idlest_cpu()?  In other words,
where's the read memory barrier corresponding to the write ones in the modified
cpu_idle_call()?  And is the memory barrier actually sufficient?  After all,
you need to guarantee that the CPU is still idle after you have evaluated
idle_cpu() on it.

Finally, is really the heuristics used by find_idlest_cpu() to select the "idlest"
CPU the best one?  What about deeper vs shallower idle states, for example?

Rafael

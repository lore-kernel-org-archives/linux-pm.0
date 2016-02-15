From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Mon, 15 Feb 2016 19:23:17 +0000
Message-ID: <20160215192316.GO10826@n2100.arm.linux.org.uk>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <56C21DD0.40508@arm.com>
 <CAJZ5v0gfOVyoWeee5jg7NxLFm-xwdA6-sPQV+cJ=NWJOV-wYzg@mail.gmail.com>
 <56C22105.6050900@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C22105.6050900@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2016 at 07:03:33PM +0000, Marc Zyngier wrote:
> On 15/02/16 18:54, Rafael J. Wysocki wrote:
> > That would explain it, thanks.
> > 
> > So it looks like we should always use irq_work_queue() on UP even if
> > CONFIG_SMP is set, shouldn't we?
> 
> Something like that, yes. CONFIG_SMP is not an indication of an SMP
> system anymore (we've even dropped the config option on arm64).
> 
> Hopefully num_possible_cpus() is reliable enough to let you do the right
> thing...

CONFIG_SMP just says whether to include support for SMP.  It doesn't
mandate running on a SMP system. :)

I've been looking around the usages of irq_work_queue_on in kernel/
in -rc4, and some places seem to check for "this CPU":

        /*
         * It is possible that a restart caused this CPU to be
         * chosen again. Don't bother with an IPI, just see if we
         * have more to push.
         */
        if (unlikely(cpu == rq->cpu))
                goto again;

        /* Try the next RT overloaded CPU */
        irq_work_queue_on(&rt_rq->push_work, cpu);

I'm not sure about tell_cpu_to_push().

It's also called via tick_nohz_full_kick_cpu(), and the core scheduler
avoids calling this for the current CPU:

        if (tick_nohz_full_cpu(cpu)) {
                if (cpu != smp_processor_id() ||
                    tick_nohz_tick_stopped())
                        tick_nohz_full_kick_cpu(cpu);

I'm not sure about add_nr_running() in kernel/sched/sched.h - I think
that _could_ be a problem even without Rafael's cpufreq change.

So... the question is what do we do with irq_work_queue_on() in general
when called on non-SMP systems.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

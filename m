From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date: Tue, 06 Nov 2018 15:55:06 +0100
Message-ID: <6592350.ldnZvJegIa@aspire.rjw.lan>
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <1541446371.3441.9.camel@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541446371.3441.9.camel@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 5, 2018 8:32:51 PM CET Giovanni Gherdovich wrote:
> On Sun, 2018-11-04 at 17:31 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 

[cut]

> > +
> > +/**
> > + * teo_update - Update CPU data after wakeup.
> > + * @drv: cpuidle driver containing state data.
> > + * @dev: Target CPU.
> > + */
> > +static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > +{
> > +       struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > +       unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
> > +       int i, idx_hit = -1, idx_timer = -1;
> > +       unsigned int measured_us;
> > +
> > +       if (cpu_data->time_span_ns == cpu_data->sleep_length_ns) {
> > +               /* One of the safety nets has triggered (most likely). */
> > +               measured_us = sleep_length_us;
> > +       } else {
> > +               measured_us = dev->last_residency;
> > +               i = cpu_data->last_state;
> > +               if (measured_us >= 2 * drv->states[i].exit_latency)
> > +                       measured_us -= drv->states[i].exit_latency;
> > +               else
> > +                       measured_us /= 2;
> > +       }
> > +
> 
> I haven't read this v3 yet,

The pattern detection code in it has a minor issue that needs addressing, so
I'm going to send a v4 later today (after testing it somewhat).

> so just a little comment on the bit above (which
> is there since v1).

To be precise, this piece is there in the menu governor too and I thought that
it made sense, so I copied it from there. :-)

> When you check for measured_us >= 2 * exit_latency, is that because
> dev->last_residency is composed by an "entry" latency, then the actual
> residency, and finally the exit_latency? I'm asking about the 2x factor
> there.

If measured_us is less than twice the state's exit latency, the difference
between it and the exit latency may be very small, so it is better to take a
half of it then as an upper bound estimate of it in case there are some
inaccuracies in the measurement.

> If that succeeds, you proceed to remove the exit_latency from
> measured_us... just once. Given how the condition is formulated, I expected
> measured_us -= 2 * exit_latency there.

The exit latency is subtracted once, because we are interested in the time
between asking the hardware to enter the idle state and the wakeup event.

The exit latency is the time between the wakeup event and the first instruction,
so it shouldn't be counted, roughly speaking.

> More: you acknowledge, in that snippet of code, that there can be
> dev->last_residency's smaller than twice the exit_latency, i.e. not even the
> time to entry/exit the state. Am I reading this right? Is that because both
> exit_latency and dev->last_residency are only approximations?

Yes, they are just approximations.

> I actually see quite a few of those extra-short residencies in my traces, even
> with dev->last_residency < exit_latency.

Well, they are expected to occur at least occasionally.

Cheers,
Rafael

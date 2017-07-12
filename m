From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Wed, 12 Jul 2017 23:25:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707122248270.2510@nanos>
References: <20170708000303.21863-1-dbasehore@chromium.org> <20170708000303.21863-2-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170708000303.21863-2-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Jul 2017, Derek Basehore wrote:
> Adds a new feature to tick to schedule wakeups on a CPU during freeze.
> This won't fully wake up the system (devices are not resumed), but
> allow simple platform functionality to be run during freeze with
> little power impact.
> 
> This implementation allows an idle driver to setup a timer event with
> the clock event device when entering freeze by calling
> tick_set_freeze_event. Only one caller should exist for the function.

Emphasis on should.

> tick_freeze_event_expired is used to check if the timer went off when
> the CPU wakes.

That makes me shudder.

> +/*
> + * Clockevent device may run during freeze
> + */
> +# define CLOCK_EVT_FEAT_FREEZE_NONSTOP	0x000100

Is that really restricted to freezing?

> +/**
> + * tick_set_freeze_event - Set timer to wake up the CPU from freeze.
> + *
> + * @cpu:	CPU to set the clock event for
> + * @delta:	time to wait before waking the CPU
> + *
> + * Returns 0 on success and -EERROR on failure.
> + */
> +int tick_set_freeze_event(int cpu, ktime_t delta)
> +{
> +	struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;

This is fundamentally wrong. If that is invoked for

     cpu != smp_processor_id()

then everything below is utter crap because you CANNOT access a real per
cpu timer of a remote CPU. x86 will silently fiddle on the current CPU and
others will create an utter mess or simply crash and burn.

The only way to use this is w/o the 'cpu' argument and restricted to the
clock events device of the CPU on which this is invoked.

> +	u64 delta_ns;
> +	int ret;
> +
> +	if (!dev->set_next_event ||

We have a feature flag for that.

> +	    !(dev->features & CLOCK_EVT_FEAT_FREEZE_NONSTOP)) {
> +		printk_deferred(KERN_WARNING
> +				"[%s] unsupported by clock event device\n",
> +				__func__);

Please get rid of these __func__ uglies. And looking at it, get rid of all
of this printk stuff. You have proper return codes, so the call site can
act accordingly.

> +		return -EPERM;
> +	}
> +
> +	if (!clockevent_state_shutdown(dev)) {

What puts the device in shutdown mode when the machine is in freeze state?

> +		printk_deferred(KERN_WARNING
> +				"[%s] clock event device in use\n",
> +				__func__);
> +		return -EBUSY;
> +	}
> +
> +	delta_ns = ktime_to_ns(delta);
> +	if (delta_ns > dev->max_delta_ns || delta_ns < dev->min_delta_ns) {
> +		printk_deferred(KERN_WARNING
> +				"[%s] %lluns outside range: [%lluns, %lluns]\n",
> +				__func__, delta_ns, dev->min_delta_ns,
> +				dev->max_delta_ns);
> +		return -ERANGE;
> +	}
> +
> +	clockevents_tick_resume(dev);

That looks wrong as well. What did call suspend on that device?

I'm not aware that freeze will actually call suspend on anything down deep
in the core code. Can you please explain this magic here?

> +	clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT);
> +	ret = dev->set_next_event((delta_ns * dev->mult) >> dev->shift, dev);
> +	if (ret < 0) {
> +		printk_deferred(KERN_WARNING
> +				"Failed to program freeze event\n");
> +		clockevents_shutdown(dev);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tick_set_freeze_event);
> +
> +/**
> + * tick_freeze_event_expired - Check if the programmed freeze event expired
> + *
> + * @cpu:	CPU to check the clock event device for an expired event
> + *
> + * Returns 1 if the event expired and 0 otherwise.
> + */
> +int tick_freeze_event_expired(int cpu)
> +{
> +	struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;
> +
> +	if (!(dev && dev->event_expired))
> +		return 0;
> +
> +	return dev->event_expired(dev);

Same issue vs. the cpu argument as above.

> +}
> +
> +/**
> + * tick_clear_freeze_event - Shuts down the clock device after programming a
> + * freeze event.
> + *
> + * @cpu:	CPU to shutdown the clock device for
> + *
> + * Returns 0 on success and -EERROR otherwise.
> + */
> +int tick_clear_freeze_event(int cpu)
> +{
> +	struct clock_event_device *dev = per_cpu(tick_cpu_device, cpu).evtdev;

Ditto.

> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (!clockevent_state_oneshot(dev))
> +		return -EBUSY;

All of this lacks an explanation how any of this is safe vs. the normal
operation of clock event devices and the tick device code.

This lacks documentation of calling conventions and checks which make sure
they are obeyed.

Thanks,

	tglx

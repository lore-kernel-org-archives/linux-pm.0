From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/6] PM / sleep: Make it possible to quiesce timers
 during suspend-to-idle
Date: Thu, 12 Feb 2015 14:24:47 +0100
Message-ID: <20150212132447.GX23123@twins.programming.kicks-ass.net>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
 <3761728.YL7DDdWRW2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3761728.YL7DDdWRW2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2015 at 05:03:44AM +0100, Rafael J. Wysocki wrote:
> Index: linux-pm/include/linux/cpuidle.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -50,6 +50,10 @@ struct cpuidle_state {
>  			int index);
>  
>  	int (*enter_dead) (struct cpuidle_device *dev, int index);

Do we want a comment here describing that enter_freeze() must not
re-enable interrupts _ever_?

To help people who want to enable this on their platform.

> +
> +	void (*enter_freeze) (struct cpuidle_device *dev,
> +			      struct cpuidle_driver *drv,
> +			      int index);
>  };

> +static void enter_freeze_proper(struct cpuidle_driver *drv,
> +				struct cpuidle_device *dev, int index)
> +{
> +	tick_freeze();
> +	/*
> +	 * The state used here cannot be a "coupled" one, because the "coupled"
> +	 * cpuidle mechanism enables interrupts and doing that with timekeeping
> +	 * suspended is generally unsafe.
> +	 */
> +	drv->states[index].enter_freeze(dev, drv, index);

	WARN_ON(!irqs_disabled());

To go along with the comment and catch fail?

> +	/*
> +	 * timekeeping_resume() that will be called by tick_unfreeze() for the
> +	 * last CPU executing it calls functions containing RCU read-side
> +	 * critical sections, so tell RCU about that.
> +	 */
> +	RCU_NONIDLE(tick_unfreeze());
> +}

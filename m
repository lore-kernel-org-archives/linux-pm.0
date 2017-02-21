From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
Date: Tue, 21 Feb 2017 17:48:45 +0000
Message-ID: <20170221174844.GE8605@leverpostej>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Feb 20, 2017 at 09:33:27PM +0100, Geert Uytterhoeven wrote:
> + - arm,psci-system-suspend-is-power-down
> +		Nothing in the PSCI specification requires the SoC to remain
> +		powered and to support wake-up sources when suspended using
> +		SYSTEM_SUSPEND.
> +		If your firmware implements the PSCI SYSTEM_SUSPEND operation
> +		by cutting power to the SoC, the only possibly wake-up sources
> +		are thus the ones connected to the PMIC.  In such case you
> +		should specify this property, so the operating system is aware
> +		it should use a different suspend method when other wake-up
> +		sources (e.g. wake on LAN, UART or GPIO) are enabled.
> +

My understanding is that we already have sufficient information here,
encoded in the wakeup-source property on devices. If DTs have
insufficient information today, we should add those as necessary rather
than modifying the PSCI node.

As Sudeep mentioned, we already have systems which fall into this
category, and those do not require us to do anything special.

As such, I do not believe this is the correct way to describe the
situation.

[...]

> @@ -440,12 +442,14 @@ static int psci_system_suspend_valid(suspend_state_t state)
>  static int psci_system_suspend_enter(suspend_state_t state)
>  {
>  	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		if (!psci_system_suspend_is_power_down ||
> +		    !wakeup_source_available())
> +			return cpu_suspend(0, psci_system_suspend);
> +		/* fall through */

I don't believe that this is the correct place to handle this.

The wakeup_source_available() check *might* be ok, though even with that
I'd rather we rejected the request rather than trying to fall back to a
PSCI_CPU_SUSPEND. Otherwise we have a potential silent power regression.

I can imagine that there are cases where the wakeup source is completely
external and invisible to Linux (e.g. a power button that has no
programming interface, and isn't desscribed at all). In that case, even
the wakeup_source_available() check might be too much. :/

What we could/should do is expose to userspace which suspend cases a
device can wake up the system from and/or whether a wakeup source is
suitable configured for a state currently. That way userspace can
determine whether it is gauranteed to be woken.

Thanks,
Mark.

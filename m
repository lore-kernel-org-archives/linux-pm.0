From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Mon, 29 Jul 2013 15:23:27 +0100
Message-ID: <20130729142327.GC6184@e102568-lin.cambridge.arm.com>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
 <51F67581.5080207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44463 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab3G2OXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 10:23:33 -0400
In-Reply-To: <51F67581.5080207@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

On Mon, Jul 29, 2013 at 03:00:33PM +0100, Daniel Lezcano wrote:
> On 07/25/2013 01:14 PM, Lorenzo Pieralisi wrote:

[...]

> > +/**
> > + * bl_enter_powerdown - Programs CPU to enter the specified state
> > + * @dev: cpuidle device
> > + * @drv: The target state to be programmed
> > + * @idx: state index
> > + *
> > + * Called from the CPUidle framework to program the device to the
> > + * specified target state selected by the governor.
> > + */
> > +static int bl_enter_powerdown(struct cpuidle_device *dev,
> > +				struct cpuidle_driver *drv, int idx)
> > +{
> > +	struct timespec ts_preidle, ts_postidle, ts_idle;
> > +	int ret;
> > +
> > +	/* Used to keep track of the total time in idle */
> > +	getnstimeofday(&ts_preidle);
> > +
> > +	cpu_pm_enter();
> > +
> > +	ret = cpu_suspend(0, bl_powerdown_finisher);
> > +	/* signals the MCPM core that CPU is out of low power state */
> > +	mcpm_cpu_powered_up();
> > +
> > +	cpu_pm_exit();
> > +
> > +	getnstimeofday(&ts_postidle);
> > +	ts_idle = timespec_sub(ts_postidle, ts_preidle);
> > +
> > +	dev->last_residency = ts_idle.tv_nsec / NSEC_PER_USEC +
> > +					ts_idle.tv_sec * USEC_PER_SEC;
> > +	local_irq_enable();
> 
> time computation and local irq enablement are handled by the cpuidle
> framework.

Absolutely, rebase leftover, sorry.

Thanks,
Lorenzo


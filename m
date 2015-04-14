From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [patch 33/39] power: reset: ltc2952: Remove bogus
 hrtimer_start() return value checks
Date: Tue, 14 Apr 2015 23:38:28 +0200
Message-ID: <20150414213828.GA30224@ci00147.xsens-tech.local>
References: <20150414203303.702062272@linutronix.de>
 <20150414203503.322172417@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150414203503.322172417@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Marcelo Tosatti <mtosatt@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?utf-8?B?UmVuw4PCqQ==?= Moll <linux@r-moll.nl>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 14, 2015 at 09:09:20PM +0000, Thomas Gleixner wrote:
> The return value of hrtimer_start() tells whether the timer was
> inactive or active already when hrtimer_start() was called.
>=20
> The code emits a bogus warning if the timer was active already
> claiming that the timer could not be started.
>=20
> Remove it.

Thanks for catching this.

> Cc: "Ren=C3=83=C2=A9 Moll" <Rene.Moll@xsens.com>

Rene no longer works at Xsens, so this address is no longer in use. Ins=
tead:

Cc: "Ren=C3=A9 Moll" <linux@r-moll.nl>

That said, I'm not sure if he's actively monitoring this mailbox, or
even if he should still be mentioned as maintainer of this driver.


> ---
>  drivers/power/reset/ltc2952-poweroff.c |   18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>=20
> Index: tip/drivers/power/reset/ltc2952-poweroff.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- tip.orig/drivers/power/reset/ltc2952-poweroff.c
> +++ tip/drivers/power/reset/ltc2952-poweroff.c
> @@ -120,18 +120,7 @@ static enum hrtimer_restart ltc2952_powe
> =20
>  static void ltc2952_poweroff_start_wde(struct ltc2952_poweroff *data=
)
>  {
> -	if (hrtimer_start(&data->timer_wde, data->wde_interval,
> -			  HRTIMER_MODE_REL)) {
> -		/*
> -		 * The device will not toggle the watchdog reset,
> -		 * thus shut down is only safe if the PowerPath controller
> -		 * has a long enough time-off before triggering a hardware
> -		 * power-off.
> -		 *
> -		 * Only sending a warning as the system will power-off anyway
> -		 */
> -		dev_err(data->dev, "unable to start the timer\n");
> -	}
> +	hrtimer_start(&data->timer_wde, data->wde_interval, HRTIMER_MODE_RE=
L);
>  }
> =20
>  static enum hrtimer_restart
> @@ -165,9 +154,8 @@ static irqreturn_t ltc2952_poweroff_hand
>  	}
> =20
>  	if (gpiod_get_value(data->gpio_trigger)) {
> -		if (hrtimer_start(&data->timer_trigger, data->trigger_delay,
> -				  HRTIMER_MODE_REL))
> -			dev_err(data->dev, "unable to start the wait timer\n");
> +		hrtimer_start(&data->timer_trigger, data->trigger_delay,
> +			      HRTIMER_MODE_REL);
>  	} else {
>  		hrtimer_cancel(&data->timer_trigger);
>  		/* omitting return value check, timer should have been valid */

You might as well remove this bogus comment along with the rest.
hrtimer_cancel()s return value says nothing about the validity of the
passed timer.

In any case

Acked-by: Frans Klaver <frans.klaver@xsens.com>

Thanks,
=46rans

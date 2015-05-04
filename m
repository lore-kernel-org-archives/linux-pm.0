From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/4] sched / idle: Eliminate the "reflect" check from
 cpuidle_idle_call()
Date: Mon, 04 May 2015 16:49:50 +0200
Message-ID: <5547870E.6060308@linaro.org>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <1728148.BeERL39LLY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35478 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbEDOty (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 10:49:54 -0400
Received: by wgyo15 with SMTP id o15so152754168wgy.2
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2015 07:49:53 -0700 (PDT)
In-Reply-To: <1728148.BeERL39LLY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/04/2015 03:57 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since cpuidle_reflect() should only be called if the idle state
> to enter was selected by cpuidle_select(), there is the "reflect"
> variable in cpuidle_idle_call() whose value is used to determine
> whether or not that is the case.
>
> However, if the entire code run between the conditional setting
> "reflect" and the call to cpuidle_reflect() is moved to a separate
> function, it will be possible to call that new function in both
> branches of the conditional, in which case cpuidle_reflect() will
> only need to be called from one of them too and the "reflect"
> variable won't be necessary any more.
>
> This eliminates one check made by cpuidle_idle_call() on the majority
> of its invocations, so change the code as described.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   kernel/sched/idle.c |   90 ++++++++++++++++++++++++++--------------=
------------
>   1 file changed, 46 insertions(+), 44 deletions(-)
>
> Index: linux-pm/kernel/sched/idle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -78,6 +78,46 @@ static void default_idle_call(void) {
>   		arch_cpu_idle();
>   }
>
> +static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_d=
evice *dev,
> +		      int next_state)
> +{
> +	int entered_state;
> +
> +	/* Fall back to the default arch idle method on errors. */
> +	if (next_state < 0) {
> +		default_idle_call();
> +		return next_state;
> +	}
> +
> +	/*
> +	 * The idle task must be scheduled, it is pointless to go to idle, =
just
> +	 * update no idle residency and return.
> +	 */
> +	if (current_clr_polling_and_test()) {
> +		dev->last_residency =3D 0;
> +		local_irq_enable();
> +		return -EBUSY;
> +	}
> +
> +	/* Take note of the planned idle state. */
> +	idle_set_state(this_rq(), &drv->states[next_state]);
> +
> +	/*
> +	 * Enter the idle state previously returned by the governor decisio=
n.
> +	 * This function will block until an interrupt occurs and will take
> +	 * care of re-enabling the local interrupts
> +	 */
> +	entered_state =3D cpuidle_enter(drv, dev, next_state);
> +
> +	/* The cpu is no longer idle or about to enter idle. */
> +	idle_set_state(this_rq(), NULL);
> +
> +	if (entered_state =3D=3D -EBUSY)
> +		default_idle_call();
> +
> +	return entered_state;
> +}
> +
>   /**
>    * cpuidle_idle_call - the main idle function
>    *
> @@ -92,7 +132,6 @@ static void cpuidle_idle_call(void)
>   	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
>   	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
>   	int next_state, entered_state;
> -	bool reflect;
>
>   	/*
>   	 * Check if the idle task must be rescheduled. If it is the
> @@ -137,56 +176,19 @@ static void cpuidle_idle_call(void)
>   			goto exit_idle;
>   		}
>
> -		reflect =3D false;
>   		next_state =3D cpuidle_find_deepest_state(drv, dev);
> +		call_cpuidle(drv, dev, next_state);
>   	} else {
> -		reflect =3D true;
>   		/*
>   		 * Ask the cpuidle framework to choose a convenient idle state.
>   		 */
>   		next_state =3D cpuidle_select(drv, dev);
> -	}
> -	/* Fall back to the default arch idle method on errors. */
> -	if (next_state < 0) {
> -		default_idle_call();
> -		goto exit_idle;
> -	}
> -
> -	/*
> -	 * The idle task must be scheduled, it is pointless to
> -	 * go to idle, just update no idle residency and get
> -	 * out of this function
> -	 */
> -	if (current_clr_polling_and_test()) {
> -		dev->last_residency =3D 0;
> -		entered_state =3D next_state;
> -		local_irq_enable();
> -		goto exit_idle;
> -	}
> -
> -	/* Take note of the planned idle state. */
> -	idle_set_state(this_rq(), &drv->states[next_state]);
> -
> -	/*
> -	 * Enter the idle state previously returned by the governor decisio=
n.
> -	 * This function will block until an interrupt occurs and will take
> -	 * care of re-enabling the local interrupts
> -	 */
> -	entered_state =3D cpuidle_enter(drv, dev, next_state);
> -
> -	/* The cpu is no longer idle or about to enter idle. */
> -	idle_set_state(this_rq(), NULL);
> -
> -	if (entered_state =3D=3D -EBUSY) {
> -		default_idle_call();
> -		goto exit_idle;
> -	}
> -
> -	/*
> -	 * Give the governor an opportunity to reflect on the outcome
> -	 */
> -	if (reflect)
> +		entered_state =3D call_cpuidle(drv, dev, next_state);
> +		/*
> +		 * Give the governor an opportunity to reflect on the outcome
> +		 */
>   		cpuidle_reflect(dev, entered_state);
> +	}
>
>   exit_idle:
>   	__current_set_polling();
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


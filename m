From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
Date: Wed, 29 Jun 2016 09:37:05 +0200
Message-ID: <57737AA1.7050201@linaro.org>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37770 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcF2HhJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 03:37:09 -0400
Received: by mail-wm0-f44.google.com with SMTP id a66so59641001wme.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2016 00:37:08 -0700 (PDT)
In-Reply-To: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM, arnd@arndb.de, Nicolas Pitre <nicolas.pitre@linaro.org>

On 06/29/2016 09:06 AM, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereb=
y
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exi=
ts
> due to this timeout, its last_residency will be target_residency of n=
ext
> deeper state.
>
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()=
")
> changed the math around last_residency calculation. Specifically, whi=
le
> converting last_residency value from nanoseconds to microseconds it d=
oes
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency =
of
> next available state. This pattern is picked up get_typical_interval(=
)
> in the menu governor and therefore expected_interval in menu_select()=
 is
> frequently less than the target_residency of any state but snooze.
>
> Due to this we are entering snooze at a higher rate, thereby affectin=
g
> the single thread performance.
>
> Fix this by using a better approximation for division by 1000.
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Suggested-by David Laight <david.laight@aculab.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

[Cc'ed Nicolas Pitre]

> ---
> Changes in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   - Using approximation suggested by David
>
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   - Fixing it in the cpuidle core code instead of driver code.
>
>   drivers/cpuidle/cpuidle.c | 11 +++--------
>   drivers/cpuidle/cpuidle.h | 23 +++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index a4d0059..e9a7f74 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -174,7 +174,6 @@ int cpuidle_enter_state(struct cpuidle_device *de=
v, struct cpuidle_driver *drv,
>   	struct cpuidle_state *target_state =3D &drv->states[index];
>   	bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TIMER_STO=
P);
>   	u64 time_start, time_end;
> -	s64 diff;
>
>   	/*
>   	 * Tell the time framework to switch to a broadcast timer because =
our
> @@ -218,14 +217,10 @@ int cpuidle_enter_state(struct cpuidle_device *=
dev, struct cpuidle_driver *drv,
>   		local_irq_enable();
>
>   	/*
> -	 * local_clock() returns the time in nanosecond, let's shift
> -	 * by 10 (divide by 1024) to have microsecond based time.
> +	 * local_clock() returns the time in nanosecond, convert it to
> +	 * microsecond based time.
>   	 */
> -	diff =3D (time_end - time_start) >> 10;
> -	if (diff > INT_MAX)
> -		diff =3D INT_MAX;
> -
> -	dev->last_residency =3D (int) diff;
> +	dev->last_residency =3D convert_nsec_to_usec(time_end - time_start)=
;
>
>   	if (entered_state >=3D 0) {
>   		/* Update cpuidle counters */
> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> index f87f399..c8ea5ad 100644
> --- a/drivers/cpuidle/cpuidle.h
> +++ b/drivers/cpuidle/cpuidle.h
> @@ -68,4 +68,27 @@ static inline void cpuidle_coupled_unregister_devi=
ce(struct cpuidle_device *dev)
>   }
>   #endif
>
> +/*
> + * Used for calculating last_residency in usec. Optimized for case
> + * where last_residency in nsecs is < INT_MAX/2 by using faster
> + * approximation. Approximated value has less than 1% error.
> + */
> +static inline int convert_nsec_to_usec(u64 nsec)
> +{
> +	if (likely(nsec < INT_MAX / 2)) {

UINT_MAX ?

> +		int usec =3D (int)nsec;
> +
> +		usec +=3D usec >> 5;
> +		usec =3D usec >> 10;
> +		return usec;
> +	} else {
> +		u64 usec =3D div_u64(nsec, 1000);
> +
> +		if (usec > INT_MAX)
> +			usec =3D INT_MAX;
> +		return (int)usec;
> +	}
> +}



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


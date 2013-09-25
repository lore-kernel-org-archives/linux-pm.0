From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/21] cpuidle: reduce code duplication inside cpuidle_idle_call()
Date: Thu, 26 Sep 2013 00:01:14 +0200
Message-ID: <52435D2A.1000907@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <5e4629515deb76208df205210a77b1e8a9984f79.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e4629515deb76208df205210a77b1e8a9984f79.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> We are doing this twice in cpuidle_idle_call() routine:
> 	drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP
>=20
> Would be better if we actually store this in a local variable and use=
 that. That
> would remove code duplication as well as make this piece of code run =
fast (in
> case compiler wasn't able to optimize it earlier)
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/cpuidle.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index b8c63cb..ed67e3c 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -118,6 +118,7 @@ int cpuidle_idle_call(void)
>  	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
>  	struct cpuidle_driver *drv;
>  	int next_state, entered_state;
> +	bool broadcast;
> =20
>  	if (cpuidle_disabled() || !initialized)
>  		return -ENODEV;
> @@ -141,7 +142,9 @@ int cpuidle_idle_call(void)
> =20
>  	trace_cpu_idle_rcuidle(next_state, dev->cpu);
> =20
> -	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
> +	broadcast =3D drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_ST=
OP;
> +
> +	if (broadcast)
>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>  				   &dev->cpu);
> =20
> @@ -151,7 +154,7 @@ int cpuidle_idle_call(void)
>  	else
>  		entered_state =3D cpuidle_enter_state(dev, drv, next_state);
> =20
> -	if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
> +	if (broadcast)
>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>  				   &dev->cpu);
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] intel_idle: Removing the redundant calculating for
 dev->state_count
Date: Sat, 09 Mar 2013 04:00:16 +0100
Message-ID: <513AA5C0.2020604@linaro.org>
References: <1362674529.31506.17.camel@cliu38-desktop-build>  <1362754926.31506.42.camel@cliu38-desktop-build> <1362755074.31506.45.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:33277 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760174Ab3CIDAV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Mar 2013 22:00:21 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so1839902pbb.32
        for <linux-pm@vger.kernel.org>; Fri, 08 Mar 2013 19:00:20 -0800 (PST)
In-Reply-To: <1362755074.31506.45.camel@cliu38-desktop-build>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: lenb@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/08/2013 04:04 PM, Chuansheng Liu wrote:
>=20
> In function intel_idle_cpu_init() and intel_idle_cpuidle_driver_init(=
),
> they are having the same for(;;) loop.
>=20
> Here in intel_idle_cpu_init(), the dev->state_count can be assigned b=
y
> drv->state_count directly.
>=20
> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---
>  drivers/idle/intel_idle.c |   30 ++----------------------------
>  1 files changed, 2 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 17c9cf9..503b401 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -599,38 +599,12 @@ static int intel_idle_cpuidle_driver_init(void)
>   */
>  static int intel_idle_cpu_init(int cpu)
>  {
> -	int cstate;
>  	struct cpuidle_device *dev;
> +	struct cpuidle_driver *drv =3D &intel_idle_driver;
> =20
>  	dev =3D per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
> =20
> -	dev->state_count =3D 1;
> -
> -	for (cstate =3D 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> -		int num_substates, mwait_hint, mwait_cstate, mwait_substate;
> -
> -		if (cpuidle_state_table[cstate].enter =3D=3D NULL)
> -			break;
> -
> -		if (cstate + 1 > max_cstate) {
> -			printk(PREFIX "max_cstate %d reached\n", max_cstate);
> -			break;
> -		}
> -
> -		mwait_hint =3D flg2MWAIT(cpuidle_state_table[cstate].flags);
> -		mwait_cstate =3D MWAIT_HINT2CSTATE(mwait_hint);
> -		mwait_substate =3D MWAIT_HINT2SUBSTATE(mwait_hint);
> -
> -		/* does the state exist in CPUID.MWAIT? */
> -		num_substates =3D (mwait_substates >> ((mwait_cstate + 1) * 4))
> -					& MWAIT_SUBSTATE_MASK;
> -
> -		/* if sub-state in table is not enumerated by CPUID */
> -		if ((mwait_substate + 1) > num_substates)
> -			continue;
> -
> -		dev->state_count +=3D 1;
> -	}
> +	dev->state_count =3D drv->state_count;

The cpuidle_register_device function already does this initialization.

Probably you can get rid of this initialization and certainly factor ou=
t
a bit the code in this case.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


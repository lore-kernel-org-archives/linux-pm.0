From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] intel_idle: changing the continue to break in intel_idle_cpu_init()
Date: Sat, 09 Mar 2013 04:01:06 +0100
Message-ID: <513AA5F2.1000909@linaro.org>
References: <1362674529.31506.17.camel@cliu38-desktop-build>  <1362754926.31506.42.camel@cliu38-desktop-build> <1362755024.31506.44.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362755024.31506.44.camel@cliu38-desktop-build>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: lenb@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/08/2013 04:03 PM, Chuansheng Liu wrote:
>=20
> According to commit e022e7eb9, the .enter =3D=3D NULL is the last one=
 in
> state_tables[].
>=20
> So just like intel_idle_cpuidle_driver_init(), in case of .enter =3D=3D=
 NULL,
> breaking the for(;;) loop directly.
>=20
> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---

Sounds good.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/idle/intel_idle.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 5d66750..17c9cf9 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -610,7 +610,7 @@ static int intel_idle_cpu_init(int cpu)
>  		int num_substates, mwait_hint, mwait_cstate, mwait_substate;
> =20
>  		if (cpuidle_state_table[cstate].enter =3D=3D NULL)
> -			continue;
> +			break;
> =20
>  		if (cstate + 1 > max_cstate) {
>  			printk(PREFIX "max_cstate %d reached\n", max_cstate);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

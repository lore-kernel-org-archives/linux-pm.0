From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] intel_idle: set the state_tables array into __initdata
 to save mem
Date: Thu, 07 Mar 2013 10:49:25 +0100
Message-ID: <513862A5.7060600@linaro.org>
References: <1362674529.31506.17.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50395 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab3CGJta (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Mar 2013 04:49:30 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so343029pab.18
        for <linux-pm@vger.kernel.org>; Thu, 07 Mar 2013 01:49:29 -0800 (PST)
In-Reply-To: <1362674529.31506.17.camel@cliu38-desktop-build>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: lenb@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/07/2013 05:42 PM, Chuansheng Liu wrote:
>=20
> Currently, in intel_idle.c, there are 5 state_tables array, every
> array size is sizeof(struct cpuidle_state) * CPUIDLE_STATE_MAX.
>=20
> But after intel_idle_probe(), just only one array is useful.
>=20
> Here we can just define one static state_table, and initialize it
> in intel_idle_probe(), and set other data state_tables as __initdata.
>=20
> It can save about 3K, which also benefits mobile devices.
>=20
> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---
>  drivers/idle/intel_idle.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 5d66750..0642bfe 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -99,7 +99,7 @@ static int intel_idle(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv, int index);
>  static int intel_idle_cpu_init(int cpu);
> =20
> -static struct cpuidle_state *cpuidle_state_table;
> +static struct cpuidle_state cpuidle_state_table[CPUIDLE_STATE_MAX];
> =20
>  /*
>   * Set this flag for states where the HW flushes the TLB for us
> @@ -124,7 +124,7 @@ static struct cpuidle_state *cpuidle_state_table;
>   * which is also the index into the MWAIT hint array.
>   * Thus C0 is a dummy.
>   */
> -static struct cpuidle_state nehalem_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state nehalem_cstates[CPUIDLE_STATE_MAX] __ini=
tdata =3D {
>  	{
>  		.name =3D "C1-NHM",
>  		.desc =3D "MWAIT 0x00",
> @@ -157,7 +157,7 @@ static struct cpuidle_state nehalem_cstates[CPUID=
LE_STATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state snb_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state snb_cstates[CPUIDLE_STATE_MAX] __initdat=
a =3D {
>  	{
>  		.name =3D "C1-SNB",
>  		.desc =3D "MWAIT 0x00",
> @@ -197,7 +197,7 @@ static struct cpuidle_state snb_cstates[CPUIDLE_S=
TATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state ivb_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state ivb_cstates[CPUIDLE_STATE_MAX] __initdat=
a =3D {
>  	{
>  		.name =3D "C1-IVB",
>  		.desc =3D "MWAIT 0x00",
> @@ -237,7 +237,7 @@ static struct cpuidle_state ivb_cstates[CPUIDLE_S=
TATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state hsw_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state hsw_cstates[CPUIDLE_STATE_MAX] __initdat=
a =3D {
>  	{
>  		.name =3D "C1-HSW",
>  		.desc =3D "MWAIT 0x00",
> @@ -277,7 +277,7 @@ static struct cpuidle_state hsw_cstates[CPUIDLE_S=
TATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state atom_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state atom_cstates[CPUIDLE_STATE_MAX] __initda=
ta =3D {
>  	{
>  		.name =3D "C1E-ATM",
>  		.desc =3D "MWAIT 0x00",
> @@ -504,7 +504,12 @@ static int intel_idle_probe(void)
>  	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
> =20
>  	icpu =3D (const struct idle_cpu *)id->driver_data;
> -	cpuidle_state_table =3D icpu->state_table;
> +	/* Copy the icpu->state_table into cpuidle_state_table,
> +	 * The pointing array by icpu->state_table is with __initdata,
> +	 * which will be freed after kernel init ending.
> +	 */
> +	memcpy(cpuidle_state_table, icpu->state_table,
> +			sizeof(cpuidle_state_table));

The idea is good but it could be pushed a bit further.

Instead of changing cpuidle_state_table to an array, change it to an
initdata and the functions intel_idle_cpuidle_driver_init,
intel_idle_probe to init functions.

That would also be nice to get rid of a global variable to store the
current cpu data and let the intel_idle_probe to return the pointer to
the right table.


>  	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer *=
/
>  		lapic_timer_reliable_states =3D LAPIC_TIMER_ALWAYS_RELIABLE;
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


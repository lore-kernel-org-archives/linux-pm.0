From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] intel_idle: shrink states tables
Date: Mon, 02 Sep 2013 11:30:45 +0200
Message-ID: <52245AC5.2010305@linaro.org>
References: <2945985.mxvmQoz8DY@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:64769 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485Ab3IBJaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2013 05:30:46 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so1435306bkh.25
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2013 02:30:45 -0700 (PDT)
In-Reply-To: <2945985.mxvmQoz8DY@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/30/2013 12:25 PM, Bartlomiej Zolnierkiewicz wrote:
> There is no reason to define CPUIDLE_STATE_MAX (currently 10) entries
> in states tables if the driver always stops iterating over table when
> it encounters first .enter =3D=3D NULL entry.
>=20
> $ size drivers/idle/intel_idle.o.*
>    text    data     bss     dec     hex filename
>    2886    5440      32    8358    20a6 drivers/idle/intel_idle.o.bef=
ore
>    2886    3752      32    6670    1a0e drivers/idle/intel_idle.o.aft=
er
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Len Brown <lenb@kernel.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/idle/intel_idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index fa6964d..9c97fbb42 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -123,7 +123,7 @@ static struct cpuidle_state *cpuidle_state_table;
>   * which is also the index into the MWAIT hint array.
>   * Thus C0 is a dummy.
>   */
> -static struct cpuidle_state nehalem_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state nehalem_cstates[] =3D {
>  	{
>  		.name =3D "C1-NHM",
>  		.desc =3D "MWAIT 0x00",
> @@ -156,7 +156,7 @@ static struct cpuidle_state nehalem_cstates[CPUID=
LE_STATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state snb_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state snb_cstates[] =3D {
>  	{
>  		.name =3D "C1-SNB",
>  		.desc =3D "MWAIT 0x00",
> @@ -196,7 +196,7 @@ static struct cpuidle_state snb_cstates[CPUIDLE_S=
TATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state ivb_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state ivb_cstates[] =3D {
>  	{
>  		.name =3D "C1-IVB",
>  		.desc =3D "MWAIT 0x00",
> @@ -236,7 +236,7 @@ static struct cpuidle_state ivb_cstates[CPUIDLE_S=
TATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state hsw_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state hsw_cstates[] =3D {
>  	{
>  		.name =3D "C1-HSW",
>  		.desc =3D "MWAIT 0x00",
> @@ -297,7 +297,7 @@ static struct cpuidle_state hsw_cstates[CPUIDLE_S=
TATE_MAX] =3D {
>  		.enter =3D NULL }
>  };
> =20
> -static struct cpuidle_state atom_cstates[CPUIDLE_STATE_MAX] =3D {
> +static struct cpuidle_state atom_cstates[] =3D {
>  	{
>  		.name =3D "C1E-ATM",
>  		.desc =3D "MWAIT 0x00",
> @@ -628,7 +628,7 @@ static int intel_idle_cpu_init(int cpu)
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


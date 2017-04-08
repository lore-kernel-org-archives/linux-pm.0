From: =?UTF-8?Q?=27Ond=C5=99ej_Jirman=27_via_linux=2Dsunxi?= <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: [PATCH 1/5] clk: sunxi-ng: prevent NKMP clocks from
 temporarily get higher freq
Date: Sat, 08 Apr 2017 23:59:48 +0200
Message-ID: <1491688788.19320.3.camel@xff.cz>
References: <20170408185025.53841-1-icenowy@aosc.io>
	 <20170408185025.53841-2-icenowy@aosc.io>
Reply-To: megi-DlDF6nMZSto@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBC55PRMWZULRB7F2UXDQKGQE32XU2MI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20170408185025.53841-2-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-h8G6r0blFSE@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Icenowy,

I already tried this approach to changing CPUX_PLL and it didn't work
well. I've written a test program for CPUS (additional RISC-V processor
on H3 SoC) for testing various NKMP clock change algorithms, by
randomly changing the PLL frequency. Everything except simply not using
dividers except for P for frequencies < 288MHz just led to crashes of
the main CPU.

It is really hard to rule out crashes just by using the kernel itself,
because it is hard to hit the wrong change in the combination of NKMP
clock factors.

Here's the code for CPUS test program: https://github.com/megous/h3-fir
mware

Your approach is similar to this (increase dividers if necessary, wait
a bit, then change multipliers, wait a bit, and then decrease dividers
if necessary) - which is the approach taken by Allwinner in their code:

https://github.com/megous/h3-firmware/blob/master/clk.c#L683

It sometimes works when done in the kernel, but it is not stable. You
might get a crash only if thermal throttling causes a specific
transition between two particular frequencies. It's hard and tedious to
reproduce. That's why I have written the test program. In the CPUS test
program it crashes the main CPU predictably in about 2 seconds.

You can try it yourself with your exact algorithm. I guess it will be
crashing too.

regards,
  o.j.

Icenowy Zheng p=C3=AD=C5=A1e v Ne 09. 04. 2017 v 02:50 +0800:
> It seems that on newer SoCs (already observed on A33, H3), when setting
> all NKMP factors at the same time, the multiplier get applied first,
> then the divider get applied. In some situations (e.g. the multiplier
> increased but the divider decreased), this will make the clock
> frequency temporarily higher than both the original frequency and the
> target frequency, which may lead to system hang due to PLL_CPU(X) clock
> usually being a NKMP clock.
>=20
> A comparsion between the old divider (M*P) and the new one is added, and
> if the divider get smaller when changing clock, the multiplier will be
> applied first, so that the clock won't go to a frequency higher than
> normal.
>=20
> The interval between applying the first group of factors and the second
> group is based on experiments results on an Orange Pi Zero board.
>=20
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 76 +++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 65 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_n=
kmp.c
> index e58c95787f94..5da77eb60335 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -9,6 +9,7 @@
>   */
> =20
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
> =20
>  #include "ccu_gate.h"
>  #include "ccu_nkmp.h"
> @@ -130,12 +131,49 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, =
unsigned long rate,
>  	return *parent_rate * _nkmp.n * _nkmp.k / (_nkmp.m * _nkmp.p);
>  }
> =20
> +static void ccu_nkmp_extract_factors(const struct ccu_nkmp *nkmp,
> +				     struct _ccu_nkmp *_nkmp, u32 reg)
> +{
> +	_nkmp->n =3D ((reg >> nkmp->n.shift) & GENMASK(nkmp->n.width - 1, 0))
> +		   + nkmp->n.offset;
> +	_nkmp->k =3D ((reg >> nkmp->k.shift) & GENMASK(nkmp->k.width - 1, 0))
> +		   + nkmp->k.offset;
> +	_nkmp->m =3D ((reg >> nkmp->m.shift) & GENMASK(nkmp->m.width - 1, 0))
> +		   + nkmp->m.offset;
> +	_nkmp->p =3D 1 <<
> +		   ((reg >> nkmp->p.shift) & GENMASK(nkmp->p.width - 1, 0));
> +}
> +
> +static u32 ccu_nkmp_apply_multiplier(const struct ccu_nkmp *nkmp,
> +				     const struct _ccu_nkmp *_nkmp, u32 reg)
> +{
> +	reg &=3D ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
> +	reg &=3D ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> +
> +	reg |=3D (_nkmp->n - nkmp->n.offset) << nkmp->n.shift;
> +	reg |=3D (_nkmp->k - nkmp->k.offset) << nkmp->k.shift;
> +
> +	return reg;
> +}
> +
> +static u32 ccu_nkmp_apply_divider(const struct ccu_nkmp *nkmp,
> +				  const struct _ccu_nkmp *_nkmp, u32 reg)
> +{
> +	reg &=3D ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
> +	reg &=3D ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
> +
> +	reg |=3D (_nkmp->m - nkmp->m.offset) << nkmp->m.shift;
> +	reg |=3D ilog2(_nkmp->p) << nkmp->p.shift;
> +
> +	return reg;
> +}
> +
>  static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
>  			   unsigned long parent_rate)
>  {
>  	struct ccu_nkmp *nkmp =3D hw_to_ccu_nkmp(hw);
> -	struct _ccu_nkmp _nkmp;
> -	unsigned long flags;
> +	struct _ccu_nkmp _nkmp, _nkmp_old;
> +	unsigned long flags, old_mp, mp;
>  	u32 reg;
> =20
>  	_nkmp.min_n =3D nkmp->n.min ?: 1;
> @@ -152,17 +190,33 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, uns=
igned long rate,
>  	spin_lock_irqsave(nkmp->common.lock, flags);
> =20
>  	reg =3D readl(nkmp->common.base + nkmp->common.reg);
> -	reg &=3D ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
> -	reg &=3D ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> -	reg &=3D ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
> -	reg &=3D ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
> =20
> -	reg |=3D (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
> -	reg |=3D (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
> -	reg |=3D (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
> -	reg |=3D ilog2(_nkmp.p) << nkmp->p.shift;
> +	ccu_nkmp_extract_factors(nkmp, &_nkmp_old, reg);
> +
> +	old_mp =3D _nkmp_old.m * _nkmp_old.p;
> +	mp =3D _nkmp.m * _nkmp.p;
> +
> +	if (mp > old_mp) {
> +		reg =3D ccu_nkmp_apply_divider(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +
> +		/*
> +		 * This value is decided by experiment results on an
> +		 * Allwinner H2+ board (Orange Pi Zero).
> +		 */
> +		udelay(500);
> =20
> -	writel(reg, nkmp->common.base + nkmp->common.reg);
> +		reg =3D ccu_nkmp_apply_multiplier(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +	} else {
> +		reg =3D ccu_nkmp_apply_multiplier(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +
> +		udelay(500);
> +
> +		reg =3D ccu_nkmp_apply_divider(nkmp, &_nkmp, reg);
> +		writel(reg, nkmp->common.base + nkmp->common.reg);
> +	}
> =20
>  	spin_unlock_irqrestore(nkmp->common.lock, flags);
> =20
> --=20
> 2.12.2
>=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

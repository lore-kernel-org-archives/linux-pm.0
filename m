From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] battery: max17042: Fix temperature unit to milli
 centigrade.
Date: Fri, 25 Oct 2013 16:17:20 -0700
Message-ID: <20131025231720.GB9015@teo>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:63241 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3JYXRY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 19:17:24 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5883995pdi.33
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 16:17:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On Fri, Oct 25, 2013 at 01:53:18PM +0900, Jonghwa Lee wrote:
> Standard temp node represents temperature of power supply class
> in milli centigrade. So fix max17042 fuel gauge driver to follow
> the standard. (deci-centigrade --> milli-centigrade)

Maybe I am confused, but the doc says:

 * All voltages, currents, charges, energies, time and temperatures in =
uV,     =20
 * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsius un=
less otherwise         =20
 * stated

So, the current code seems to be correct.

Thanks,

Anton

> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/power/max17042_battery.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max1704=
2_battery.c
> index d664ef5..892ecfc 100644
> --- a/drivers/power/max17042_battery.c
> +++ b/drivers/power/max17042_battery.c
> @@ -220,9 +220,9 @@ static int max17042_get_property(struct power_sup=
ply *psy,
>  			val->intval =3D (0x7fff & ~val->intval) + 1;
>  			val->intval *=3D -1;
>  		}
> -		/* The value is converted into deci-centigrade scale */
> +		/* The value is converted into milli-centigrade scale */
>  		/* Units of LSB =3D 1 / 256 degree Celsius */
> -		val->intval =3D val->intval * 10 / 256;
> +		val->intval =3D val->intval * 1000 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		if (chip->pdata->enable_current_sense) {
> --=20
> 1.7.9.5

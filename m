From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] thermal: armada: Fix possible overflow in the Armada 380 thermal sensor formula
Date: Wed, 09 Sep 2015 18:44:08 +0200
Message-ID: <87r3m78rvr.fsf@free-electrons.com>
References: <1438877029-32514-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48783 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752438AbbIIQoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 12:44:10 -0400
In-Reply-To: <1438877029-32514-1-git-send-email-gregory.clement@free-electrons.com>
	(Gregory CLEMENT's message of "Thu, 6 Aug 2015 18:03:49 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Hi Zhang,
=20
 On jeu., ao=C3=BBt 06 2015, Gregory CLEMENT <gregory.clement@free-elec=
trons.com> wrote:

> From: Nadav Haklai <nadavh@marvell.com>
>
> Update the coefficients so the calculation will not overrun the
> unsigned long 32bits boundary

What is the status of this patch?

I still do not see it in your git tree. If you need any modification to
take it, don't hesitate to tell me.

Thanks,

Gregory


>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Victor Axelrod <victora@marvell.com>
> Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/thermal/armada_thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armad=
a_thermal.c
> index 01255fd65135..363bf91c32a3 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -224,9 +224,9 @@ static const struct armada_thermal_data armada380=
_data =3D {
>  	.is_valid_shift =3D 10,
>  	.temp_shift =3D 0,
>  	.temp_mask =3D 0x3ff,
> -	.coef_b =3D 2931108200UL,
> -	.coef_m =3D 5000000UL,
> -	.coef_div =3D 10502,
> +	.coef_b =3D 1172499100UL,
> +	.coef_m =3D 2000096UL,
> +	.coef_div =3D 4201,
>  	.inverted =3D true,
>  };

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

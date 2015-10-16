From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/3] power: bq27xxx_battery: fix platform probe
Date: Fri, 16 Oct 2015 16:47:39 +0200
Message-ID: <20151016144739.GH28216@pali>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37756 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbbJPOrl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 10:47:41 -0400
Content-Disposition: inline
In-Reply-To: <1445003052-31373-2-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 16 October 2015 15:44:10 Sebastian Reichel wrote:
> Add missing initialization of register mapping table to
> platform probe function.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/power/bq27xxx_battery.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_=
battery.c
> index 994c78d9f426..69e6b371a51c 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -1292,6 +1292,7 @@ static int bq27xxx_battery_platform_probe(struc=
t platform_device *pdev)
> =20
>  	di->dev =3D &pdev->dev;
>  	di->chip =3D pdata->chip;
> +	di->regs =3D bq27xxx_regs[di->chip];
> =20
>  	name =3D pdata->name ?: dev_name(&pdev->dev);
>  	di->bus.read =3D &bq27xxx_battery_platform_read;

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

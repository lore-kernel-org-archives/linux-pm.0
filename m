From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Remove unneeded dependency in
 Kconfig
Date: Fri, 16 Oct 2015 17:15:31 +0200
Message-ID: <20151016151531.GJ28216@pali>
References: <1445006960-3655-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36438 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbbJPPPf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 11:15:35 -0400
Content-Disposition: inline
In-Reply-To: <1445006960-3655-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 16 October 2015 09:49:20 Andrew F. Davis wrote:
> I2C is only required when using the config item BATTERY_BQ27XXX_I2C w=
hich
> already depends on the I2C subsystem, remove the unneeded dependency =
from
> BATTERY_BQ27XXX.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index eeb5776..34aa017 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -159,7 +159,6 @@ config BATTERY_SBS
> =20
>  config BATTERY_BQ27XXX
>  	tristate "BQ27xxx battery driver"
> -	depends on I2C || I2C=3Dn
>  	help
>  	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ)=
 chips.
> =20

Sounds good, so Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

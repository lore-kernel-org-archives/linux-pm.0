From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] rx51-battery: Set name to rx51-battery
Date: Sun, 2 Aug 2015 09:24:52 +0200
Message-ID: <20150802072452.GG32270@amd>
References: <1438109081-8204-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47004 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbbHBHYz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 03:24:55 -0400
Content-Disposition: inline
In-Reply-To: <1438109081-8204-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue 2015-07-28 20:44:41, Pali Roh=E1r wrote:
> For compatibility between board code and DT, set battery name to same=
 value.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/power/rx51_battery.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/rx51_battery.c b/drivers/power/rx51_batter=
y.c
> index ac62069..af9383d 100644
> --- a/drivers/power/rx51_battery.c
> +++ b/drivers/power/rx51_battery.c
> @@ -215,7 +215,7 @@ static int rx51_battery_probe(struct platform_dev=
ice *pdev)
>  	platform_set_drvdata(pdev, di);
> =20
>  	di->dev =3D &pdev->dev;
> -	di->bat_desc.name =3D dev_name(&pdev->dev);
> +	di->bat_desc.name =3D "rx51-battery";
>  	di->bat_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
>  	di->bat_desc.properties =3D rx51_battery_props;
>  	di->bat_desc.num_properties =3D ARRAY_SIZE(rx51_battery_props);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html

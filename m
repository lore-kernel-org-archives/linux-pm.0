From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] mfd: axp20x: Extend axp22x_volatile_ranges
Date: Fri, 10 Jun 2016 15:57:45 +0100
Message-ID: <20160610145745.GC7351@dell>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <1464887936-17020-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36587 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbcFJO5L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 10:57:11 -0400
Received: by mail-wm0-f44.google.com with SMTP id n184so270349424wmn.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 07:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464887936-17020-2-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

On Thu, 02 Jun 2016, Hans de Goede wrote:

> The axp22x pmic has a bunch of volatile registers besides the interru=
pt
> ones, extend axp22x_volatile_ranges with these.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v2:
> -Added Chen-Yu's Acked-by
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index e4e3297..ca04361 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -93,7 +93,10 @@ static const struct regmap_range axp22x_writeable_=
ranges[] =3D {
>  };
> =20
>  static const struct regmap_range axp22x_volatile_ranges[] =3D {
> +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
> +	regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
>  };
> =20
>  static const struct regmap_access_table axp22x_writeable_table =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

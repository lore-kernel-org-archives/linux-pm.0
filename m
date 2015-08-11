From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] mfd: axp20x: Add missing registers,
 and mark more registers volatile
Date: Tue, 11 Aug 2015 15:17:55 +0100
Message-ID: <20150811141754.GL18282@x1>
References: <1439049521-30766-1-git-send-email-hdegoede@redhat.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBLEIVCXAKGQES3WSHQQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439049521-30766-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sat, 08 Aug 2015, Hans de Goede wrote:

> From: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
>=20
> Add an extra set of registers which is necessary tu support the PMICs
> battery charger function, and mark registers which contain status bits,
> gpio status, and adc readings as volatile.
>=20
> Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
> Changes in v2:
> -Add a AXP20X_OCV_MAX define
> Changes in v3:
> -Add Bruno's S-o-b
> Changes in v4:
> -Consistently use AXP20X_OCV_MAX everywhere
> ---
>  drivers/mfd/axp20x.c       | 8 +++++++-
>  include/linux/mfd/axp20x.h | 6 ++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index b369cfc..d9f2f96 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -61,10 +61,16 @@ static const struct regmap_access_table axp152_volati=
le_table =3D {
>  static const struct regmap_range axp20x_writeable_ranges[] =3D {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
> +	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>  };
> =20
>  static const struct regmap_range axp20x_volatile_ranges[] =3D {
> +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
> +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> +	regmap_reg_range(AXP20X_GPIO20_SS, AXP20X_GPIO3_CTRL),
> +	regmap_reg_range(AXP20X_FG_RES, AXP20X_RDC_L),
>  };
> =20
>  static const struct regmap_access_table axp20x_writeable_table =3D {
> @@ -195,7 +201,7 @@ static const struct regmap_config axp20x_regmap_confi=
g =3D {
>  	.val_bits	=3D 8,
>  	.wr_table	=3D &axp20x_writeable_table,
>  	.volatile_table	=3D &axp20x_volatile_table,
> -	.max_register	=3D AXP20X_FG_RES,
> +	.max_register	=3D AXP20X_OCV(AXP20X_OCV_MAX),
>  	.cache_type	=3D REGCACHE_RBTREE,
>  };
> =20
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 52203d5..cc8ad1e 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -190,6 +190,12 @@ enum {
>  #define AXP20X_CC_CTRL			0xb8
>  #define AXP20X_FG_RES			0xb9
> =20
> +/* OCV */
> +#define AXP20X_RDC_H			0xba
> +#define AXP20X_RDC_L			0xbb
> +#define AXP20X_OCV(m)			(0xc0 + (m))
> +#define AXP20X_OCV_MAX			0xf
> +
>  /* AXP22X specific registers */
>  #define AXP22X_BATLOW_THRES1		0xe6
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

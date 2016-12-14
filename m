From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 02/11] mfd: axp20x: add volatile and writeable reg
 ranges for VBUS power supply driver
Date: Wed, 14 Dec 2016 23:43:01 +0800
Message-ID: <CAGb2v66jDsU2rt4d-0ydWR926y-hHTfOBJQmyYVdKd7rcm1WWQ@mail.gmail.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com> <20161209110419.28981-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209110419.28981-3-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
<quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> The X-Powers AXP20X and AXP22X PMICs allow to choose the maximum voltage
> and minimum current delivered by the VBUS power supply.
>
> This adds the register used by the VBUS power supply driver to the range
> of volatile and writeable regs ranges.
>
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>
> added in v2
>
>  drivers/mfd/axp20x.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ba130be..6ee2cc6 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -65,12 +65,14 @@ static const struct regmap_access_table axp152_volatile_table = {
>
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),

This is already covered by the previous entry.

>         regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
>         regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(AXP20X_OCV_MAX)),
>  };
>
>  static const struct regmap_range axp20x_volatile_ranges[] = {
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),

And I'm not sure why you specify it as volatile? The PMIC doesn't change any
of the bits in this register on its own.

Same for the AXP22x bits. So basically I think you don't need this patch.

ChenYu

>         regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> @@ -91,11 +93,13 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  /* AXP22x ranges are shared with the AXP809, as they cover the same range */
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>         regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>         regmap_reg_range(AXP20X_DCDC_MODE, AXP22X_BATLOW_THRES1),
>  };
>
>  static const struct regmap_range axp22x_volatile_ranges[] = {
>         regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),
> +       regmap_reg_range(AXP20X_VBUS_IPSOUT_MGMT, AXP20X_VBUS_IPSOUT_MGMT),
>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
>         regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
>         regmap_reg_range(AXP20X_FG_RES, AXP20X_FG_RES),
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

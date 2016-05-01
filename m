From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 3/6] mfd: axp20x: Add a cell for the ac power_supply
 part of the axp20x PMICs
Date: Sun, 1 May 2016 17:58:12 +0800
Message-ID: <CAGb2v67dANYj8-t8C=2_JeFz_WxvgAUhmXcrToK9d7Q-ryeBXg@mail.gmail.com>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org> <1462093047-7885-4-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:52160 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbcEAJ6g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2016 05:58:36 -0400
In-Reply-To: <1462093047-7885-4-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Haas <haas@computerlinguist.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sunxi <linux-sunxi@googlegroups.com>

Hi,

On Sun, May 1, 2016 at 4:57 PM, Michael Haas <haas@computerlinguist.org> wrote:
> As a counterpart to the usb power_supply cell, this commit adds an AC
> power_supply cell to the axp20x driver.
>
> Still missing are the RTC backup battery and the main battery charger
> cells.
>
> Signed-off-by: Michael Haas <haas@computerlinguist.org>
> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index a57d6e9..9351c0e 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -178,6 +178,12 @@ static struct resource axp288_power_button_resources[] = {
>         },
>  };
>
> +static struct resource axp20x_ac_power_supply_resources[] = {
> +       DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
> +       DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> +       DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
> +};
> +

Please group the resources by family, i.e. put this one above
axp20x_pek_resources.

>  static struct resource axp288_fuel_gauge_resources[] = {
>         {
>                 .start = AXP288_IRQ_QWBTU,
> @@ -440,6 +446,11 @@ static struct mfd_cell axp20x_cells[] = {
>                 .of_compatible  = "x-powers,axp202-usb-power-supply",
>                 .num_resources  = ARRAY_SIZE(axp20x_usb_power_supply_resources),
>                 .resources      = axp20x_usb_power_supply_resources,
> +       }, {
> +               .name           = "axp20x-ac-power-supply",
> +               .of_compatible  = "x-powers,axp202-ac-power-supply",
> +               .num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +               .resources      = axp20x_ac_power_supply_resources,

I would put this before "x-powers,axp202-usb-power-supply", as it's the primary
power supply, but keeping the power supplies grouped. The list is already out of
alphabetic order anyway.

ChenYu

>         },
>  };
>
> --
> 2.8.0
>

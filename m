From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 2/5] mfd: axp20x: Add a cell for the ac power_supply
 part of the axp20x PMICs
Date: Fri, 6 May 2016 10:48:06 +0800
Message-ID: <CAGb2v67R6SX=_WDeE9cBvaiA=tTW9=tuhSC3rjOgs44hHAcTdg@mail.gmail.com>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org> <1462444508-9363-3-git-send-email-haas@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:58296 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbcEFCsb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 22:48:31 -0400
In-Reply-To: <1462444508-9363-3-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Haas <haas@computerlinguist.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sunxi <linux-sunxi@googlegroups.com>

On Thu, May 5, 2016 at 6:35 PM, Michael Haas <haas@computerlinguist.org> wrote:
> As a counterpart to the usb power_supply cell, this commit adds an AC
> power_supply cell to the axp20x driver.
>
> Still missing are the RTC backup battery and the main battery charger
> cells.
>
> Signed-off-by: Michael Haas <haas@computerlinguist.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index a57d6e9..aa6ef08 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -128,6 +128,12 @@ static struct resource axp152_pek_resources[] = {
>         DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
>  };
>
> +static struct resource axp20x_ac_power_supply_resources[] = {
> +       DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
> +       DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> +       DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
> +};
> +
>  static struct resource axp20x_pek_resources[] = {
>         {
>                 .name   = "PEK_DBR",
> @@ -436,6 +442,11 @@ static struct mfd_cell axp20x_cells[] = {
>         }, {
>                 .name           = "axp20x-regulator",
>         }, {
> +               .name           = "axp20x-ac-power-supply",
> +               .of_compatible  = "x-powers,axp202-ac-power-supply",
> +               .num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +               .resources      = axp20x_ac_power_supply_resources,
> +       }, {
>                 .name           = "axp20x-usb-power-supply",
>                 .of_compatible  = "x-powers,axp202-usb-power-supply",
>                 .num_resources  = ARRAY_SIZE(axp20x_usb_power_supply_resources),
> --
> 2.8.2
>

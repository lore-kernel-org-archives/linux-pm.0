From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 7/7] mfd: axp20x: Add supported cells for AXP803
Date: Thu, 11 Oct 2018 16:10:12 +0800
Message-ID: <CAGb2v64i4a_yBkJE5pTmx_tKOVGKJNGvqAY0Hnw=Wr17VDSTfQ@mail.gmail.com>
References: <20181008181908.9456-1-oskari@lemmela.net> <20181008181908.9456-8-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008181908.9456-8-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 9, 2018 at 2:20 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813.
> Adding cells for GPIO, ADC, AC and battery power supplies.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/mfd/axp20x.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 1508d9113126..4befe474b165 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] = {
>                 .name                   = "axp221-pek",
>                 .num_resources          = ARRAY_SIZE(axp803_pek_resources),
>                 .resources              = axp803_pek_resources,
> +       }, {
> +               .name                   = "axp20x-regulator",

Please keep this as one line as before. This was requested by the MFD
maintainer.

> +       }, {
> +               .name                   = "axp20x-gpio",
> +               .of_compatible          = "x-powers,axp813-gpio",

You might want to put the GPIO cell near the top of the list, so any other
users, such as the ADC and regulator cells, will probe after it.

> +       }, {
> +               .name                   = "axp813-adc",
> +               .of_compatible          = "x-powers,axp813-adc",
> +       }, {
> +               .name           = "axp20x-battery-power-supply",
> +               .of_compatible  = "x-powers,axp813-battery-power-supply",
> +       }, {
> +               .name           = "axp20x-ac-power-supply",
> +               .of_compatible  = "x-powers,axp813-ac-power-supply",
> +               .num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +               .resources      = axp20x_ac_power_supply_resources,

Please use the same indentation.

Regards
ChenYu

>         },
> -       {       .name                   = "axp20x-regulator" },
>  };
>
>  static const struct mfd_cell axp806_self_working_cells[] = {
> --
> 2.17.1
>

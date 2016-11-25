From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 05/10] mfd: axp20x: add separate MFD cell for AXP223
Date: Fri, 25 Nov 2016 18:03:09 +0800
Message-ID: <CAGb2v65G5rXgwh23OKHr0dk5BfMgGvOr3q0XVP4GGxzh4d_L6w@mail.gmail.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-6-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161125090921.23138-6-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The AXP223 shares most of its logic with the AXP221 but has some
> differences for the VBUS power supply driver. Thus, to probe the driver
> with the correct compatible, the AXP221 and the AXP223 now have separate
> MFD cells.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ba130be..989d568 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -602,6 +602,21 @@ static struct mfd_cell axp22x_cells[] = {
>         },
>  };
>
> +static struct mfd_cell axp223_cells[] = {
> +       {
> +               .name                   = "axp20x-pek",
> +               .num_resources          = ARRAY_SIZE(axp22x_pek_resources),
> +               .resources              = axp22x_pek_resources,
> +       }, {
> +               .name                   = "axp20x-regulator",
> +       }, {
> +               .name           = "axp20x-usb-power-supply",
> +               .of_compatible  = "x-powers,axp223-usb-power-supply",
> +               .num_resources  = ARRAY_SIZE(axp22x_usb_power_supply_resources),
> +               .resources      = axp22x_usb_power_supply_resources,

Nit: Please align the statements. And you might want to rename the original
axp22x_cells to axp221_cells to avoid confusion. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +       },
> +};
> +
>  static struct mfd_cell axp152_cells[] = {
>         {
>                 .name                   = "axp20x-pek",
> @@ -789,12 +804,17 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>                 axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
>                 break;
>         case AXP221_ID:
> -       case AXP223_ID:
>                 axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
>                 axp20x->cells = axp22x_cells;
>                 axp20x->regmap_cfg = &axp22x_regmap_config;
>                 axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
>                 break;
> +       case AXP223_ID:
> +               axp20x->nr_cells = ARRAY_SIZE(axp223_cells);
> +               axp20x->cells = axp223_cells;
> +               axp20x->regmap_cfg = &axp22x_regmap_config;
> +               axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
> +               break;
>         case AXP288_ID:
>                 axp20x->cells = axp288_cells;
>                 axp20x->nr_cells = ARRAY_SIZE(axp288_cells);
> --
> 2.9.3
>

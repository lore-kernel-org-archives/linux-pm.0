From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803
 power bindings
Date: Wed, 31 Oct 2018 10:38:34 +0800
Message-ID: <CAGb2v67WiDke1nrD_6b9DwG1O_AD=GSLV2kiVNrfH8MHHfdmDQ@mail.gmail.com>
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-3-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023185330.10472-3-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> The AXP803 power supplies are compatible with AXP813, but
> add specific compatibles for them.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
>  .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> index 7a1fb532abe5..acdeb4b8f4cc 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible: One of:
>                         "x-powers,axp202-ac-power-supply"
>                         "x-powers,axp221-ac-power-supply"
> +                       "x-powers,axp803-ac-power-supply"
>                         "x-powers,axp813-ac-power-supply"
>
>  This node is a subnode of the axp20x PMIC.
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> index 41916f69902c..780ebd7e3b84 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible, one of:
>                         "x-powers,axp209-battery-power-supply"
>                         "x-powers,axp221-battery-power-supply"
> +                       "x-powers,axp803-battery-power-supply"
>                         "x-powers,axp813-battery-power-supply"
>
>  This node is a subnode of its respective PMIC DT node.

As mentioned in my reply to the cover letter, this patch isn't needed.

We ask people to add model-specific compatibles in the device tree
in case the hardware turns out not to be so compatible with the old
hardware we thought it was compatible with. With the model-specific
compatible in place, we have a way out. Without it, we'd have to ask
everyone to update their device trees, which annoys some people who'd
like to have some sort of backward compatibility.

If the model-specific + fallback compatibles combination was to be
listed, the line would include both compatibles. But we're not doing
that for Allwinner stuff. As mentioned it is there just in case. The
best outcome is we don't care and don't need to use them.

ChenYu

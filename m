From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
Date: Wed, 31 Oct 2018 11:00:51 +0800
Message-ID: <CAGb2v666Vn_GdFwT4MXfbD7Gb1UC+gwGdVhquKH09Ld_Q3QmtA@mail.gmail.com>
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-4-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023185330.10472-4-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> The AXP803 GPIO is compatible with AXP813 GPIO, but add
> specific compatible for it.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> index fc42b2caa06d..5337a21d7bcf 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> @@ -11,6 +11,7 @@ This driver employs the per-pin muxing pattern.
>  Required properties:
>  - compatible: Should be one of:
>         - "x-powers,axp209-gpio"
> +       - "x-powers,axp803-gpio"
>         - "x-powers,axp813-gpio"
>  - #gpio-cells: Should be two. The first cell is the pin number and the
>    second is the GPIO flags.
> @@ -67,6 +68,7 @@ GPIO0 |       gpio_in, gpio_out, ldo, adc
>  GPIO1  |       gpio_in, gpio_out, ldo, adc
>  GPIO2  |       gpio_in, gpio_out
>
> +axp803
>  axp813
>  ------
>  GPIO   |       Functions
> --

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

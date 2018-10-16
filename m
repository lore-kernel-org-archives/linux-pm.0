From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 4/7] arm64: dts: allwinner: a64: sopine: enable power supplies
Date: Tue, 16 Oct 2018 12:14:53 +0800
Message-ID: <CAGb2v64HnH4UEUi2xRsAJS=EX0gTjikS+ai3M3WrG+6+A7P4JQ@mail.gmail.com>
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-5-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013080848.29894-5-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> Sopine baseboard have ACIN and battery connectors.

The commit message should be more specific, like how the two connections
from the PMIC are routed. In this case ACIN is routed from the SOM to
the DC jack on the baseboard, while the battery pins are routed to a 3-pin
connector next to the USB connectors.

ChenYu

>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index c21f2331add6..335cf2263d19 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -69,6 +69,14 @@
>         };
>  };
>
> +&ac_power_supply {
> +       status = "okay";
> +};
> +
> +&battery_power_supply {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> --
> 2.17.1
>

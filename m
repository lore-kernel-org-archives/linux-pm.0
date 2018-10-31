From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v5 07/11] arm64: dts: allwinner: a64: sopine-baseboard:
 enable power supplies
Date: Wed, 31 Oct 2018 11:05:11 +0800
Message-ID: <CAGb2v66dY87HN6HQz3=ER=yr6arV3LcxCxpVVwojKpqwj7m7dQ@mail.gmail.com>
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-8-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023185330.10472-8-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: oskari@lemmela.net
Cc: Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
> AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
> and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
> AXP803 TS pins are routed to the baseboard 3-pin battery connector.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

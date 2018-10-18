From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v4 0/7] AXP8x3 AC and battery power supply support
Date: Wed, 17 Oct 2018 23:04:21 -0700
Message-ID: <7922695.scgUESgI9A@anarsoul-thinkpad>
References: <20181013080848.29894-1-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Oskari Lemmela <oskari@lemmela.net>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, October 13, 2018 1:08:41 AM PDT Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
> 
> AXP803 AC and battery power supply support.
> 
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
> 
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit
> 
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c

Patches 1-3, 5-7:

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

> Oskari Lemmela (7):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
> 
>  .../bindings/power/supply/axp20x_ac_power.txt |  3 +
>  arch/arm/boot/dts/axp81x.dtsi                 |  5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
>  drivers/mfd/axp20x.c                          | 20 ++++
>  drivers/power/supply/axp20x_ac_power.c        | 92 +++++++++++++++++++
>  include/linux/mfd/axp20x.h                    |  1 +
>  7 files changed, 160 insertions(+)

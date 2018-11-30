From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Date: Fri, 30 Nov 2018 16:31:28 +0800
Message-ID: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
References: <20181120175211.3913-1-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, oskari@lemmela.net
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Quentin Schulz <quentin.schulz@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP813 AC power supply support with input current and
> voltage limiting support.
>
> AXP803 AC and battery power supply support.
>
> Changes in v6:
> * Collected tags
> * Rebase to master
> * Dropped AXP803 compatible patches
>
> Changes in v5:
> * Return correct input current limit for values 0x6 and 0x7
> * Add specific compatibles for AXP803
> * Change commit messages
> * Add Vasily Khoruzhick Pinebook DTS patch
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
>
>
> Oskari Lemmela (7):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
>
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: pinebook: enable power supplies

Since this series has been fully reviewed, and the devices it
adds/enables aren't critical, i.e. won't cause the system to fail
if the drivers are missing, I've merged the dts patches for 4.21.

Hopefully Sebastian and Lee will get around to merging the driver
patches.

Thanks.
ChenYu

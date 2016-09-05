From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/5 v2] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal support
Date: Mon, 5 Sep 2016 11:56:05 +0200
Message-ID: <CAMuHMdUDqh7hzm3bjhf-6mXnBRNEHe2htT+ubL5sJM0-Dp+-DQ@mail.gmail.com>
References: <SIXPR06MB0906A90665B5DA288D6E63ECA8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33778 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbcIEKId (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 06:08:33 -0400
In-Reply-To: <SIXPR06MB0906A90665B5DA288D6E63ECA8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Toru Oishi <toru.oishi.zj@renesas.com>, Simon Horman <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Khiem

On Sat, Sep 3, 2016 at 7:22 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> This patchset adds new thermal sensor driver to support 3 sensors found in R-Car Gen3 series.
>
> It has been decided to create new driver, instead of using the existing thermal driver
> due to many differences in HW setting flows, the method to calculate temperatures value
> and some newly supported features.
>
> The new driver can support both polling mode and interrupt mode.
> It has been tested with R-Car H3. I expect same result on R-Car M3.
>
> This driver is developed based on early work of Hien Dang and Thao Nguyen.
> All comments are welcome.

You forgot to CC Simon Horman and the linux-renesas-soc mailing list.

> Khiem Nguyen (5):
>   thermal: rcar_gen3_thermal: Document the R-Car Gen3 thermal bindings
>   thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver support
>   arm64: dts: r8a7795: Add R-Car Gen3 thermal support
>   arm64: dts: r8a7796: Add R-Car Gen3 thermal support
>   arm64: defconfig: Enable R-Car Gen3 thermal support
>
>  .../bindings/thermal/rcar-gen3-thermal.txt         |  79 +++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  83 ++++
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  83 ++++
>  arch/arm64/configs/defconfig                       |   2 +
>  drivers/thermal/Kconfig                            |   9 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/rcar_gen3_thermal.c                | 539 +++++++++++++++++++++
>  7 files changed, 796 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
>  create mode 100644 drivers/thermal/rcar_gen3_thermal.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/4] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal support
Date: Mon, 20 Jun 2016 09:40:26 +0200
Message-ID: <CAMuHMdU3_O9YA6cjR=-ub6drKu8g-s4hmem4uggZeNBMJrC8qQ@mail.gmail.com>
References: <57661211.7010900@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36806 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbcFTHwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 03:52:51 -0400
In-Reply-To: <57661211.7010900@rvc.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, "Hien Duy. Dang" <hien.dang.eb@rvc.renesas.com>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, Simon Horman <horms@verge.net.au>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>

Hi Khiem,

On Sun, Jun 19, 2016 at 5:31 AM, Khiem Nguyen
<khiem.nguyen.xt@rvc.renesas.com> wrote:
> This patchset adds new thermal sensor driver to support 3 sensors
> found in R-Car Gen3 series.
>
> It has been decided to create new driver, instead of using the existing
> thermal driver due to many differences in HW setting flows, the method
> to calculate temperatures value and some newly supported features.
>
> The new driver can support both polling mode and interrupt mode.
> It has been tested with R-Car H3.
>
> This driver is developed based on early work of Hien Dang and Thao Nguyen.
> All comments are welcome.

Thanks for your series!

Please CC linux-renesas-soc for drivers related to Renesas SoCs.
Please CC Simon for dts and defconfig updates that should go through his tree.

> Khiem Nguyen (4):
>   thermal: rcar_gen3_thermal: Document the R-Car Gen3 thermal bindings
>   thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver support
>   arm64: dts: r8a7795: Add R-Car Gen3 thermal support
>   arm64: defconfig: Enable R-Car Gen3 thermal support
>
>  .../bindings/thermal/rcar-gen3-thermal.txt         |  79 ++++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  86 ++++
>  arch/arm64/configs/defconfig                       |   2 +
>  drivers/thermal/Kconfig                            |   9 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/rcar_gen3_thermal.c                | 524 +++++++++++++++++++++
>  6 files changed, 701 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
>  create mode 100644 drivers/thermal/rcar_gen3_thermal.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

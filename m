From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 6/8] DT: arm: Add Renesas RZ/N1 SoC base device tree file
Date: Fri, 30 Mar 2018 10:10:57 +0200
Message-ID: <CAMuHMdX5cSB5wDJWq4aWuihN5+z_4T+ZUN4AR-Sm0Q+N4RZE0A@mail.gmail.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com> <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522309629-10152-7-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Michel Pollet <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Michel,

On Thu, Mar 29, 2018 at 9:47 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas RZ/N1 Family (Part #R9A06G0xx) SoC
> bare bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> For simplicity sake, this also relies on the bootloader to set the
> pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g0xx.dtsi

As I said on IRC, I'm not so happy with this r9a06g0xx.dtsi file without
SoC-specific compatible values, as you have to override all of them in
r9a06g032.dtsi and r9a06g033.dtsi

Moreover, in this series you dropped r9a06g032.dtsi, so the devices no longer
have SoC-specific compatible values?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

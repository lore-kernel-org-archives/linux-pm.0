From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/8] DT: mfd: renesas,rzn1-sysctrl: document RZ/N1
 sysctrl node
Date: Fri, 30 Mar 2018 09:58:31 +0200
Message-ID: <CAMuHMdXeLNBfBaW32-UK9gx_HFrqEA7ChDPp8mtQCHD0PiJ8Ag@mail.gmail.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com> <1522309629-10152-2-git-send-email-michel.pollet@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522309629-10152-2-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Michel Pollet <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Michel,

On Thu, Mar 29, 2018 at 9:46 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function
> system controller. This documents the node used to encapsulate
> it's sub drivers.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
> @@ -0,0 +1,19 @@
> +DT bindings for the Renesas RZ/N1 System Controller
> +
> +== System Controller Node ==
> +
> +The system controller node currently only hosts a single sub-node to handle
> +the rebooting of the CPU. Eventually it will host the clock driver, SMP
> +start handler, watchdog etc.
> +
> +See renesas,rzn1-reboot.txt for further details.
> +
> +Bindings:
> ++ Required:
> +       compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";

You should list the supported SoC-specific compatible values here.

> +
> +Example:
> +       sysctrl: sysctrl@4000c000 {
> +               compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";

Missing SoC-specific compatible value.

> +               reg = <0x4000c000 0x1000>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

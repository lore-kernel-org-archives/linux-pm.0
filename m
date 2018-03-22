From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1
 reboot driver
Date: Thu, 22 Mar 2018 13:30:37 +0100
Message-ID: <CAMuHMdUzW221ppgR=BW0iiLNRr8KQbgTPoRbTKRKU8wnXavVtA@mail.gmail.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-3-git-send-email-michel.pollet@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521719091-25157-3-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Michel,

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> as part of the sysctrl MFD to handle rebooting the CA7 cores.
> This documents the driver bindings.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
> @@ -0,0 +1,22 @@
> +DT bindings for the Renesas RZ-N1 Reboot Driver
> +
> +== Reboot Driver Node ==
> +
> +The reboot driver is always a subnode of the system controller node, see
> +renesas,rzn1-sysctrl.txt for details.
> +
> +Bindings:
> ++ Optional:
> +       compatible = "renesas,r9a06g032-reboot";
> ++ Required:
> +       compatible = "renesas,rzn1-reboot";

Please mark both the SoC-specific and the family-specific values required.

> +
> +Example:
> +       sysctrl: sysctrl@4000c000 {
> +               compatible = "renesas,r9a06g032-sysctrl", "syscon", "simple-mfd";
> +               reg = <0x4000c000 0x1000>;
> +
> +               reboot {
> +                       compatible = "renesas,r9a06g032-reboot";

"renesas,r9a06g032-reboot", "renesas,rzn1-reboot".

> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

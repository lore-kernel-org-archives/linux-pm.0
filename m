From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 3/8] DT: arm: renesas,rzn1: add the RZ/N1 SoC and
 RZN1D-DB board
Date: Fri, 30 Mar 2018 10:06:59 +0200
Message-ID: <CAMuHMdV=1DTbzc-qeKzFoZLAuPbqyXPhoD3ofjJ0d6QRD4eztA@mail.gmail.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com> <1522309629-10152-4-git-send-email-michel.pollet@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522309629-10152-4-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>, Michel Pollet <buserror+upstream@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Michel,

On Thu, Mar 29, 2018 at 9:46 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This documents the RZ/N1 bindings for both the RZ/N1 and the RZN1D-DB
> board.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -47,7 +47,10 @@ SoCs:
>      compatible = "renesas,r8a77980"
>    - R-Car D3 (R8A77995)
>      compatible = "renesas,r8a77995"
> -
> +  - RZ/N1 Family (R9A06G032 & R9A06G033)
> +    compatible = "renesas,rzn1"
> +  - RZ/N1D (R9A06G032)
> +    compatible = "renesas,r9a06g032", "renesas,rzn1"

Is there any value in the family-specific "renesas,rzn1" compatible
value at the SoC
level? We don't have them for other Renesas SoC families.

We've been bitten before by values like "renesas,rspi-rz", not knowing
at that time
that Renesas was going to have multiple different RZ subfamilies.
Compare also e.g. R-Car W2H with other R-Car Gen2 SoCs...

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

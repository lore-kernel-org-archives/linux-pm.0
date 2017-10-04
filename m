From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/14] pinctrl: sh-pfc: Add suspend/resume support
Date: Wed, 4 Oct 2017 21:19:21 +0200
Message-ID: <CAMuHMdVx7w7NvY2U66ODx=_GkouPrAaqFSHD_C3xyyYjhm+qVQ@mail.gmail.com>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 4, 2017 at 11:06 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
> pinctrl register state is lost.  Note that as the boot loader skips most
> initialization after system resume, pinctrl register state differs from
> the state encountered during normal system boot, too.
>
> To fix this, save all GPIO and peripheral function select, module
> select, drive strength control, bias, and other I/O control registers
> during system suspend, and restore them during resume.
>
> This series consists of 4 parts:
>   - Patches 1-2 are cleanups,
>   - Patches 3-9 introduce a generic way to describe bias (pull-up/down)
>     registers, and converts the R-Car Gen3 and R-Car M1A bias support
>     over,
>   - Patches 10-13 introduce a generic way to describe various IOCTRL
>     registers, and converts the R-Car Gen3 I/O voltage support over,
>   - Patch 14 implements the actual suspend/resume code, using the
>     generic bias and IOCTRL support introduced earlier.
>
> To avoid overhead on platforms not needing it, the suspend/resume code
> has a build time dependency on sleep and PSCI support, and a runtime
> dependency on PSCI.
>
> Due to the more compact description of bias registers, this series
> actually decreases kernel size (by ca. 112 bytes for renesas_defconfig,
> and ca. 60 bytes for shmobile_defconfig).
>
> Thanks for your comments!
>
> Geert Uytterhoeven (14):
>   pinctrl: sh-pfc: Remove matching on plain sh-pfc platform device
>   pinctrl: sh-pfc: Drop width parameter of sh_pfc_{read,write}_reg()
>   pinctrl: sh-pfc: Add generic bias register description
>   pinctrl: sh-pfc: Add sh_pfc_pin_to_bias_reg() helper
>   pinctrl: sh-pfc: r8a7795-es1: Use generic bias register description
>   pinctrl: sh-pfc: r8a7795: Use generic bias register description
>   pinctrl: sh-pfc: r8a7796: Use generic bias register description
>   pinctrl: sh-pfc: r8a7778: Use generic bias register description
>   pinctrl: sh-pfc: Remove obsolete sh_pfc_pin_to_bias_info()
>   pinctrl: sh-pfc: Add generic IOCTRL register description
>   pinctrl: sh-pfc: r8a7795-es1: Use generic IOCTRL register description
>   pinctrl: sh-pfc: r8a7795: Use generic IOCTRL register description
>   pinctrl: sh-pfc: r8a7796: Use generic IOCTRL register description
>   pinctrl: sh-pfc: Save/restore registers for PSCI system suspend
>
>  drivers/pinctrl/sh-pfc/core.c            | 129 +++++++-
>  drivers/pinctrl/sh-pfc/core.h            |  11 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c     | 403 +++++++++++++-----------
>  drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 511 ++++++++++++++++---------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 511 ++++++++++++++++---------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 511 ++++++++++++++++---------------
>  drivers/pinctrl/sh-pfc/pinctrl.c         |  12 +-
>  drivers/pinctrl/sh-pfc/sh_pfc.h          |  24 +-
>  8 files changed, 1170 insertions(+), 942 deletions(-)

For testers: please check the topic/sh-pfc-suspend-resume-v1 branch of
my renesas-drivers git repository at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

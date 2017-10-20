From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 00/14] pinctrl: sh-pfc: Add suspend/resume support
Date: Fri, 20 Oct 2017 11:56:50 +0200
Message-ID: <CAMuHMdU3FjCv6va8yeNVOhnOD00FDo618JDtyu6gZFO=rd=bUQ@mail.gmail.com>
References: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508167679-21155-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 16, 2017 at 5:27 PM, Geert Uytterhoeven
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
> Changes compared to v1:
>   - Add Reviewed-by,
>   - Shorten sh_pfc_{read,write}_reg() function names to
>     sh_pfc_{read,write}(),
>   - Use ARRAY_SIZE() instead of hardcoded constant 32,
>   - Add curly braces to nested for statements,
>   - Add a sentinel comment, to make it more explicit that a last zero
>     entry is required in sh_pfc_soc_info.bias_regs[] arrays,
>
> I plan to queue this in sh-pfc-for-v4.15.

Done.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

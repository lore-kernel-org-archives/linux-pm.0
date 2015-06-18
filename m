From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/7] staging: board: armadillo800eva: Board staging
 for sh_mobile_lcdc_fb
Date: Thu, 18 Jun 2015 13:08:34 +0900
Message-ID: <20150618040834.GB23629@verge.net.au>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 17, 2015 at 10:38:49AM +0200, Geert Uytterhoeven wrote:
> 	Hi Greg, Simon, Magnus,
> 
> This patch series adds board staging support for the Renesas R-Mobile A1
> (r8a7740) based Armadillo-800 EVA board. It allows to support the frame
> buffer device for the on-board LCD (which isn't supported by a DT-aware
> driver yet) in modern DT-based multi-platform kernels.
> 
> The board staging area was introduced last year to allow continuous
> upstream in-tree development and integration of platform devices. It
> helps developers integrate devices as platform devices for device
> drivers that only provide platform device bindings.  This in turn allows
> for incremental development of both hardware feature support and DT
> binding work in parallel.
> 
> The goal is to complete the move to ARM multi-platform kernels for all
> shmobile platforms, and drop the existing board files
> (arch/arm/mach-shmobile/board-*). Once this series is accepted, more
> than 3000 lines of legacy armadillo board code and r8a7740 SoC code can
> be removed.
> 
> This series consists of 5 parts:
>   - Patch 1 re-enables compilation of the board staging area, which was
>     disabled after a compile breakage, but has been fixed in the mean
>     time,
>   - Path 2 moves initialization of staging board code to an earlier
>     moment, as currently it happens after unused PM domains are powered
>     down,
>   - Patches 3 and 4 (hopefully) fix the existing kzm9d board staging
>     code, which was presumably "broken" by commit 9a1091ef0017c40a
>     ("irqchip: gic: Support hierarchy irq domain."),
>   - Patches 5 and 6 add support for registering platform devices with
>     complex dependencies (clocks and PM domains), and add armadillo
>     board staging code for enabling a frame buffer on the on-board LCD,
>   - Patch 7 (new) adds pinctrl and gpio-hog configuration to enable the
>     LCD.
> 
> The first 6 patches should go in through the staging tree, the last one
> through the shmobile tree.
> 
> Major changes since v1 (more detailed changelogs in the individual
> patches):
>   - Add support for low/high edge/level interrupts in hwirq translation,
>   - Move pinctrl and GPIO configuration from board staging code to DT,
>   - Use clk_add_alias() instead of open coding.
> 
> Dependencies:
>   - This is against next-20150617,
>   - The gpio-hog in patch 7 depends on a bug fix like "[PATCH] [RFC]
>     gpio: Retry deferred GPIO hogging on pin range change"
>     (https://lkml.org/lkml/2015/6/16/455). It can be applied as-is
>     though.
> 
> This was tested on r8a7740/armadillo.
> This was not tested on emev2/kzm9d, due to lack of hardware.

I have verified that kzm9d still boots with your patches applied on top
of renesas-devel-20150617-v4.1-rc8. I used shmobile_defconfig and
then enabled CONFIG_STAGING and in turn CONFIG_STAGING_BOARD.

Let me know if you think further testing is appropriate.

> Thanks for applying!
> 
> Geert Uytterhoeven (7):
>   Revert "staging: board: disable as it breaks the build"
>   staging: board: Initialize staging board code earlier
>   staging: board: Add support for translating hwirq to virq numbers
>   staging: board: kzm9d: Translate hwirq numbers to virq numbers
>   staging: board: Add support for devices with complex dependencies
>   staging: board: armadillo800eva: Board staging for sh_mobile_lcdc_fb

Feel free to add:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

to the above.

>   ARM: shmobile: armadillo800eva dts: Add pinctrl and gpio-hog for lcdc0
> 
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  13 +++
>  drivers/staging/board/Kconfig                 |   1 -
>  drivers/staging/board/Makefile                |   3 +-
>  drivers/staging/board/armadillo800eva.c       | 105 ++++++++++++++++++++
>  drivers/staging/board/board.c                 | 136 ++++++++++++++++++++++++++
>  drivers/staging/board/board.h                 |  27 ++++-
>  drivers/staging/board/kzm9d.c                 |  10 +-
>  7 files changed, 290 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/staging/board/armadillo800eva.c
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 

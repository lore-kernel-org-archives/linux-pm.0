From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC 0/6] staging: board: armadillo800eva: Board staging for sh_mobile_lcdc_fb
Date: Fri, 03 Apr 2015 19:24:45 +0300
Message-ID: <3984477.UtBUTfcozK@avalon>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:35894 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbDCQYZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 12:24:25 -0400
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello Geert,

Thank you for the patches.

On Friday 03 April 2015 14:41:57 Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This RFC patch series adds board staging support for r8a7740/armadillo.
> For now this supports only the frame buffer device for the on-board LCD.

I've started adding DT support to the shmob-lcdc driver, but I have no board 
to test it on. My Armadillo is gone, and KZM9G is unusable with DT + LCDC at 
the moment as the LCDC interrupt is connected to the legacy interrupt 
controller only, not the GIC. Would you be able to test a patch set ? And if 
you want to implement support for the KZM9G legacy interrupt controller in DT, 
please go for it :-)

> The goal is to complete the move to ARM multiplatform kernels for all
> shmobile platforms, and drop the existing board files
> (arch/arm/mach-shmobile/board-*).
> 
> The board staging area was introduced last year to allow continuous
> upstream in-tree development and integration of platform devices. It
> helps developers integrate devices as platform devices for device
> drivers that only provide platform device bindings.  This in turn allows
> for incremental development of both hardware feature support and DT
> binding work in parallel.
> 
> This series consists of 4 parts:
>   - Patch 1 re-enables compilation of the board staging area, which was
>     disabled after a compile breakage, but has been fixed in the mean
>     time,
>   - Path 2 moves initialization of staging board code to an earlier
>     moment, as currently it happens after unused PM domains are powered
>     down,
>   - Patches 3 and 4 (hopefully) fix the existing kzm9d board staging
>     code, which was presumably broken by commit 9a1091ef0017c40a
>     ("irqchip: gic: Support hierarchy irq domain."),
>   - Patches 5 and 6 add support for registering platform devices with
>     complex dependencies (clocks, pinctrl, gpios, PM domains), and add
>     armadillo board staging code for enabling a frame buffer on the
>     on-board LCD.
> 
> Questions:
>   - Are there other devices from board-armadillo.c that work fine in
>     armadillo-legacy, and that we want to add?
>     I think this is the list of devices lacking DT support and/or
>     missing in DTS:
>       - renesas_usbhs (does this work? the platform device is
> 	instantiated conditionally, but the condition (gpio state) is
> 	never true?)
>       - sh-mobile-hdmi/sh_mobile_lcdc_fb.1 (this seems to be broken in
> 	-legacy?)

HDMI is broken in legacy, we can thus drop it.

>       - sdhi1 (we do have sdhi0)
>       - mmcif
>       - soc-camera-pdrv/sh_mobile_ceu
>       - ipmmu
>       - sh-dma-engine (this will probably never get DT support)
> 
>   - What about support for other boards (kzm9g, bockw, marzen)?

At this point it becomes a budget question, we can certainly port them to DT, 
but it might not make sense to spend time on that. I'll let Magnus chime in.

> This was tested on r8a7740/armadillo.
> This was not tested on emev2/kzm9d, due to lack of hardware.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (6):
>   Revert "staging: board: disable as it breaks the build"
>   [RFC] staging: board: Initialize staging board code earlier
>   [RFC] staging: board: Add support for translating hwirq to virq numbers
>   [RFC] staging: board: kzm9d: Translate hwirq numbers to virq numbers
>   [RFC] staging: board: Add support for devices with complex dependencies
>   [RFC] staging: board: armadillo800eva: Board staging for sh_mobile_lcdc_fb
> 
>  drivers/staging/board/Kconfig           |   1 -
>  drivers/staging/board/Makefile          |   3 +-
>  drivers/staging/board/armadillo800eva.c | 124 ++++++++++++++++++++++++++++
>  drivers/staging/board/board.c           | 142 +++++++++++++++++++++++++++++
>  drivers/staging/board/board.h           |  38 ++++++++-
>  drivers/staging/board/kzm9d.c           |  10 ++-
>  6 files changed, 313 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/staging/board/armadillo800eva.c

-- 
Regards,

Laurent Pinchart


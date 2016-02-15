From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/6] ARM/arm64 : shmobile/renesas: Add L2
 cache-controller nodes
Date: Mon, 15 Feb 2016 10:58:49 +0900
Message-ID: <20160215015848.GD14034@verge.net.au>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48467 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcBOB66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 20:58:58 -0500
Content-Disposition: inline
In-Reply-To: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Hi Geert,

On Mon, Dec 07, 2015 at 07:24:13PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the missing L2 cache-controller nodes to the
> DTSes for various Renesas ARM-based SoCs, and links the CPU nodes to
> them.
> 
> For R-Mobile APE6 (r8a73a4), the L2 cache-controllers are also linked to
> the respective (already existing) SYSC Power Domains. Fortunately these
> Power Domains were never powered down, as they are parents of the Power
> Domains containing CPU cores. This may change in the future.
> 
> For R-Car Gen2 and Gen3 (r8a779x), this serves as a preparatory step for
> adding SYSC Power Domain support later.
> 
> Question for the ARM/DT people: What are the DT bindings for
> Cortex-A15/A7/A57/A53 L2 cache controllers?
> Everybody just seems to use "cache" for the compatible values...
> 
> Patches 2-5 were extracted from series "[PATCH/RFC 00/15]
> ARM: shmobile: R-Car: Add SYSC PM Domain DT Support",
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348742.html)
> and received some fixes. You can find more detailed changelogs in the
> individual patches).
> 
> This has been tested on r8a73a4/ape6evm, r8a7791/koelsch, and
> r8a7795/salvator-x.

Sorry for loosing track of this until now.

It seems to me that the Gen-2 changes could be applied, is that correct?
It also seems to me that there was inconclusive discussion regarding
the r8a7795 change, is that also correct.

> 
> Thanks!
> 
> Geert Uytterhoeven (6):
>   ARM: shmobile: r8a73a4 dtsi: Add L2 cache-controller nodes
>   ARM: shmobile: r8a7790 dtsi: Add L2 cache-controller nodes
>   ARM: shmobile: r8a7791 dtsi: Add L2 cache-controller node
>   ARM: shmobile: r8a7793 dtsi: Add L2 cache-controller node
>   ARM: shmobile: r8a7794 dtsi: Add L2 cache-controller node
>   arm64: renesas: r8a7795: Add L2 cache-controller nodes
> 
>  arch/arm/boot/dts/r8a73a4.dtsi           | 19 +++++++++++++++++++
>  arch/arm/boot/dts/r8a7790.dtsi           | 22 ++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7791.dtsi           | 10 ++++++++++
>  arch/arm/boot/dts/r8a7793.dtsi           |  9 +++++++++
>  arch/arm/boot/dts/r8a7794.dtsi           |  8 ++++++++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 15 +++++++++++++++
>  6 files changed, 83 insertions(+)
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

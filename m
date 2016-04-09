From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 00/12] ARM/arm64: dts: rcar: Add SYSC PM domains
Date: Sat, 09 Apr 2016 23:00:35 +0300
Message-ID: <1837405.iVihM6eUVQ@avalon>
References: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:52642 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbcDIUAm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 16:00:42 -0400
In-Reply-To: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patches.

Patches 01 to 06 look good to me expect for the power-domains = <&cpg_clocks>; 
property as explained in a reply to the SYSC driver patches.

For patches 07 to 12,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Thursday 07 Apr 2016 14:20:23 Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the R-Car System Controller to the DTS files for
> the various Renesas R-Car SoCs, and hooks up devices to their respective
> PM domains.
> 
> This is a dependency for the enablement of DU and VSP on R-Car H3, as
> on this SoC the VSPs are located in a PM Domain.
> 
> This series contains 2 parts:
>   1. Patches 1-6 add device node for the System Controllers, and hook
>      up CPU cores and L2 caches/SCUs to their respective PM Domains,
>   2. Patches 7-12 hook up devices to the SYSC "always-on" PM Domain, for
>      a more consistent device-power-area description in DT.
> 
> While part 1 is safe to apply, part 2 causes more deferred probing,
> which exposes a few deficiencies in subsystems and drivers:
> 
>   1. The PHY subsystem doesn't support deferred probe, so Micrel
>      KSZ8041RNLI (R-Car Gen2) or KSZ9031 (R-Car Gen3) falls back to
>      polling:
> 
> 	irq: no irq domain found for /interrupt-controller@e61c0000 !
> 	Micrel KSZ8041RNLI ee700000.etherne:01: attached PHY driver [Micrel
> KSZ8041RNLI] (mii_bus:phy_addr=ee700000.etherne:01, irq=-1)
> 
> 	irq: no irq domain found for /soc/gpio@e6052000 !
> 	Micrel KSZ9031 Gigabit PHY e6800000.etherne:00: attached PHY driver 
[Micrel
> KSZ9031 Gigabit PHY] (mii_bus:phy_addr=e6800000.etherne:00, irq=-1)
> 
>   2. The Audio DMAC is now initialized after rcar_sound on R-Car Gen2
>      and Gen3, so rcar_sound falls back to PIO:
> 
> 	rcar_sound ec500000.sound: can't get dma channel
> 	rcar_sound ec500000.sound: ssi[0] fallback to PIO mode
> 	rcar_sound ec500000.sound: can't get dma channel
> 	rcar_sound ec500000.sound: ssi[1] fallback to PIO mode
> 
>   3. The System DMAC is now initialized after the SPI drivers on R-Car
>      Gen2, hence they fall back to PIO:
> 
> 	renesas_spi e6b10000.spi: dma_request_slave_channel_compat failed
> 	renesas_spi e6b10000.spi: DMA not available, using PIO
> 
> 	spi_sh_msiof e6e20000.spi: dma_request_slave_channel_compat failed
> 	spi_sh_msiof e6e20000.spi: DMA not available, using PIO
> 
>   4. On r8a7790/lager, I see various i2c failures:
> 
> 	adv7180 6-0020: chip found @ 0x20 (e6520000.i2c)
> 	adv7180: probe of 6-0020 failed with error -110
> 
> 	i2c 7-0058: Masking da9063 interrupt sources
> 	i2c 7-0058: i2c error -110
> 	da9063 7-0058: Cannot read FAULT_LOG.
> 	da9063 7-0058: Cannot clear fault log
> 	da9063 7-0058: Cannot read chip model id.
> 	da9063: probe of 7-0058 failed with error -5
> 	i2c 7-0068: Masking da9210 interrupt sources
> 	i2c 7-0068: i2c error -110
> 	da9210 7-0068: Failed to write to mask reg: -110
> 	da9210: probe of 7-0068 failed with error -110
> 
> Hence for now I think it's best to just apply the first part, to allow
> progress on R-Car H3, and postpone the second part until the issues are
> sorted out.
> 
> Changes compared to v3:
>   - Add power-domains properties to the sysc nodes, to refer to the
>     SoC's Clock Domains,
>   - Extract using the SYSC "always-on" PM Domain on R-Car H3 into its
>     own patch,
>   - Add patches to use the SYSC "always-on" PM Domain on R-Car H1 and
>     R-Car Gen2,
>   - Update for recently added can0, can1, pciec0, and pciec1 device
>     nodes on R-Car H3.
> 
> Changes compared to v2:
>   - Move power area hierarchy from DT to C (cfr. DT bindings for Renesas
>     CPG/MSSR), and switch to "#power-domain-cells = <1>",
>   - Drop fallback compatibility strings, as the bindings are
>     SoC-specific,
>   - Add an "always-on" power area on R-Car H3.
> 
> Changes compared to v1:
>   - Add R-Car H3 (r8a7795) support,
>   - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
>   - Add fallback compatibility strings for R-Car Gen2 and Gen3.
> 
> Dependencies:
>   - renesas-devel-20160406-v4.6-rc2,
>   - "[PATCH v4 0/7] PM / Domains: Add DT bindings for the R-Car System
>     Controller",
>   - "[PATCH v4 00/11] soc: renesas: Add R-Car SYSC PM Domain Support".
> Note that these are hard dependencies: adding SYSC PM Domains to DTS
> files without driver support may cause breakage!
> 
> For your convenience, I've pushed this, incl. all dependencies, to the
> topic/rcar-sysc-pd-v4 branch of
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> 
> This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
> r8a7794/alt, and r8a7795/salvator-x.
> 
> Thanks for applying part 1 (patches 1-6)!
> 
> Geert Uytterhoeven (12):
>   ARM: dts: r8a7779: Add SYSC PM Domains
>   ARM: dts: r8a7790: Add SYSC PM Domains
>   ARM: dts: r8a7791: Add SYSC PM Domains
>   ARM: dts: r8a7793: Add SYSC PM Domains
>   ARM: dts: r8a7794: Add SYSC PM Domains
>   arm64: dts: r8a7795: Add SYSC PM Domains
>   ARM: dts: r8a7779: Use SYSC "always-on" PM Domain
>   ARM: dts: r8a7790: Use SYSC "always-on" PM Domain
>   ARM: dts: r8a7791: Use SYSC "always-on" PM Domain
>   ARM: dts: r8a7793: Use SYSC "always-on" PM Domain
>   ARM: dts: r8a7794: Use SYSC "always-on" PM Domain
>   arm64: dts: r8a7795: Use SYSC "always-on" PM Domain
> 
>  arch/arm/boot/dts/r8a7779.dtsi           |  55 ++++++-----
>  arch/arm/boot/dts/r8a7790.dtsi           | 156
> ++++++++++++++++-------------- arch/arm/boot/dts/r8a7791.dtsi           |
> 157 +++++++++++++++++-------------- arch/arm/boot/dts/r8a7793.dtsi         
>  | 106 +++++++++++---------- arch/arm/boot/dts/r8a7794.dtsi           | 117
> ++++++++++++----------- arch/arm64/boot/dts/renesas/r8a7795.dtsi | 124
> +++++++++++++----------- 6 files changed, 395 insertions(+), 320
> deletions(-)

-- 
Regards,

Laurent Pinchart


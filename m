From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 00/12] ARM/arm64: dts: rcar: Add SYSC PM domains
Date: Thu, 14 Apr 2016 19:39:11 +0300
Message-ID: <69568188.pxFZj2OQEq@avalon>
References: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:57029 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbcDNQjD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 12:39:03 -0400
In-Reply-To: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patches.

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wednesday 13 Apr 2016 16:44:40 Geert Uytterhoeven wrote:
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
> As "[PATCH v5 00/11] soc: renesas: Add R-Car SYSC PM Domain Support"
> merged the two initialization phases again, the issues in v4 caused by
> excessive deferred probing are gone, and both parts are now safe to
> apply.
> 
> Changes compared to v4:
>   - Add Acked-by,
>   - Remove "power-domains" property again from the sysc nodes, as the
>     System Controller theirselves are not part of the Clock Domains.
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
>   - renesas-devel-20160411-v4.6-rc3
>   - clk-renesas-for-v4.7
>   - "[PATCH v2 0/4] clk: renesas: R-Car SYSC PM Domain Preparation",
>   - "[PATCH v5 0/7] PM / Domains: Add DT bindings for the R-Car System
>     Controller",
>   - "[PATCH v5 00/11] soc: renesas: Add R-Car SYSC PM Domain Support".
> Note that these are hard dependencies: adding SYSC PM Domains to DTS
> files without driver support will cause breakage!
> 
> For your convenience, I've pushed this, incl. all dependencies, to the
> topic/rcar-sysc-pd-v5 branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> Integration with renesas-drivers-2016-04-12-v4.6-rc3 is available in the
> topic/gen3-latest branch.
> 
> This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
> r8a7794/alt, and r8a7795/salvator-x.
> 
> Thanks for applying!
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
>  arch/arm/boot/dts/r8a7779.dtsi           |  54 ++++++-----
>  arch/arm/boot/dts/r8a7790.dtsi           | 155
> ++++++++++++++++-------------- arch/arm/boot/dts/r8a7791.dtsi           |
> 156 ++++++++++++++++--------------- arch/arm/boot/dts/r8a7793.dtsi         
>  | 105 +++++++++++---------- arch/arm/boot/dts/r8a7794.dtsi           | 116
> ++++++++++++----------- arch/arm64/boot/dts/renesas/r8a7795.dtsi | 123
> +++++++++++++----------- 6 files changed, 389 insertions(+), 320
> deletions(-)

-- 
Regards,

Laurent Pinchart


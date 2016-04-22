From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v6 00/12] ARM/arm64: dts: rcar: Add SYSC PM domains
Date: Fri, 22 Apr 2016 20:45:32 +1000
Message-ID: <20160422104528.GA12957@verge.net.au>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 22, 2016 at 11:07:22AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the R-Car System Controller to the DTS files for
> the various Renesas R-Car SoCs, and hooks up devices to their respective
> PM domains.
> 
> This (more specifically patch 1) is a dependency for the enablement of the
> Display Unit on R-Car H3, as on this SoC the DU needs to use the VSPs, and the
> VSPs are located in a PM Domain.
> 
> This series contains 2 parts, for both arm64 and arm32:
>   1. Patches 1 (arm64) and 3-7 (arm32) add device node for the System
>      Controllers, and hook up CPU cores and L2 caches/SCUs to their
>      respective PM Domains,
>   2. Patches 2 (arm64) and 8-12 (arm32) hook up devices to the SYSC
>      "always-on" PM Domain, for a more consistent device-power-area
>      description in DT.
> 
> Changes compared to v5:
>   - Add Acked-by,
>   - Rebased R-Car Gen2 patches because of dropping of references to the
>     second DMA controllers,
>   - Updated for addition of sdhi[0-2] device nodes on r8a7793,
>   - Reordered arm64 patches first, as these have a higher priority.
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
>   - renesas-devel-20160422v2-v4.6-rc4.
> 
> Suggested patch application strategy:
>   - On branch arm64-dt-for-v4.7:
>       - Merge rcar-sysc-for-v4.7,
>       - Apply patches 1-2.
>   - On branch dt-for-v4.7:
>       - Merge rcar-sysc-for-v4.7,
>       - Apply patches 3-12.
> 
> Suggested arm-soc pull request strategy:
>   - Send pull-request for rcar-sysc-for-v4.7,
>   - Send pull-request for arm64-dt-for-v4.7,
>   - Send pull-request for dt-for-v4.7.
> 
> For your convenience, I've pushed this to the topic/rcar-sysc-pd-dt-v6
> branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> Integration with renesas-drivers-2016-04-12-v4.6-rc3 is available in the
> topic/gen3-latest branch.
> 
> This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
> r8a7794/alt, and r8a7795/salvator-x.
> 
> Thanks for applying!

Thanks, done.

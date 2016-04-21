From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v6 00/11] soc: renesas: Add R-Car SYSC PM Domain Support
Date: Thu, 21 Apr 2016 13:28:12 +1000
Message-ID: <20160421032811.GF11116@verge.net.au>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44183 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbcDUD2O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 23:28:14 -0400
Content-Disposition: inline
In-Reply-To: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Wed, Apr 20, 2016 at 02:02:35PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series introduces a DT-based driver for the R-Car System
> Controller, as found on Renesas R-Car H1, R-Car Gen2, and R-Car Gen3
> SoCs.
> 
> This is a dependency for the enablement of DU and VSP on R-Car H3, as
> the VSPs are located in a PM Domain.
> 
> Changes compared to v5:
>   - Add Reviewed-by,
>   - Drop unneeded genpd->dev_ops.active_wakeup callback,
>   - Move call to pm_genpd_init() after all local initialization,
> 
> Changes compared to v4:
>   - Add Reviewed-by,
>   - Mask SYSC interrupts sources before enabling them (doesn't matter
>     much as they're disabled at the GIC level anyway),
>   - Reference r8a7791_sysc_info directly for R-Car M2-N in rcar-sysc.c,
>   - Re-add explicit "always-on" power area instead of aliasing the SoC's
>     Clock Domain,
>   - Add "always-on" power area on R-Car H1 and Gen2 SoCs,
>   - Merge the two initialization phases again,
>   - Use either the cpg_mssr_*() or cpg_mstp_*() callbacks for Clock
>     Domain control,
>   - Drop dependency on r8a7795 of the Clock Domain handling, as this is
>     used for the "always-on" PM Domain on R-Car H1 and Gen2, too,
> 
> Changes compared to v3:
>   - Add Reviewed-by,
>   - Make sure not to clear reserved SYSCIMR bits that were set before,
>   - Make the always-on power area implicit and always present, and an
>     alias of the existing SoC's Clock Domain. This makes the number of
>     power areas a compile-time constant, and allows to drop PD_ALWAYS_ON
>     and some checks.
>   - Split initialization in two phases,
>   - Remove the explicit dependency on the CPG/MSSR driver by forwarding
>     the attach/detach callbacks to the parent PM Domain.
>     If deemed reusable, rcar_sysc_{at,de}tach_dev() can be moved to
>     common genpd code later.
>   - Document that ARM cores are controlled by PSCI on R-Car Gen3
>     (although the underlying CPG/APMU hardware is the same as on Gen2),
>   - Drop R8A7779_PD_SH, as it's not documented in the datasheet,
>   - Rename R8A779*_PD_SH to R8A779*_PD_SH_4A, and "sh" to "sh-4a" on
>     R-Car Gen2,
>   - Remove always-on power area from the R-Car Gen3 table, as it's now
>     implicitly handled by the rcar-sysc driver,
>   - Reformat tables,
>   - Minor improvements (double evaluation, unused parameter, debug
>     message consolidation),
>   - Update MAINTAINERS.
> 
> Changes compared to v2:
>   - Add Reviewed-by,
>   - Rename driver from pm-rcar to rcar-sysc,
>   - Create PM Domains from hierarchy in C data instead of DT,
>   - Add support for an "always-on" domain, which is currently used on
>     R-Car H3 only (support can be added for other R-Car SoCs, preferably
>     after their migration to CPG/MSSR),
>   - Drop power area A3SH on R-Car H3, as it's no longer
>     documented in the datasheet, and touching it seems to crash SYSC,
>   - Hook up the CPG/MSSR Clock Domain attach/detach callbacks instead of
>     using our own copies,
>   - Initialize SYSCIER early, as SYSC needs the interrupt sources to be
>     enabled to control power,
>   - Mask all SYSC interrupt sources for the CPU,
>   - Drop check for CONFIG_PM_GENERIC_DOMAINS, which is now always
>     enabled on R-Car SoCs,
>   - Use early_initcall() instead of core_initcall(),
>   - Do not power up CPU power areas during initialization, as this is
>     handled later (directly or indirectly) by the SMP code,
>   - Extract bindings into its own series, "[PATCH v3 0/7] PM / Domains:
>     Add DT bindings for the R-Car System Controller".
> 
> Changes compared to v1 (more details in the individual patches):
>   - Moved pm-rcar from arch/arm/mach-shmobile/ to drivers/soc/renesas/,
>   - Added R-Car H3 (r8a7795) support, incl. support for devices part of
>     a SYSC PM domain and the CPG/MSSR clock domain,
>   - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
>   - Added fallback compatibility strings for R-Car Gen2 and Gen3.
>   - Changed one-line summary prefix to match current arm-soc practices,
>   - The L2 cache-controller patches have been extracted into a separate
>     series ("[PATCH v3 0/7] ARM/arm64: dts: renesas: Add/complete L2
>     cache-controller nodes"),
>   - Minor fixes.
> 
> Dependencies:
>   - clk-renesas-for-v4.7 (which now includes "[PATCH v2 0/4] clk:
>     renesas: R-Car SYSC PM Domain Preparation"; pull request sent),
>   - renesas-devel-20160420-v4.6-rc4 (which already contains series
>     "[PATCH v5 0/7] PM / Domains: Add DT bindings for the R-Car System
>     Controller").
> 
> I won't be resending follow-up series "[PATCH v5 00/12] ARM/arm64: dts:
> rcar: Add SYSC PM domains" for now, as it's unchanged, except for an
> ugly rebase due to dropping the commits to reference both DMA
> controllers on R-Car Gen2.
> 
> For your convenience, I've pushed this, incl. all dependencies, to the
> topic/rcar-sysc-pd-v6 branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> Integration with renesas-drivers-2016-04-12-v4.6-rc3 is available in the
> topic/gen3-latest branch.
> 
> This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
> r8a7794/alt, and r8a7795/salvator-x.
> 
> Thanks!

Thanks. I am not planning to queue these up at this point.
Let me know if that is not what you expected.

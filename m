From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/8] arm64: dts: exynos: Add GSCL power domain to Exynos
 5433 SoC
Date: Fri, 27 Jan 2017 13:28:08 +0200
Message-ID: <20170127112808.he7lpzoobmnc2k7r@kozik-lap>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115559eucas1p1a219b6ae0fef16bbdb68645328b61a5e@eucas1p1.samsung.com>
 <1485345342-3273-3-git-send-email-m.szyprowski@samsung.com>
 <20170127074617.ez6wxeu5vyz6lm4x@kozik-lap>
 <62a55088-ff3d-dc4b-b0f0-9810d88801c4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32891 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934346AbdA0L2n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2017 06:28:43 -0500
Content-Disposition: inline
In-Reply-To: <62a55088-ff3d-dc4b-b0f0-9810d88801c4@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

On Fri, Jan 27, 2017 at 11:33:36AM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2017-01-27 08:46, Krzysztof Kozlowski wrote:
> > On Wed, Jan 25, 2017 at 12:55:36PM +0100, Marek Szyprowski wrote:
> > > This patch adds support for GSCL power domain to Exynos 5433 SoCs, which
> > > contains following devices: a clock controller, three GSCL video scalers and
> > > their SYSMMUs.
> > > 
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >   arch/arm64/boot/dts/exynos/exynos5433.dtsi | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> > > index 16072c1c3ed3..74c767d756ac 100644
> > > --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> > > +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> > > @@ -425,6 +425,7 @@
> > >   			clocks = <&xxti>,
> > >   				<&cmu_top CLK_ACLK_GSCL_111>,
> > >   				<&cmu_top CLK_ACLK_GSCL_333>;
> > > +			power-domains = <&pd_gscl>;
> > >   		};
> > >   		cmu_apollo: clock-controller@11900000 {
> > > @@ -525,6 +526,12 @@
> > >   				<&cmu_top CLK_ACLK_CAM1_552>;
> > >   		};
> > > +		pd_gscl: gscl-power-domain@105c4000 {
> > The name of node: just "power-domain". This should be generic class of
> > device (following ePAPR).
> > 
> > The same applies to other patches.
> 
> Well, this makes the debugging much harder, but I will change it to generic
> names.

Good point. I remember some patch from Javier trying to address this but
I cannot find it anymore.

Anyway, I don't think power-domains should be treated here differently
then rest of devices (which have generic names: clock-controller,
pinctrl, i2s, i2c etc).

> Also existing Exynos dtsi should be fixed in this area (Exynos4 still
> use such more descriptive names).

I am trying to bring some shape to new code but of course you are right
- old code should be adjusted as well (maybe as part of some bigger
  cleanup). Exynos5420 uses short/generic names.

> I will check how hard is to add real
> domain names directly to the Exynos power domain driver then.

Thanks!

Krzysztof

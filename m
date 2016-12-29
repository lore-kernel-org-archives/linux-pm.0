From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: Add CPU OPPs for Exynos4412 Prime
Date: Thu, 29 Dec 2016 16:49:08 +0200
Message-ID: <20161229144908.6gkvjpso7ikdmfp7@kozik-lap>
References: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161229133734epcas5p1e893904353c23170e82ece54a06aebed@epcas5p1.samsung.com>
 <1483018611-27998-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483018611-27998-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 29, 2016 at 02:36:51PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Add CPU operating points for Exynos4412 Prime (it supports
> additional 1704MHz & 1600MHz OPPs and 1500MHz OPP is just
> a regular non-turbo OPP on this SoC).  Also update relevant
> cooling maps to account for new OPPs.
> 
> ODROID-X2/U2/U3 boards use Exynos4412 Prime SoC version so
> update their board files accordingly.
> 
> Based on Hardkernel's kernel for ODROID-X2/U2/U3 boards.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Cc: Ben Gamari <ben@smart-cactus.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
>  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
>  arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
>  arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
>  5 files changed, 48 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi
> 

Looks okay. Is the clock patch needed for this?

BR,
Krzysztof

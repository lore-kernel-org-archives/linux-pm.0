From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 13 Jan 2016 21:43:07 +0100
Message-ID: <8579242.omBpg1aLr2@wuerfel>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com> <1449241037-22193-17-git-send-email-jonathanh@nvidia.com> <20160113170324.GO2588@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55262 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933687AbcAMUn4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 15:43:56 -0500
In-Reply-To: <20160113170324.GO2588@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
> > Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
> > dependent upon a particular power-domain are only probed when that power
> > domain has been powered up, requires that PM is made mandatory for tegra
> > 64-bit devices and so select this option for tegra as well.
> > 
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  arch/arm64/Kconfig.platforms | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 9806324fa215..e0b5bd0aff0f 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -93,6 +93,8 @@ config ARCH_TEGRA
> >       select GENERIC_CLOCKEVENTS
> >       select HAVE_CLK
> >       select PINCTRL
> > +     select PM
> > +     select PM_GENERIC_DOMAINS
> >       select RESET_CONTROLLER
> >       help
> >         This enables support for the NVIDIA Tegra SoC family.
> 
> This has potential consequences for multi-platform builds, doesn't it?
> All of a sudden any combination of builds that includes Tegra won't be
> possible to build without PM support.
> 
> Adding linux-arm-kernel@lists.infradead.org for visibility.
> 
> 

Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
dependencies in the drivers that require it.

	Arnd

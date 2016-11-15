From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal: hisilicon: fix for dependency
Date: Tue, 15 Nov 2016 20:24:55 +0800
Message-ID: <1479212695.2224.12.camel@intel.com>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
         <1472633417-9330-3-git-send-email-leo.yan@linaro.org>
         <20161112120534.GC23848@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161112120534.GC23848@leoy-linaro>
Sender: linux-clk-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <treding@nvidia.com>, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2016-11-12 at 20:05 +0800, Leo Yan wrote:
> Hi Rui, Eduardo,
> 
> On Wed, Aug 31, 2016 at 04:50:16PM +0800, Leo Yan wrote:
> > 
> > The thermal driver is standalone driver which is used to enable
> > thermal sensors, so it can be used with any cooling device and
> > should not bind with CPU cooling device driver.
> > 
> > This original patch is suggested by Amit Kucheria; so it's to
> > polish the dependency in Kconfig, and remove the dependency with
> > CPU_THERMAL.
> Could you help review this patch? Or need me resend this patch? Sorry
> I have not tracked this patches well before, this is one missed
> patch for 96board Hikey.
> 
as it still applies cleanly, the patch is queued for 4.10.

thanks,
rui
> Thanks,
> Leo Yan
> 
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/thermal/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 2d702ca..91ebab3 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -177,8 +177,10 @@ config THERMAL_EMULATION
> >  
> >  config HISI_THERMAL
> >  	tristate "Hisilicon thermal driver"
> > -	depends on (ARCH_HISI && CPU_THERMAL && OF) ||
> > COMPILE_TEST
> > +	depends on ARCH_HISI || COMPILE_TEST
> >  	depends on HAS_IOMEM
> > +	depends on OF
> > +	default y
> >  	help
> >  	  Enable this to plug hisilicon's thermal sensor driver
> > into the Linux
> >  	  thermal framework. cpufreq is used as the cooling device
> > to throttle

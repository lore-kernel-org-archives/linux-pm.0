From: Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v5 2/4] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Date: Wed, 13 Jun 2018 16:58:53 +0100
Message-ID: <20180613155819.GA10090@arch>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <20180607181306.9766-2-ctatlor97@gmail.com>
 <e1a78fe3-593d-d39c-05b3-a1cc2b948e90@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e1a78fe3-593d-d39c-05b3-a1cc2b948e90@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 07, 2018 at 12:08:20PM -0700, Randy Dunlap wrote:
> On 06/07/2018 11:12 AM, Craig Tatlor wrote:
> > This patch adds a driver for the BMS (Battery Monitoring System)
> > block of the PM8941 PMIC, it uses a lookup table defined in the
> > device tree to generate a capacity from the BMS supplied OCV, it
> > then ammends the coulomb counter to that to increase the accuracy
> 
>        amends
> 
> > of the estimated capacity.
> > 
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > ---
> 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 428b426842f4..6c354c37bc55 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -82,6 +82,15 @@ config BATTERY_ACT8945A
> >  	  Say Y here to enable support for power supply provided by
> >  	  Active-semi ActivePath ACT8945A charger.
> >  
> > +config BATTERY_BMS
> > +	tristate "Qualcomm Battery Monitoring System driver"
> > +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> > +	depends on OF
> > +	depends on REGMAP_SPMI
> 
> 	select REGMAP_SPMI
> 
> I'm not a fan of "select", but it does not have a prompt string so it isn't
> user settable (not directly; it can be set indirectly).
> And all other uses of it in Kconfig files use "select".
> 
> > +	help
> > +	  Say Y to include support for the Battery Monitoring hardware
> > +	  found in some Qualcomm PM series PMICs.
> > +
> >  config BATTERY_CPCAP
> >  	tristate "Motorola CPCAP PMIC battery driver"
> >  	depends on MFD_CPCAP && IIO
> 
Thanks for the review.
> 
> -- 
> ~Randy

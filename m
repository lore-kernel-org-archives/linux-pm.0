From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
Date: Tue, 08 Aug 2017 17:15:08 +0800
Message-ID: <1502183708.4296.25.camel@intel.com>
References: <20170721161704.3335851-1-arnd@arndb.de>
         <1501356129.3479.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbdHHJPM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 05:15:12 -0400
In-Reply-To: <1501356129.3479.1.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat, 2017-07-29 at 13:22 -0600, Pandruvada, Srinivas wrote:
> On Fri, 2017-07-21 at 18:16 +0200, Arnd Bergmann wrote:
> > 
> > We get a Kconfig warning when selecting this without also enabling
> > CONFIG_PCI:
> > 
> > warning: (X86_INTEL_LPSS && INTEL_SOC_DTS_IOSF_CORE &&
> > SND_SST_IPC_ACPI && MMC_SDHCI_ACPI && PUNIT_ATOM_DEBUG) selects
> > IOSF_MBI which has unmet direct dependencies (PCI)
> > 
> > This adds a new depedency.
> > 
> > Fixes: 3a2419f865a6 ("Thermal: Intel SoC: DTS thermal use common
> > APIs")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com

Applied.

thanks,
rui
> >
> 
> > 
> > ---
> >  drivers/thermal/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index b5b5facb8747..ac2a53823576 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -342,7 +342,7 @@ config X86_PKG_TEMP_THERMAL
> >  
> >  config INTEL_SOC_DTS_IOSF_CORE
> >  	tristate
> > -	depends on X86
> > +	depends on X86 && PCI
> >  	select IOSF_MBI
> >  	help
> >  	  This is becoming a common feature for Intel SoCs to
> > expose
> > the additional
> > @@ -352,7 +352,7 @@ config INTEL_SOC_DTS_IOSF_CORE
> >  
> >  config INTEL_SOC_DTS_THERMAL
> >  	tristate "Intel SoCs DTS thermal driver"
> > -	depends on X86
> > +	depends on X86 && PCI
> >  	select INTEL_SOC_DTS_IOSF_CORE
> >  	select THERMAL_WRITABLE_TRIPS
> >  	help

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86
 thermal
Date: Mon, 03 Aug 2015 08:49:03 -0700
Message-ID: <1438616943.17718.2.camel@spandruv-DESK3.jf.intel.com>
References: <1438494401-3984-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20150803031033.GA25688@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60230 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbbHCPvc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 11:51:32 -0400
In-Reply-To: <20150803031033.GA25688@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org

On Sun, 2015-08-02 at 20:10 -0700, Eduardo Valentin wrote:
> Srinivas,
> 
> On Sat, Aug 01, 2015 at 10:46:41PM -0700, Srinivas Pandruvada wrote:
> > After the commit "thermal: core: Add Kconfig option to enable writable trips",
> > user space tools like thermal daemon and Chrome OS DPTF thermal controller
> > can no longer receive async events for thermal thresholds. Since we need to
> > enable the new config introduced by above commit to allow writable trips.
> > Selecting CONFIG_THERMAL_WRITABLE_TRIPS for x86 thermal drivers.
> 
> I am fine with enabling the config on x86 drivers. However the
> description is somewhat confusing. Are you sure you are not receiving
> async events or you are not able to write on trip point files?
> 
> Because that's all this option does (quoting thermal_core.c):
>                 if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
>                     mask & (1 << indx)) {
>                         tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
>                         tz->trip_temp_attrs[indx].attr.store =
>                                                         trip_point_temp_store;
>                 }
> 
> 
> I am not really sure if this change is going to give your events back.
> 
> 
> can you please confirm what you are trying to achieve here?
> 
Sorry for the confusion. Since we can't write thresholds, we can't get
asynchronous events for thresholds. This config prevents writable trips,
hence we need to select this config.

Thanks,
Srinivas

> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/thermal/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 118938e..0e3b576 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -275,6 +275,7 @@ config X86_PKG_TEMP_THERMAL
> >  	tristate "X86 package temperature thermal driver"
> >  	depends on X86_THERMAL_VECTOR
> >  	select THERMAL_GOV_USER_SPACE
> > +	select THERMAL_WRITABLE_TRIPS
> >  	default m
> >  	help
> >  	  Enable this to register CPU digital sensor for package temperature as
> > @@ -296,6 +297,7 @@ config INTEL_SOC_DTS_THERMAL
> >  	tristate "Intel SoCs DTS thermal driver"
> >  	depends on X86
> >  	select INTEL_SOC_DTS_IOSF_CORE
> > +	select THERMAL_WRITABLE_TRIPS
> >  	help
> >  	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
> >  	  temperature sensor (DTS). These SoCs have two additional DTSs in
> > @@ -322,6 +324,7 @@ config INT340X_THERMAL
> >  	select ACPI_THERMAL_REL
> >  	select ACPI_FAN
> >  	select INTEL_SOC_DTS_IOSF_CORE
> > +	select THERMAL_WRITABLE_TRIPS
> >  	help
> >  	  Newer laptops and tablets that use ACPI may have thermal sensors and
> >  	  other devices with thermal control capabilities outside the core
> > -- 
> > 2.4.3
> > 



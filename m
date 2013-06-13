From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] thermal: add imx thermal driver support
Date: Thu, 13 Jun 2013 12:12:09 +0800
Message-ID: <20130613041207.GA14259@S2101-09.ap.freescale.net>
References: <1370330008-5982-1-git-send-email-shawn.guo@linaro.org>
 <1371093177.2135.24.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:54743
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840Ab3FMELg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2013 00:11:36 -0400
Content-Disposition: inline
In-Reply-To: <1371093177.2135.24.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jun 13, 2013 at 11:12:57AM +0800, Zhang Rui wrote:
> On Tue, 2013-06-04 at 15:13 +0800, Shawn Guo wrote:
> > This is based on the initial imx thermal work done by
> > Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
> > valid).  Since he is no longer interested in the work and I have
> > rewritten a significant amount of the code, I just took the authorship
> > over from him.
> > 
> > It adds the imx thermal support using Temperature Monitor (TEMPMON)
> > block found on some Freescale i.MX SoCs.  The driver uses syscon regmap
> > interface to access TEMPMON control registers and calibration data, and
> > supports cpufreq as the cooling device.
> > 
> you're using the cpufrq_cooling to throttle cpus at 85C, right?

Yes.

> then you should register it as THERMAL_TRIP_PASSIVE instead of
> THERMAL_TRIP_ACTIVE.

Yes, literally it should be a passive trip point rather than active
one.  But I'm not sure if there is any real functional differences
between them in my thermal case, except I have to give both
passive_delay and polling_delay in thermal_zone_device_register()
call for passive type while it only needs polling_delay for active type
to work properly.

Besides, both exynos and db8500 thermal drivers register active trip
point while they are using cpufreq as the cooling device.  So I thought
it's fine to not have the trip type literally correct.

Shawn


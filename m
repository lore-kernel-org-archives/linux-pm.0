From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH 1/5] thermal: of: fix cooling device weights in device
 tree
Date: Sun, 1 Feb 2015 12:21:14 +0000
Message-ID: <20150201122114.GK2874@e104805>
References: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
 <1421947625-19708-2-git-send-email-javi.merino@arm.com>
 <20150131000018.GB14374@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40450 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752779AbbBAMVY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 07:21:24 -0500
Content-Disposition: inline
In-Reply-To: <20150131000018.GB14374@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene@kernel.org>

Hi Eduardo,

On Sat, Jan 31, 2015 at 12:00:19AM +0000, Eduardo Valentin wrote:
> On Thu, Jan 22, 2015 at 05:27:01PM +0000, Javi Merino wrote:
> > From: Kapileshwar Singh <kapileshwar.singh@arm.com>
> > 
> > Currently you can specify the weight of the cooling device in the device
> > tree but that information is not populated to the
> > thermal_bind_params where the fair share governor expects it to
> > be.  The of thermal zone device doesn't have a thermal_bind_params
> > structure and arguably it's better to pass the weight inside the
> > thermal_instance as it is specific to the bind of a cooling device to a
> > thermal zone parameter.
> > 
> > Core thermal code is fixed to populate the weight in the instance from
> > the thermal_bind_params, so platform code that was passing the weight
> > inside the thermal_bind_params continue to work seamlessly.
> > 
> > While we are at it, create a default value for the weight parameter for
> > those thermal zones that currently don't define it and remove the
> > hardcoded default in of-thermal.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
> > ---
> > 
> > This patch was previously suggested here[0].  During the discussion,
> > Eduardo suggested that dropping the bind op for of-thermal and using
> > tbps and their .match() function was preferrable.  We sent a series
> > that did that in [1].  However, looking at the code we think that this
> > patch is preferrable as it is simpler and enables the rest of the
> > patches in these series, specially the simplification in patch 2.
> > That's why we are reposting it, now properly asking for inclusion.
> > 
> > [0] http://thread.gmane.org/gmane.linux.power-management.general/54622
> > [1] http://thread.gmane.org/gmane.linux.power-management.general/55339
> 
> Despite going one way or another, this patch breaks existing users of
> the thermal_zone_bind_cooling_device API.
> 
> > 
> >  Documentation/thermal/sysfs-api.txt                |  4 +++-
> >  drivers/thermal/db8500_thermal.c                   |  2 +-
> >  drivers/thermal/fair_share.c                       |  2 +-
> >  drivers/thermal/imx_thermal.c                      |  3 ++-
> >  drivers/thermal/of-thermal.c                       |  5 +++--
> >  drivers/thermal/samsung/exynos_thermal_common.c    |  3 ++-
> >  drivers/thermal/thermal_core.c                     | 22 ++++++++++++++++------
> >  drivers/thermal/thermal_core.h                     |  1 +
> >  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 ++-
> >  include/linux/thermal.h                            |  6 +++++-
> >  10 files changed, 36 insertions(+), 15 deletions(-)
> 
> $ git grep thermal_zone_bind_cooling_device
> Documentation/thermal/sysfs-api.txt:1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
> Documentation/thermal/sysfs-api.txt:thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device.
> drivers/acpi/thermal.c:					thermal_zone_bind_cooling_device
> drivers/acpi/thermal.c:				result = thermal_zone_bind_cooling_device
> drivers/acpi/thermal.c:				result = thermal_zone_bind_cooling_device
> 
> We are not supposed to break ACPI code base :-)
> 
> drivers/platform/x86/acerhdf.c:	if (thermal_zone_bind_cooling_device(thermal, 0, cdev,
> 
> You may want to add acerhdf to your patch.
 
Yes, we'll send a v2 with ACPI and acerhdf.

Cheers,
Javi

From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V2 1/3] Thermal: rename thermal_sys.c to thermal_core.c
Date: Fri, 12 Apr 2013 09:12:56 +0800
Message-ID: <1365729176.2183.20.camel@rzhang1-mobl4>
References: <1364567196-3560-1-git-send-email-rui.zhang@intel.com>
	 <1364567196-3560-2-git-send-email-rui.zhang@intel.com>
	 <515DE192.1030408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8936 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523Ab3DLBNA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Apr 2013 21:13:00 -0400
In-Reply-To: <515DE192.1030408@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, durgadoss.r@intel.com, andi@lisas.de

On Thu, 2013-04-04 at 16:24 -0400, Eduardo Valentin wrote:
> On 29-03-2013 10:26, Zhang Rui wrote:
> > this is the preparation work to build all the thermal core framework
> > source file, like governors, cpu cooling, etc, into one module.
> >
> > No functional change in this patch.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Durga and me have already reviewed and acked this patch. Can you please 
> add our Acked-by on this patch?

sure.
BTW, I've talked with Rafael, and we agree on adding prefix "acpi_" for
ACPI drivers, and then we can rename thermal_sys.ko to thermal.ko.

But I'll try to push this patch set for 3.10, to fix the problem on
hand, also for easily back porting to 3.8 and 3.9 stable kernel.
Then, we'll rename a couple of ACPI drivers and then thermal driver in
3.11.

what do you think?

thanks,
rui

> 
> > ---
> >   drivers/thermal/Makefile                          |    1 +
> >   drivers/thermal/{thermal_sys.c => thermal_core.c} |    0
> >   2 files changed, 1 insertion(+)
> >   rename drivers/thermal/{thermal_sys.c => thermal_core.c} (100%)
> >
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index d3a2b38..b2009bd 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -3,6 +3,7 @@
> >   #
> >
> >   obj-$(CONFIG_THERMAL)		+= thermal_sys.o
> > +thermal_sys-y			+= thermal_core.o
> >
> >   # governors
> >   obj-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= fair_share.o
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_core.c
> > similarity index 100%
> > rename from drivers/thermal/thermal_sys.c
> > rename to drivers/thermal/thermal_core.c
> >
> 



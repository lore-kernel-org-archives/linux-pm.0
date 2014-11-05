From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v9 2/4] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Wed, 05 Nov 2014 09:48:56 +0100
Message-ID: <1415177336.15850.14.camel@AMDC1943>
References: <1415105570-7871-1-git-send-email-k.kozlowski@samsung.com>
 <1415105570-7871-3-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFo6o8v9u6+MdGSRMmHeMcODqCcdToHXoJqVGcsRVgQwdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:21641 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaKEItA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 03:49:00 -0500
In-reply-to: <CAPDyKFo6o8v9u6+MdGSRMmHeMcODqCcdToHXoJqVGcsRVgQwdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On wto, 2014-11-04 at 20:06 +0100, Ulf Hansson wrote:
> On 4 November 2014 13:52, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> > The AMBA bus driver defines runtime Power Management functions which
> > disable and unprepare AMBA bus clock. This is problematic for runtime PM
> > because unpreparing a clock might sleep so it is not interrupt safe.
> >
> > However some drivers may want to implement runtime PM functions in
> > interrupt-safe way (see pm_runtime_irq_safe()). In such case the AMBA
> > bus driver should only disable/enable the clock in runtime suspend and
> > resume callbacks.
> >
> > Detect the device driver behavior during runtime suspend. During runtime
> > resume deal with clocks according to stored value.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/amba/bus.c       | 24 ++++++++++++++++++++----
> >  include/linux/amba/bus.h |  1 +
> >  2 files changed, 21 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 47bbdc1b5be3..27ec8882ec8e 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -85,6 +85,13 @@ static struct device_attribute amba_dev_attrs[] = {
> >  };
> >
> >  #ifdef CONFIG_PM
> > +
> > +#ifdef CONFIG_PM_RUNTIME
> > +#define get_pm_runtime_irq_safe(dev)   ((dev)->power.irq_safe)
> > +#else
> > +#define get_pm_runtime_irq_safe(dev)   1
> 
> No, this doesn't work for those drivers that isn't configured as
> irq_safe. The pm_runtime_force_suspend() invoked from the driver's
> system PM suspend callback, will expect clocks to be unprepared when
> CONFIG_PM_RUNTIME is unset.

D'oh! You're right... 

> To address this issue, in principle we need to know whether the driver
> has invoked pm_runtime_irq_safe(), even when CONFIG_PM_RUNTIME is
> unset.
> 
> This may be solved by the help of PM core:
> 1) Move the irq_safe member in the struct dev_pm_info, outside the
> #ifdef CONFIG_PM_RUNTIME.
> 2) Let the pm_runtime_irq_safe() function be implemented for CONFIG_PM
> instead of CONFIG_PM_RUNTIME.

Before I'll start implementing this - could PM maintainers share their
opinion on such change?

Best regards,
Krzysztof


> If the PM core maintainers don't like that approach we can always add
> an amba specific wrapper function for pm_runtime_irq_safe() and store
> the information needed in the struct amba_device.
> 
> Kind regards
> Uffe



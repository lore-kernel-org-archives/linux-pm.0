From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 1/4] PM / Runtime: Add getter for quering the IRQ safe
 option
Date: Mon, 15 Sep 2014 17:11:33 +0200
Message-ID: <1410793893.883.4.camel@AMDC1943>
References: <Pine.LNX.4.44L0.1409151056170.1360-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:37676 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaIOPLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Sep 2014 11:11:37 -0400
In-reply-to: <Pine.LNX.4.44L0.1409151056170.1360-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On pon, 2014-09-15 at 10:57 -0400, Alan Stern wrote:
> On Mon, 15 Sep 2014, Krzysztof Kozlowski wrote:
> 
> > Add a simple getter pm_runtime_is_irq_safe() for quering whether runtime
> > PM IRQ safe was set or not.
> > 
> > Various bus drivers implementing runtime PM may use choose to suspend
> > differently based on IRQ safeness status of child driver (e.g. do not
> > unprepare the clock if IRQ safe is not set).
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  include/linux/pm_runtime.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 367f49b9a1c9..44d74f0f182e 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -128,6 +128,11 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
> >  	ACCESS_ONCE(dev->power.last_busy) = jiffies;
> >  }
> >  
> > +static inline bool pm_runtime_is_irq_safe(struct device *dev)
> > +{
> > +	return dev->power.irq_safe;
> > +}
> > +
> 
> If you add something to the runtime PM API, you must update the 
> documentation file (Documentation/power/runtime_pm.txt) 
> correspondingly.


Thank you for pointing this out. I'll fix this and re-spin.

Best regards,
Krzysztof

> 
> Alan Stern


From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v8 3/5] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Mon, 03 Nov 2014 09:36:45 +0100
Message-ID: <1415003805.4241.6.camel@AMDC1943>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
 <1413795888-18559-4-git-send-email-k.kozlowski@samsung.com>
 <1479283.dvHduzBoyf@vostro.rjw.lan>
 <20141101005514.GY27405@n2100.arm.linux.org.uk>
 <20141101010113.GA3831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20141101010113.GA3831@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On sob, 2014-11-01 at 01:01 +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 01, 2014 at 12:55:14AM +0000, Russell King - ARM Linux wrote:
> > On Sat, Nov 01, 2014 at 01:45:47AM +0100, Rafael J. Wysocki wrote:
> > > On Monday, October 20, 2014 11:04:46 AM Krzysztof Kozlowski wrote:
> > > > @@ -198,8 +217,10 @@ static int amba_probe(struct device *dev)
> > > >  		pm_runtime_enable(dev);
> > > >  
> > > >  		ret = pcdrv->probe(pcdev, id);
> > > > -		if (ret == 0)
> > > > +		if (ret == 0) {
> > > > +			pcdev->irq_safe = pm_runtime_is_irq_safe(dev);
> > > 
> > > This looks racy.
> > > 
> > > Is it guaranteed that runtime PM callbacks won't be run for the device
> > > after pcdrv->probe() has returned and before setting pcdev->irq_safe?
> > > If not, inconsistent behavior may ensue.
> > 
> > You are absolutely correct.  So that knocks that idea on its head.
> 
> Actually, I think we shouldn't give up hope here.  Currently, we do this:
> 
>                 pm_runtime_get_noresume(dev);
>                 pm_runtime_set_active(dev);
>                 pm_runtime_enable(dev);
> 
>                 ret = pcdrv->probe(pcdev, id);
> 
> What we could do is:
> 
> 		pm_runtime_get_noresume(dev);
>                 pm_runtime_get_noresume(dev);
>                 pm_runtime_set_active(dev);
>                 pm_runtime_enable(dev);
> 
>                 ret = pcdrv->probe(pcdev, id);
> 		if (ret == 0) {
> 			pcdev->irq_safe = pm_runtime_is_irq_safe(dev);
> 			pm_runtime_put(dev);
> 			break;
> 		}
> 
>                 pm_runtime_disable(dev);
>                 pm_runtime_set_suspended(dev);
>                 pm_runtime_put_noidle(dev);
>                 pm_runtime_put_noidle(dev);
> 
> which would ensure that we hold a usecount until after the probe function
> has returned.  Would that work?
> 
> I'll give you that it's pretty horrid.

> Would another possible solution be to remember the irq-safeness in the
> suspend handler, and use that in the resume handler?  Resume should
> /always/ undo what the suspend handler previously did wrt clk API stuff.

I think the second solution could be more readable. The WARN_ON wouldn't
be needed. However this won't solve the two dual nature of runtime
callbacks.

I wondered also about removing runtime PM callbacks from amba/bus.c
completely and moving this to child drivers. This way runtime PM would
be obvious in each driver case.

Best regards,
Krzysztof



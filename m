From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 3/4] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Tue, 16 Sep 2014 11:34:55 +0200
Message-ID: <1410860095.16106.1.camel@AMDC1943>
References: <1410857494-15936-1-git-send-email-k.kozlowski@samsung.com>
 <1410857494-15936-4-git-send-email-k.kozlowski@samsung.com>
 <20140916092006.GG12361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49594 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaIPJe7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Sep 2014 05:34:59 -0400
In-reply-to: <20140916092006.GG12361@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On wto, 2014-09-16 at 10:20 +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 16, 2014 at 10:51:33AM +0200, Krzysztof Kozlowski wrote:
> > @@ -191,8 +210,11 @@ static int amba_probe(struct device *dev)
> >  		pm_runtime_enable(dev);
> >  
> >  		ret = pcdrv->probe(pcdev, id);
> > -		if (ret == 0)
> > +		if (ret == 0) {
> > +			if (pm_runtime_is_irq_safe(dev))
> > +				pcdev->irq_safe = 1;
> 
> Patch looks good, though I'd prefer this to always explicitly initialise
> pcdev->irq_safe each time a probe succeeds.

No problem, I'll add this and resend.

Thank you for feedback,
Krzysztof


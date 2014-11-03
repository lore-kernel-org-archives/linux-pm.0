From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe
 option
Date: Mon, 03 Nov 2014 09:51:10 +0100
Message-ID: <1415004670.4241.11.camel@AMDC1943>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
 <32933431.rIxraemF7M@vostro.rjw.lan>
 <20141031230452.GX27405@n2100.arm.linux.org.uk>
 <1615499.6LK9Yd7Lr0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48978 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaKCIvO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 03:51:14 -0500
In-reply-to: <1615499.6LK9Yd7Lr0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>

On sob, 2014-11-01 at 01:42 +0100, Rafael J. Wysocki wrote:
> On Friday, October 31, 2014 11:04:52 PM Russell King - ARM Linux wrote:
> > On Sat, Nov 01, 2014 at 12:11:05AM +0100, Rafael J. Wysocki wrote:
> > > [CC list trimmed + added Kevin Hilman]
> > > 
> > > On Monday, October 20, 2014 11:04:44 AM Krzysztof Kozlowski wrote:
> > > > Add a simple getter pm_runtime_is_irq_safe() for querying whether runtime
> > > > PM IRQ safe was set or not.
> > > > 
> > > > Various bus drivers implementing runtime PM may use choose to suspend
> > > > differently based on IRQ safeness status of child driver (e.g. do not
> > > > unprepare the clock if IRQ safe is not set).
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > 
> > > So why do we need to add the wrapper?
> > > 
> > > And it goes kind of against the intention which was to set irq_safe when
> > > we knew that the callbacks were safe to be executed from interrupt context
> > > and not when we wished that to be the case.
> > 
> > This was provided in the covering email - I quote:
> > 
> > This patchset adds runtime and system PM to the pl330 driver.
> > 
> > The runtime PM of pl330 driver requires interrupt safe suspend/resume
> > callbacks which is in conflict with current amba bus driver.
> > The latter also unprepares and prepares the AMBA bus clock which
> > is not safe for atomic context.
> > 
> > The patchset solves this in patch 3/5 by handling clocks in different
> > way if device driver set interrupt safe runtime PM.
> 
> So I'm still unsure why we need the wrapper.  IMHO this check in particular:
> 
> 	WARN_ON(pcdev->irq_safe != pm_runtime_is_irq_safe(dev));
> 
> (and should that be WARN_ON_ONCE(), for that matter?), looks better this way:
> 
> 	WARN_ON(pcdev->irq_safe != dev->power.irq_safe);
> 
> and so on, pretty much.

I used the wrapper only to hide the actual code behind interface but it
don't really matter to me.

> Besides, these special "irq safe" code paths in the bus type look
> considerably ugly to me.  I'd probably use an "irq safe" PM domain for
> that device and put it in there instead of doing the
> 
> 	pcdev->irq_safe = pm_runtime_is_irq_safe(dev);
> 
> thing in amba_probe().  But that's just me. :-)

The device is not attached to any domain and there is no hardware domain
matching.

Thanks for feedback!

Best regards,
Krzysztof

> 
> There's one weak point in [3/5], but let me comment it in there.
> 
> Rafael


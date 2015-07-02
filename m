From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Thu, 2 Jul 2015 11:21:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507021054160.1320-100000@iolanthe.rowland.org>
References: <CAAObsKAWgp3mL5Z2WJDMdMZpe7ORZJRPf607KLj98eAf6-_AtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41217 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752670AbbGBPVS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 11:21:18 -0400
In-Reply-To: <CAAObsKAWgp3mL5Z2WJDMdMZpe7ORZJRPf607KLj98eAf6-_AtQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2 Jul 2015, Tomeu Vizoso wrote:

> > Just because these sub-devices are virtual, it doesn't mean you can
> > ignore the way they interact with runtime PM.
> 
> Fair enough, but then, how are we expected to be able to use the
> direct_complete facility if the core bails out if a descendant doesn't
> have runtime PM enabled?
> 
> > In the case of ep_87 this doesn't matter.  Endpoint devices (like all
> > devices) are in the SUSPENDED state by default when they are created,
> > and they never leave that state.
> 
> I don't see why it doesn't matter for endpoints or the others. They
> don't have runtime PM enabled, so no ancestor will be able to do
> direct_complete.

Ah, you're concerned about these lines near the start of
__device_suspend():

	if (dev->power.direct_complete) {
		if (pm_runtime_status_suspended(dev)) {
			pm_runtime_disable(dev);
			if (pm_runtime_suspended_if_enabled(dev))
				goto Complete;

			pm_runtime_enable(dev);
		}
		dev->power.direct_complete = false;
	}

Perhaps the pm_runtime_suspended_if_enabled() test should be changed to
pm_runtime_status_suspended().  Then it won't matter whether the
descendant devices are enabled for runtime PM.

> > A possible way around the problem is to use pm_suspend_ignore_children
> > on the uvcvideo interface.  But I'm not sure that would be the right
> > thing to do.
> 
> Would that mean that if a device has ignore_children then it could
> still do direct_complete even if its descendants weren't able to?

I think we could justify that.  The ignore_children flag means we can 
communicate with the children even when the device is in runtime 
suspend, so there's no reason to force the device to leave runtime 
suspend during a system sleep.

Alan Stern


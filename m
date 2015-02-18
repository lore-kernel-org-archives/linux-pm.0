From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 13:42:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1502181336090.1245-100000@iolanthe.rowland.org>
References: <20150218172651.GV8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49529 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752752AbbBRSnB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 13:43:01 -0500
In-Reply-To: <20150218172651.GV8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wed, 18 Feb 2015, Russell King - ARM Linux wrote:

> So, let's take what we're currently doing on DT, and make it the same
> across the board.  In platform_drv_probe(), let's do this:
> 
> 	/* attach the domain */
>         ret = dev_pm_domain_attach(_dev, true);
> 	if (ret == -EPROBE_DEFER)
> 		goto defer;
> 
> 	/* power up the domain - and hold it powered up */
> 	ret = dev_pm_domain_pre_probe(_dev);
> 	if (ret != -ENOSYS)
> 		goto error;
> 
> 	ret = drv->probe(dev);
> 
> 	/*
> 	 * remove the "hold" on the domain by this device, and start
> 	 * tracking its runtime PM status.
> 	 */
> 	dev_pm_domain_post_probe(_dev);
> 
> 	if (ret)
> 		dev_pm_domain_detach(_dev, true);
> 
> What this means is that while the probe function is running, we guarantee
> that the PM domain will always be powered up.  We also guarantee that
> after the probe function has returned, we will then start tracking the
> runtime PM state, and if the device driver leaves runtime PM in the
> "suspended" state, PM domains will get to hear about it at that point,
> and can transition the PM domain back to "off" mode.
> 
> Both these transitions only cause the PM domain to be affected; no
> runtime PM callbacks are issued for either of these two changes.  (We
> already have that for the initial state right now where attaching a
> device to the PM domain causes the PM domain to be powered up.)
> 
> This is merely an extension of the current scheme.  Think of
> dev_pm_domain_post_probe() as a method of synchronising the state of
> PM domains with the state of runtime PM across all attached devices.

This seems like the right sort of approach.

The Runtime PM core has a general philosophy that it can never force
anything to be in the suspended state.  Therefore if you need something
to be in a well-defined power state for any length of time (or if you
need to know the power state), you have to force it into the active
state.

> Aside:
> I need to do some further checks; while considering this, I think I've
> come across a worrying problem with "PM / Domains: Power on the PM domain
> right after attach completes".  I think this will result in the driver's
> runtime_resume callback being invoked _before_ the probe function.  I
> can't test this right now as I'm in the middle of upgrading my dev box
> and it doesn't have a functional install for building ARM kernels yet.

Subsystems always face this problem, because the device core sets
dev->driver before calling the probe routine.  (There's a similar
problem on the other side, where the device core doesn't clear
dev->driver until after the remove routine has returned.)  To cope with
this, the subsystem-level runtime-PM callbacks have to be careful not
to invoke the driver-level callbacks before probing is finished or
after removal has started.

Alan Stern


From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 19:05:27 +0100
Message-ID: <20650078.BNFxZSQ3vj@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1502181007320.1245-100000@iolanthe.rowland.org> <1790876.GQ4uCu6bPH@vostro.rjw.lan> <20150218172651.GV8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56939 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752249AbbBRRmN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 12:42:13 -0500
In-Reply-To: <20150218172651.GV8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wednesday, February 18, 2015 05:26:51 PM Russell King - ARM Linux wrote:
> On Wed, Feb 18, 2015 at 05:52:25PM +0100, Rafael J. Wysocki wrote:
> > Those drivers might have been developed on systems without direct control of
> > power domains where the conditions for the driver at the ->probe() time were
> > always the same.  With power domains, though, they may change depending on
> > what's going on with the other devices in the domain, for example.
> > 
> > So the question is how we can address that in the cleanest way possible.
> 
> Okay, going back to what was said earlier, we have three possibilities
> for drivers:
> 
> 1) A driver which makes no use of runtime PM and no use of PM domains.
> 2) A driver which makes no use of runtime PM but may have a PM domain
>    attached.
> 3) A driver which uses runtime PM, and assumes that the device was
>    initially suspended.  It calls pm_enable_device() optionally with
>    a preceding call to pm_runtime_set_suspended().
> 4) A driver which uses runtime PM, and calls pm_runtime_set_active()
>    followed by pm_enable_device().
> 
> What we want to end up with in the ideal situation is that drivers which
> fall into class:
> 
> 1 - may see their devices in any state; it is up to them to deal with
>     whatever state the device is initially in.
> 2 - should see their devices in a powered up state as they have no way
>     to inform that the device is active.
> 3 - should see their devices in a suspended state.
> 4 - should see their devices in a powered up state.
> 
> The problem here is that we have no way to know this prior to the drivers
> probe function being called.  Whatever we do at this point, it is not
> going to satisfy the requirements of everyone.
> 
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

I like this.

And I would add two new "pre_probe" and "post_probe" (what about "init"
and "remove"?) to struct dev_pm_domain for that.

The "pre_probe" ("init") thing would be useful for solving one more problem
related to PM domains I have elsewhere.  In that case I need to defer probing
one of the device in the domain until one of the other devices is registered.

Rafael


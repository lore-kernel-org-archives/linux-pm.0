From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 17:26:51 +0000
Message-ID: <20150218172651.GV8656@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.44L0.1502181007320.1245-100000@iolanthe.rowland.org>
 <1790876.GQ4uCu6bPH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:48879 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbbBRR1G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 12:27:06 -0500
Content-Disposition: inline
In-Reply-To: <1790876.GQ4uCu6bPH@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wed, Feb 18, 2015 at 05:52:25PM +0100, Rafael J. Wysocki wrote:
> Those drivers might have been developed on systems without direct control of
> power domains where the conditions for the driver at the ->probe() time were
> always the same.  With power domains, though, they may change depending on
> what's going on with the other devices in the domain, for example.
> 
> So the question is how we can address that in the cleanest way possible.

Okay, going back to what was said earlier, we have three possibilities
for drivers:

1) A driver which makes no use of runtime PM and no use of PM domains.
2) A driver which makes no use of runtime PM but may have a PM domain
   attached.
3) A driver which uses runtime PM, and assumes that the device was
   initially suspended.  It calls pm_enable_device() optionally with
   a preceding call to pm_runtime_set_suspended().
4) A driver which uses runtime PM, and calls pm_runtime_set_active()
   followed by pm_enable_device().

What we want to end up with in the ideal situation is that drivers which
fall into class:

1 - may see their devices in any state; it is up to them to deal with
    whatever state the device is initially in.
2 - should see their devices in a powered up state as they have no way
    to inform that the device is active.
3 - should see their devices in a suspended state.
4 - should see their devices in a powered up state.

The problem here is that we have no way to know this prior to the drivers
probe function being called.  Whatever we do at this point, it is not
going to satisfy the requirements of everyone.

So, let's take what we're currently doing on DT, and make it the same
across the board.  In platform_drv_probe(), let's do this:

	/* attach the domain */
        ret = dev_pm_domain_attach(_dev, true);
	if (ret == -EPROBE_DEFER)
		goto defer;

	/* power up the domain - and hold it powered up */
	ret = dev_pm_domain_pre_probe(_dev);
	if (ret != -ENOSYS)
		goto error;

	ret = drv->probe(dev);

	/*
	 * remove the "hold" on the domain by this device, and start
	 * tracking its runtime PM status.
	 */
	dev_pm_domain_post_probe(_dev);

	if (ret)
		dev_pm_domain_detach(_dev, true);

What this means is that while the probe function is running, we guarantee
that the PM domain will always be powered up.  We also guarantee that
after the probe function has returned, we will then start tracking the
runtime PM state, and if the device driver leaves runtime PM in the
"suspended" state, PM domains will get to hear about it at that point,
and can transition the PM domain back to "off" mode.

Both these transitions only cause the PM domain to be affected; no
runtime PM callbacks are issued for either of these two changes.  (We
already have that for the initial state right now where attaching a
device to the PM domain causes the PM domain to be powered up.)

This is merely an extension of the current scheme.  Think of
dev_pm_domain_post_probe() as a method of synchronising the state of
PM domains with the state of runtime PM across all attached devices.


Aside:
I need to do some further checks; while considering this, I think I've
come across a worrying problem with "PM / Domains: Power on the PM domain
right after attach completes".  I think this will result in the driver's
runtime_resume callback being invoked _before_ the probe function.  I
can't test this right now as I'm in the middle of upgrading my dev box
and it doesn't have a functional install for building ARM kernels yet.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

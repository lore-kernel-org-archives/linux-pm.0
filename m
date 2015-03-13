From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/9] pm: domains: sync runtime PM status with PM domains
 after probe
Date: Fri, 13 Mar 2015 13:39:36 +0000
Message-ID: <20150313133936.GL8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7sv-0003mA-JP@rmk-PC.arm.linux.org.uk>
 <CAPDyKFrcjfLXCjLL8SGJUDz6ErROW=B8oDEg0eRPA92=m-dRQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43043 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbCMNjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 09:39:52 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrcjfLXCjLL8SGJUDz6ErROW=B8oDEg0eRPA92=m-dRQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Fri, Mar 13, 2015 at 10:30:59AM +0100, Ulf Hansson wrote:
> On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > Synchronise the PM domain status with runtime PM's status after a
> > platform device has been probed.  This augments the solution in commit
> > 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach
> > completes").
> >
> > The above commit added a call to power up the PM domain when a device
> > attaches to the domain in order to match the behaviour required by
> > drivers that make no use of runtime PM.  The assumption is that the
> > device driver will cause a runtime PM transition, which will synchronise
> > the PM domain state with the runtime PM state.
> >
> > However, by default, runtime PM will assume that the device is initially
> > suspended, and some drivers may make use of this should they not need to
> > touch the hardware during probe.
> >
> > In order to allow such drivers, trigger the PM domain code to check
> > whether the PM domain can be suspended after the probe function, undoing
> > the effect of the power-on prior to the probe.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/base/platform.c     |  2 ++
> 
> Don't we need this for more buses than the platform bus?

It's worth noting that I won't be fixing SDIO:

        sdio_acpi_set_handle(func);
        ret = device_add(&func->dev);
        if (ret == 0) {
                sdio_func_set_present(func);
                dev_pm_domain_attach(&func->dev, false);
        }

which is inherently racy - the driver can be probed in device_add().
What happened to "setup stuff, then publish"...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

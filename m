From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH] sbs-battery: add option to always register battery
Date: Wed, 3 Jun 2015 16:10:35 +0200
Message-ID: <20150603141035.GO9880@ci00147.xsens-tech.local>
References: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
 <20150603135750.GB18181@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:56144 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbFCOLB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 10:11:01 -0400
Content-Disposition: inline
In-Reply-To: <20150603135750.GB18181@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 03, 2015 at 03:57:51PM +0200, Sebastian Reichel wrote:
> Hi Frans,
> 
> On Tue, Jun 02, 2015 at 03:14:43PM +0200, Frans Klaver wrote:
> > Commit a22b41a31e53 ("sbs-battery: Probe should try talking to the
> > device") introduced a step in probing the SBS battery, that tries to
> > talk to the device before actually registering it, saying:
> > 
> >     this driver doesn't actually try talking to the device at probe
> >     time, so if it's incorrectly configured in the device tree or
> >     platform data (or if the battery has been removed from the system),
> >     then probe will succeed and every access will sit there and time
> >     out. The end result is a possibly laggy system that thinks it has a
> >     battery but can never read status, which isn't very useful.
> > 
> > Which is of course reasonable. However, it is also very well possible
> > for a device to boot up on wall-power and be connected to a battery
> > later on. The current advice in this situation is to probe the device
> > from userspace if you expect the battery to come on at some point in the
> > future. The downside of this approach is that userspace needs to be
> > aware of the backend of its powersupply, which is inconvenient and going
> > against the point of hardware abstraction.
> > 
> > In some of these cases you do want to register a battery, even if none
> > are attached at the moment. To facilitate this, add a configuration
> > option to try to talk to the device, defaulting to y, thus keeping the
> > current behavior. If unset, the battery will always be registered
> > without checking the sanity of the connection.
> > 
> > Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> > ---
> > If there's a better place to arrange for this all to happen, or to make this
> > more common across power supplies, I'm perfectly happy to do that work instead.
> > For now this seems like the logical step to take, especially since using device
> > tree was (sensibly) shot down last september [0].
> 
> While I still think, that the HW design is bad,

I'm still interested in learning how we could improve the HW design in
your opinion. Would you say we should be using a non-removable battery?


> I'm basically fine
> with this change based upon your comments. I think it's better to
> make this into a module parameter, though, since that moves the
> decision about this feature from compilation time to module load
> time. This will make it possible to use a generic kernel on your
> device. Maybe something like this could be used:
> 
> module_param(force_load, bool, 0444);
> MODULE_PARM_DESC(force_load,
> 		 "Attempts to load the driver even if the "
> 		 "battery is not connected");

That makes sense. We can work with that.

Thanks,
Frans

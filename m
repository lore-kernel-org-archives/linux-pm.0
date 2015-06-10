From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH v3] sbs-battery: add option to always register battery
Date: Wed, 10 Jun 2015 16:57:42 +0200
Message-ID: <20150610145741.GA23387@ci00147.xsens_som155.lan>
References: <1433938616-18503-1-git-send-email-frans.klaver@xsens.com>
 <20150610145205.GE11618@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:55936 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933051AbbFJO57 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 10:57:59 -0400
Content-Disposition: inline
In-Reply-To: <20150610145205.GE11618@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 10, 2015 at 04:52:05PM +0200, Sebastian Reichel wrote:
> Hi Frans,
> 
> On Wed, Jun 10, 2015 at 02:16:56PM +0200, Frans Klaver wrote:
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
> > later on. This is a scenario that the driver supported before said patch
> > was applied, and even easily achieved by booting up with the battery
> > attached and removing it later on. sbs-battery's 'present' sysfs file
> > can be used to determine if the device is available or not.
> > 
> > So with automated device detection lacking for now, in some cases it is
> > possible that one wants to register a battery, even if none are attached
> > at the moment. To facilitate this, add a module parameter that can be
> > used to configure forced loading module loading time. If set, the battery
> > will always be registered without checking the sanity of the connection.
> 
> Thanks, queued.

Thanks.

> Please make sure to send patches based upon the correct branches
> though. Your branch did not yet contain 297d716.

Ouch, sorry about that.

Thanks,
Frans

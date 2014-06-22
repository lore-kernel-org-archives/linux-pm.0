From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] PM / Runtime: let rpm_resume fail if rpm disabled and device suspended.
Date: Sun, 22 Jun 2014 15:24:13 +0200
Message-ID: <14478118.lYVMpnPKI2@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1406201043420.1160-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58004 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751883AbaFVNGc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jun 2014 09:06:32 -0400
In-Reply-To: <Pine.LNX.4.44L0.1406201043420.1160-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@linaro.org>, Allen Yu <alleny@nvidia.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, June 20, 2014 10:48:09 AM Alan Stern wrote:
> On Fri, 20 Jun 2014, Rafael J. Wysocki wrote:
> 
> > > For a general device, the fact that dev->power.is_suspended is set
> > > means the device _has_ been powered down.  Even though the
> > > runtime_status may not have changed, the PM core has to assume the
> > > device is not available for use.
> > 
> > This seems to go a bit too far.  What power.is_suspended actually means is
> > that __device_suspend() has run for the device successfully.  What the
> > implications of that are depends on the bus type (or subsystem in general)
> > and device driver.
> > 
> > > While your I2C devices may be useable even after the ->suspend callback
> > > returns, for most devices this isn't true.  So we shouldn't allow
> > > rpm_resume() to return imediately when is_suspended is set.
> > 
> > I can agree with that.
> 
> We really do need to decide more precisely how runtime PM and system PM 
> will interact.  Should ->runtime_resume callbacks be allowed after 
> ->suspend has returned?
> 
> Kevin has stated that some devices do need this ability.  But most
> don't.  The PM core needs to handle these conflicting requirements
> somehow.

I agree.

I guess we'll have to introduce a separate opt-in flag for drivers with this
specific need.  At least I don't see any other way to take that into account.

> Note: this is a separate issue from the meaning of disabled_depth > 0.

Yes, it is.

Rafael


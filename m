From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 2/4] usb: introduce usb force power off mechanism
Date: Mon, 8 Apr 2013 10:55:19 -0700
Message-ID: <20130408175519.GH6117@xanatos>
References: <20130408160144.GA12665@kroah.com>
 <Pine.LNX.4.44L0.1304081229100.1529-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44633 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762491Ab3DHRzT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Apr 2013 13:55:19 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1304081229100.1529-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lenb@kernel.org, kristen.c.accardi@intel.com

Cc-ing the linux-pm list and some Intel power devs, as I think this
specific discussion could benefit from a broader audience.

On Mon, Apr 08, 2013 at 12:33:00PM -0400, Alan Stern wrote:
> On Mon, 8 Apr 2013, Greg KH wrote:
> 
> > On Mon, Apr 08, 2013 at 08:57:43AM -0700, Sarah Sharp wrote:
> > > On Mon, Apr 08, 2013 at 06:29:36AM -0700, Greg KH wrote:
> > > > On Mon, Apr 08, 2013 at 08:58:09PM +0800, Lan Tianyu wrote:
> > > > > On 2013/3/30 4:24, Alan Stern wrote:
> > > > > >On Fri, 29 Mar 2013, Sarah Sharp wrote:
> > > > > Hi Alan & Sarah:
> > > > > 	I just recall why I put power off and power on in one ioctl.
> > > > > At first, I also tried to make power on and power off into two ioctls.
> > > > > But I found after powering off a device, the usbfs device node will
> > > > > be removed and so can't power on the port via the same usbfs node.
> > > > > 
> > > > > For this point, we should add usbfs node for usb port?
> > > > 
> > > > No.
> > > 
> > > I agree that we shouldn't add more usbfs files without thinking very
> > > carefully about it, since lots of tools like libusb use them.  However,
> > > we do need a way to manually power off a port, wait a variable length of
> > > time (or perhaps for a distro-specific event like screen unblank), and
> > > turn the port on.
> > > 
> > > So how do we turn the port power back on with the options we have?
> > > Would userspace have to turn the port power off via usbfs, and then
> > > manually back on by setting the port's sysfs power/control to 'on'?
> > 
> > Whatever method we use, it should be the same interface for both on
> > and off, so I would prefer to just use the sysfs one, as usbfs does not
> > represent ports, only USB devices.
> 
> There is a way we can do it using the existing usbfs framework.  The
> new ioctls could be sent to the parent hub, instead of the device
> attached to the port.  Rather like USBDEVFS_CLAIM_PORT and
> USBDEVFS_RELEASE_PORT.

That could work.  However, we have to think about future platform power
changes as well.  Coming up with a USB specific way to work around the
runtime PM core will hurt us in the long run, if we end up having to
change the runtime PM core for another kernel user.

Len, Rafael, and Kristen, is there a need from any of the future power
work to have an 'off' mechanism added to the runtime PM core, so that
power/control would have 'on', 'auto', and 'off' options?  It currently
only has 'on' and 'auto'.

The kernel is always going to be more conservative about what policies
cause the 'auto' option to turn off USB ports.  A Linux distro may want
to override those policies and force the port off, or power off a
misbehaving device for a hard reset.  That's why we need an 'off'
extension to power/control to bypass the runtime PM usage counts and
power something off.

Are there analogous needs for other users of power/control?

Sarah Sharp

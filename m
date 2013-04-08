From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/4] usb: introduce usb force power off mechanism
Date: Mon, 08 Apr 2013 21:32:01 +0200
Message-ID: <1770111.9r7BqGUQad@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1303291617280.1467-100000@iolanthe.rowland.org> <20130408160144.GA12665@kroah.com> <20130408173354.GG6117@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54392 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763113Ab3DHTYS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Apr 2013 15:24:18 -0400
In-Reply-To: <20130408173354.GG6117@xanatos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, April 08, 2013 10:33:54 AM Sarah Sharp wrote:
> On Mon, Apr 08, 2013 at 09:01:44AM -0700, Greg KH wrote:
> > On Mon, Apr 08, 2013 at 08:57:43AM -0700, Sarah Sharp wrote:
> > > On Mon, Apr 08, 2013 at 06:29:36AM -0700, Greg KH wrote:
> > > > On Mon, Apr 08, 2013 at 08:58:09PM +0800, Lan Tianyu wrote:
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
> I would prefer that as well.  However, the port power sysfs file
> power/control is created by the runtime PM core, and I think it doesn't
> have a way to manually turn power off.  All we get with the current
> framework is 'on' or 'auto'.  There may be times when userspace wants to
> override the kernel's policy for 'auto' and force a port power off.
> 
> Perhaps the runtime PM core needs to be extended to have a way to allow
> userspace to manually force a device into a lower power state?

We actually considered that when the PM core's runtime PM framework was
being implemented and the answer was "no".  The reason being that user space
has no idea whether or not the device *can* be turned off at the given
time, so the kernel can't guarantee any requests to turn devices off to be
satisfied at any given time.  I believe this is the case for USB ports too.

I don't think anything has changed in that respect since then.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: introduce usb force power off mechanism
Date: Mon, 8 Apr 2013 10:33:54 -0700
Message-ID: <20130408173354.GG6117@xanatos>
References: <Pine.LNX.4.44L0.1303291617280.1467-100000@iolanthe.rowland.org>
 <5162BEE1.5060404@intel.com>
 <20130408132936.GB10940@kroah.com>
 <20130408155743.GE6117@xanatos>
 <20130408160144.GA12665@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130408160144.GA12665-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 08, 2013 at 09:01:44AM -0700, Greg KH wrote:
> On Mon, Apr 08, 2013 at 08:57:43AM -0700, Sarah Sharp wrote:
> > On Mon, Apr 08, 2013 at 06:29:36AM -0700, Greg KH wrote:
> > > On Mon, Apr 08, 2013 at 08:58:09PM +0800, Lan Tianyu wrote:
> > > > Hi Alan & Sarah:
> > > > 	I just recall why I put power off and power on in one ioctl.
> > > > At first, I also tried to make power on and power off into two ioctls.
> > > > But I found after powering off a device, the usbfs device node will
> > > > be removed and so can't power on the port via the same usbfs node.
> > > > 
> > > > For this point, we should add usbfs node for usb port?
> > > 
> > > No.
> > 
> > I agree that we shouldn't add more usbfs files without thinking very
> > carefully about it, since lots of tools like libusb use them.  However,
> > we do need a way to manually power off a port, wait a variable length of
> > time (or perhaps for a distro-specific event like screen unblank), and
> > turn the port on.
> > 
> > So how do we turn the port power back on with the options we have?
> > Would userspace have to turn the port power off via usbfs, and then
> > manually back on by setting the port's sysfs power/control to 'on'?
> 
> Whatever method we use, it should be the same interface for both on
> and off, so I would prefer to just use the sysfs one, as usbfs does not
> represent ports, only USB devices.

I would prefer that as well.  However, the port power sysfs file
power/control is created by the runtime PM core, and I think it doesn't
have a way to manually turn power off.  All we get with the current
framework is 'on' or 'auto'.  There may be times when userspace wants to
override the kernel's policy for 'auto' and force a port power off.

Perhaps the runtime PM core needs to be extended to have a way to allow
userspace to manually force a device into a lower power state?

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

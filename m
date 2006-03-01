From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/4] Fix runtime device suspend/resumre interface
Date: Tue, 28 Feb 2006 16:38:10 -0800
Message-ID: <20060301003810.GI23716@kroah.com>
References: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net> <20060221174950.GA23054@kroah.com> <Pine.LNX.4.50.0602271111101.28882-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932635AbWCAAiF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602271111101.28882-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 27, 2006 at 11:18:43AM -0800, Patrick Mochel wrote:
> 
> On Tue, 21 Feb 2006, Greg KH wrote:
> 
> > On Mon, Feb 20, 2006 at 04:55:34PM -0800, Patrick Mochel wrote:
> > >
> > > Hi there,
> > >
> > > Here is an updated version of the patches to fix the sysfs interface for
> > > runtime device power management by restoring the file to its originally
> > > designed behavior - to place devices in the power state specified by the
> > > user process writing to the file.
> > >
> > > Recently, the interface was changed to filter out values to prevent a
> > > BUG() that was introduced in the PCI power management code. While a valid
> > > fix, it makes the driver core filter values that might otherwise be used
> > > by the bus/device drivers.
> >
> > Are there any existing bus/device drivers that are currently broken
> > because of this change?
> 
> It's difficult to tell. There are several devices that support multiple
> PCI power states, and several drivers that will attempt to put the device
> into whatever state is passed to their ->suspend() method. But, there are
> not many that handle D1 or D2 specially.
> 
> The point of the patches was to restore the functionality of the sysfs
> file to its documented interface, which had been that way since the file
> was created (early in 2.6). In the last year, since the conversion to the
> pm_message_t in driver suspend methods, it is not behaved as it was
> advertised to do.
> 
> One solution is to prohibit any suspend/resume commands besides "on" and
> "off", and to change the documented semantics of the file. But, it seems
> much more useful to enable the use of the intermediate states, so long as
> it doesn't do any serious harm. Put another way, it doesn't seem to make
> sense to intentionally prevent the use of intermediate power states.
> 
> What is also a bit wonky is the handling of those intermediate power
> states now. If someone has a PCI device that advertises D1/D2 support, and
> he/she knows the driver supports it (or is writing the driver support for
> it), a write of "1" or "2" to the device's state file is not going to
> provide the type of behavior that one would expect..
> 
> Does that help at all?

Hm, no.  As nothing can be proven to be broken right now, it's way too
late to get any change like this into 2.6.16-final.  Especially as your
patch series broke Andrew's laptop :)

If you want to respin them once that problem is fixed, I'd be glad to
take them for 2.6.17, as long as we can get some agreement here on the
interface.

thanks,

greg k-h

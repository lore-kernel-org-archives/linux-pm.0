From: Greg KH <greg@kroah.com>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Fri, 27 Apr 2007 14:46:48 -0700
Message-ID: <20070427214648.GB23282@kroah.com>
References: <Pine.LNX.4.44L0.0704271004090.3430-100000@iolanthe.rowland.org>
	<1177709159.4737.150.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177709159.4737.150.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: linux-pm@lists.osdl.org, Pekka J Enberg <penberg@cs.helsinki.fi>, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 28, 2007 at 07:25:59AM +1000, Nigel Cunningham wrote:
> Hi Alan.
> 
> On Fri, 2007-04-27 at 10:08 -0400, Alan Stern wrote:
> > On Fri, 27 Apr 2007, Pekka J Enberg wrote:
> > 
> > > From: Nigel Cunningham <nigel@nigel.suspend2.net>
> > > 
> > > Add power management related debugging into driver core. Make the
> > > kernel complain if a device driver lacks bus and class support for
> > > resume or if a PCI or USB driver does not have a driver specific
> > > resume function.
> > 
> > > Index: 2.6/drivers/usb/core/driver.c
> > > ===================================================================
> > > --- 2.6.orig/drivers/usb/core/driver.c	2007-04-27 14:42:13.000000000 +0300
> > > +++ 2.6/drivers/usb/core/driver.c	2007-04-27 14:43:14.000000000 +0300
> > > @@ -721,6 +721,12 @@ 	int retval = 0;
> > >  		pr_info("%s: registered new device driver %s\n",
> > >  			usbcore_name, new_udriver->name);
> > >  		usbfs_update_special();
> > > +#ifdef CONFIG_PM
> > > +		if (!new_udriver->resume)
> > > +			printk(KERN_WARNING "USB driver %s lacks driver "
> > > +					    "specific resume support.\n",
> > > +					    new_udriver->name);
> > > +#endif
> > >  	} else {
> > >  		printk(KERN_ERR "%s: error %d registering device "
> > >  			"	driver %s\n",
> > 
> > This part seems unnecessary.  There is only one USB device driver, it is
> > built into the USB core, and it does have the appropriate methods.  
> > Checking isn't needed.
> 
> Sorry. I thought you were wrong for a minute, but then I looked again at
> the messages in my dmesg...
> 
> [   33.944214] Device driver usbdev1.1_ep00 lacks bus and class support for being resumed.
> [   34.051765] Device driver usbdev1.1_ep81 lacks bus and class support for being resumed.
> [   34.113740] Device driver usbdev2.1_ep00 lacks bus and class support for being resumed.
> [   34.221541] Device driver usbdev2.1_ep81 lacks bus and class support for being resumed.
> [   34.251562] Device driver usbdev3.1_ep00 lacks bus and class support for being resumed.
> [   34.361345] Device driver usbdev3.1_ep81 lacks bus and class support for being resumed.

Those are usb endpoints and have NOTHING to do with suspend right now,
so the check is bogus.

> > On the other hand, the drivers' maintainers are probably quite aware of 
> > the missing PM support, so it's not clear that printing out warning 
> > messages will actually help anybody.
> 
> It can help the user, when they're looking for possibilities as to why things aren't working.

You will drown out the valid issues with invalid ones, like the above...

greg k-h

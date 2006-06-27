From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] get USB suspend to work again on
	2.6.17-mm1
Date: Tue, 27 Jun 2006 16:28:58 -0700
Message-ID: <20060627232858.GF15225@kroah.com>
References: <200606261904.06102.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0606271121390.20671-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606271121390.20671-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>, pavel@suse.cz, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 27, 2006 at 11:24:50AM -0400, Alan Stern wrote:
> On Mon, 26 Jun 2006, David Brownell wrote:
> 
> > On Monday 26 June 2006 4:57 pm, Greg KH wrote:
> > > On Fri, Jun 23, 2006 at 10:51:47AM -0400, Alan Stern wrote:
> > > > On Thu, 22 Jun 2006, Greg KH wrote:
> > > > 
> > > > > > Under what scenario could it possibly be legitimate to suspend a
> > > > > > usb device -- or interface, or anything else -- with its children
> > > > > > remaining active?  The ability to guarantee that could _never_ happen
> > > > > > was one of the fundamental motivations for the driver model ...
> > > > > 
> > > > > I'm not disagreeing with that.  It's just that you are looping all
> > > > > struct devices that are attached to a struct usb_device and assuming
> > > > > that they are all of type struct usb_interface. ...
> > > > 
> > > > In fact the code doesn't make that assumption.  It only assumes that the 
> > > > dev->power.power_state.event field is set correctly ...
> > > 
> > > Yes, but it's looking at devices it should _not_ care about.  The USB
> > > core should only care about devices it controls, not other devices in
> > > the device chain.  Those are for the driver core to handle.
> > 
> > The basic problem is that the driver core does ** NOT ** maintain such
> > integrity constraints.  So it's unsafe to remove those checks for cases
> > (like USB) where devices get suspended outside transition to "system sleep"
> > states like "standby", "suspend-to-ram", and "suspend-to-disk". [1]
> > 
> > Go back to my original question:  is there a legitimate scenario where
> > that test should fail?  Nobody has come up with even one ...
> > 
> > 
> > Even so-called "virtual" devices (talking to abstracted hardware) need to
> > quiesce.  And as Adam has pointed out separately, often most of the work to
> > quiesce drivers should be at such a "virtual" level.  Most of the time when
> > a driver for a "physical" device (touches real registers) does complicated
> > work to quiesce, it's because the next level in the driver stack didn't
> > create a "virtual" device to package that logic.  As with "eth0".
> 
> An easy way around the problem is to create simple suspend/resume methods 
> for the endpoint devices.  They don't have to do anything other than set 
> dev->power.power_state.event.  Not until these "endpoint devices" start 
> implementing some real functionality.

No.  Are we going to require that we do that for _every_ type of device
that might possibly hang off of a USB device?  Again, that's a
constraint the driver model currently does not impose on the rest of the
tree, so we should not have the USB core try to impose it on parts that
happen to hook up to it.

thanks,

greg k-h

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

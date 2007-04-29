From: Greg KH <greg@kroah.com>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Sun, 29 Apr 2007 00:50:12 -0700
Message-ID: <20070429075012.GA14030@kroah.com>
References: <Pine.LNX.4.44L0.0704281035530.31211-100000@netrider.rowland.org>
	<1177800952.7652.4.camel@nigel.suspend2.net>
	<20070429065051.GA31628@kroah.com>
	<1177832831.7652.12.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177832831.7652.12.camel@nigel.suspend2.net>
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

On Sun, Apr 29, 2007 at 05:47:11PM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2007-04-28 at 23:50 -0700, Greg KH wrote:
> > On Sun, Apr 29, 2007 at 08:55:52AM +1000, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Sat, 2007-04-28 at 10:42 -0400, Alan Stern wrote:
> > > > On Sat, 28 Apr 2007, Nigel Cunningham wrote:
> > > > 
> > > > > Hi Alan.
> > > > 
> > > > > Sorry. I thought you were wrong for a minute, but then I looked again at
> > > > > the messages in my dmesg...
> > > > > 
> > > > > [   33.944214] Device driver usbdev1.1_ep00 lacks bus and class support for being resumed.
> > > > > [   34.051765] Device driver usbdev1.1_ep81 lacks bus and class support for being resumed.
> > > > > [   34.113740] Device driver usbdev2.1_ep00 lacks bus and class support for being resumed.
> > > > > [   34.221541] Device driver usbdev2.1_ep81 lacks bus and class support for being resumed.
> > > > > [   34.251562] Device driver usbdev3.1_ep00 lacks bus and class support for being resumed.
> > > > > [   34.361345] Device driver usbdev3.1_ep81 lacks bus and class support for being resumed.
> > > > > 
> > > > > They're coming from the other printk, of course.
> > > > > 
> > > > > > Now perhaps you would prefer to check the USB interface drivers -- there 
> > > > > > are many of them, and quite a few don't have suspend or resume methods.  
> > > > > > You would need to modify usb_register_driver() instead of 
> > > > > > usb_register_device_driver().
> > > > > 
> > > > > Would they be the ones covered above?
> > > > 
> > > > No.  As Greg pointed out, these usbdevXX_epYY "devices" are nothing but 
> > > > placeholders at the moment.  They don't actually do anything and they have 
> > > > no need for power management.  (But they do manage to clutter up the 
> > > > system log with lots of extraneous warnings from the PM core...)
> > > 
> > > Ok, so they could have the pm_safe flag set to suppress the message.
> > 
> > No, we don't want a flag just to shut up a message, that's the first
> > thing a developer will do when they see that message, without realizing
> > what exactly they should be doing instead.
> > 
> > Trust me, I know the lengths kernel developers go to to try to work
> > around "helpful hints" that the kernel can spit out at you :(
> 
> Ok, then. So... what would you suggest (if anything)?

As your check was for something that wasn't really correct at all, I
suggest just dropping the patch :)

thanks,

greg k-h

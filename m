From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC/PATCH 2/2] driver core: power management debugging
Date: Sat, 28 Apr 2007 10:42:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704281035530.31211-100000@netrider.rowland.org>
References: <1177709159.4737.150.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Sat, 28 Apr 2007, Nigel Cunningham wrote:

> Hi Alan.

> Sorry. I thought you were wrong for a minute, but then I looked again at
> the messages in my dmesg...
> 
> [   33.944214] Device driver usbdev1.1_ep00 lacks bus and class support for being resumed.
> [   34.051765] Device driver usbdev1.1_ep81 lacks bus and class support for being resumed.
> [   34.113740] Device driver usbdev2.1_ep00 lacks bus and class support for being resumed.
> [   34.221541] Device driver usbdev2.1_ep81 lacks bus and class support for being resumed.
> [   34.251562] Device driver usbdev3.1_ep00 lacks bus and class support for being resumed.
> [   34.361345] Device driver usbdev3.1_ep81 lacks bus and class support for being resumed.
> 
> They're coming from the other printk, of course.
> 
> > Now perhaps you would prefer to check the USB interface drivers -- there 
> > are many of them, and quite a few don't have suspend or resume methods.  
> > You would need to modify usb_register_driver() instead of 
> > usb_register_device_driver().
> 
> Would they be the ones covered above?

No.  As Greg pointed out, these usbdevXX_epYY "devices" are nothing but 
placeholders at the moment.  They don't actually do anything and they have 
no need for power management.  (But they do manage to clutter up the 
system log with lots of extraneous warnings from the PM core...)

> > On the other hand, the drivers' maintainers are probably quite aware of 
> > the missing PM support, so it's not clear that printing out warning 
> > messages will actually help anybody.
> 
> It can help the user, when they're looking for possibilities as to why things aren't working.

Maybe.  But the warnings will occur when the driver is registered, which 
is often long before the problem shows up.  The user may not make the 
connection.


On a completely different topic: Nigel, now's your big chance!  If you 
hurry, you can rename Suspend2 to Hibernate -- beating out Pavel, who will 
then be forced to rename swsusp to Hibernate2!  :-)

Alan Stern

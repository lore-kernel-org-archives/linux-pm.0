From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not
 device_suspend()
Date: Thu, 27 Apr 2006 13:41:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604271337570.6040-100000@iolanthe.rowland.org>
References: <20060427165536.GA3113@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060427165536.GA3113@linux.intel.com>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Patrick Mochel <mochel@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Apr 2006, Patrick Mochel wrote:

> > According to David this shouldn't matter.  During swsusp the system is
> > supposed to be completely off, with no suspend power available.  Hence all
> > the power sessions are guaranteed to be interrupted, and the boot kernel
> > doesn't have to worry about destroying any of them.
> 
> Not necessarily. x86 hardware implementations of suspend-to-disk retain some 
> power during suspend. Not many (if any) devices will retain context, but the
> system is definitely not completely "off". Actually, the same is true for
> soft-off on x86 (aka ACPI S5). Some power may be drawn to support various power
> on events. The only time a system is truly off is when it is unplugged from
> the wall (and/or the battery taken out, if applicable). 
> 
> I don't think it matters much in this particular context, but it's important
> to keep in mind when making assumptions about "off-ness".

I'm perfectly happy to let you duke this out with David!  :-)

Either way, there is one important observation: You can't use swsusp if 
your root filesystem is on a USB disk.  Not until some sort of persistent 
storage manager is available...

Alan Stern



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

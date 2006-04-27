From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Thu, 27 Apr 2006 09:55:36 -0700
Message-ID: <20060427165536.GA3113@linux.intel.com>
References: <20060427080826.GB2376@ucw.cz> <Pine.LNX.4.44L0.0604271032390.5192-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0604271032390.5192-100000@iolanthe.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 27, 2006 at 10:34:16AM -0400, Alan Stern wrote:
> On Thu, 27 Apr 2006, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > The right way to solve this is to make sure that the resuming kernel can
> > > correctly determine whether the power session (way back from the original
> > > sw-suspend) is still intact.  It's expected that in many cases it won't
> > > be, because most systems won't provide suspend current while the machine
> > > is off.  We have to guarantee that the boot kernel's actions won't end up
> > > fooling the resuming kernel into thinking that the power sessions are
> > > intact when in fact they aren't.  (Furthermore, in an ideal world, we
> > > would also make sure that the boot kernel won't destroy any power sessions
> > > that still _are_ intact.  Right now we have no way to do this, because the
> > > drivers in the boot kernel don't know that it _is_ a boot kernel.)
> > 
> > You don't know if it is boot or resume until you read the disk, sorry.
> 
> According to David this shouldn't matter.  During swsusp the system is
> supposed to be completely off, with no suspend power available.  Hence all
> the power sessions are guaranteed to be interrupted, and the boot kernel
> doesn't have to worry about destroying any of them.

Not necessarily. x86 hardware implementations of suspend-to-disk retain some 
power during suspend. Not many (if any) devices will retain context, but the
system is definitely not completely "off". Actually, the same is true for
soft-off on x86 (aka ACPI S5). Some power may be drawn to support various power
on events. The only time a system is truly off is when it is unplugged from
the wall (and/or the battery taken out, if applicable). 

I don't think it matters much in this particular context, but it's important
to keep in mind when making assumptions about "off-ness".

Thanks,


	Patrick


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

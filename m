From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Thu, 27 Apr 2006 12:21:45 -0700
Message-ID: <200604271221.47160.david-b@pacbell.net>
References: <20060427080826.GB2376@ucw.cz> <Pine.LNX.4.44L0.0604271032390.5192-100000@iolanthe.rowland.org> <20060427165536.GA3113@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060427165536.GA3113@linux.intel.com>
Content-Disposition: inline
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
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thursday 27 April 2006 9:55 am, Patrick Mochel wrote:
> On Thu, Apr 27, 2006 at 10:34:16AM -0400, Alan Stern wrote:
> > 
> > 		During swsusp the system is
> > supposed to be completely off, with no suspend power available.  Hence all
> > the power sessions are guaranteed to be interrupted, and the boot kernel
> > doesn't have to worry about destroying any of them.
> 
> Not necessarily. x86 hardware implementations of suspend-to-disk retain some 
> power during suspend. Not many (if any) devices will retain context, but the
> system is definitely not completely "off".

As a rule swsusp (or firmware suspend-to-disk) power off everything except
what's needed to power up the motherboard ... or to provide "5 AM wakeup"
type events using a battery-backed realtime clock.  Maintaining VBUS power
sessions from USB host controllers is one of those "theoretically allowed,
but never observed in the wild" cases.

Right, not "completely" off ... but certainly nowhere as close to "on" as
would be true of suspend-to-RAM.  And regardless, the problem in $SUBJECT is
when Linux trashes the state which the limited "on" is there to maintain.

- Dave



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

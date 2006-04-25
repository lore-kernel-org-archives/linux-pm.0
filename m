From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Tue, 25 Apr 2006 08:49:19 -0700
Message-ID: <200604250849.19946.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0604250947260.5330-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0604250947260.5330-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 April 2006 6:50 am, Alan Stern wrote:
> 
> We might have been able to avoid some of these problems with USB devices
> if we had been a bit more careful.  In particular, it wouldn't hurt to
> have usb_resume_device() verify that the upstream port is enabled and not
> suspended in the non-CONFIG_USB_SUSPEND case.

Nope ... remember, the USB device enumerated from scratch both times.
Identically, reproducibly.  So the first device will again be given
address 2, and will even pass the "is it still there" sanity check in
finish_device_resume().  (I was testing with USB_SUSPEND of course.)

But that device wasn't in the _right_ suspend state, the one in which
it had been left before swsusp turned the power off.  Only the low level
setup had been (could have been) done -- USB enumeration, that's all.

The reason such devices can't work after this fakey "resume" is that
the system (specifically swsusp) is lying about things.  It brought
all the hardware part way up, obliterating all the true state that
drivers rely on to make resume() behave correctly.

Making swsusp do like kexec -- resetting the devices that need it -- is
just making that PM code stop its lies.

HCDs (and similar drivers) can handle it OK if there was a power loss
after suspend().  By calling device_suspend() not device_shutdown(),
swsusp is going out of its way to prevent drivers from knowing .

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

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not
 device_suspend()
Date: Wed, 26 Apr 2006 11:38:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604261132340.5361-100000@iolanthe.rowland.org>
References: <200604261726.17799.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <200604261726.17799.rjw@sisk.pl>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Apr 2006, Rafael J. Wysocki wrote:

> > So under these circumstances, how does it hurt anything to reset the 
> > resume device rather than to freeze it?
> 
> It just shouldn't be necessary.  Actually I think the resume device shouldn't
> be frozen too.

Well, you wouldn't want it doing DMA to unknown memory areas while you're
trying to place the image data in those same areas, would you?  And when
the image is reactivated, you wouldn't want the device generating
interrupt requests while its driver still thinks it is suspended.  (Or if 
it doesn't even have a driver in the image.)

And don't say that no resume device would ever do DMA or generate IRQs
while it was idle!  What if it was a remote disk accessible via a network 
interface?

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

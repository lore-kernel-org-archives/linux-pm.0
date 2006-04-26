From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Wed, 26 Apr 2006 17:26:16 +0200
Message-ID: <200604261726.17799.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0604261032500.5283-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0604261032500.5283-100000@iolanthe.rowland.org>
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
Cc: David Brownell <david-b@pacbell.net>, Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 April 2006 16:38, Alan Stern wrote:
> On Wed, 26 Apr 2006, Rafael J. Wysocki wrote:
> 
> > > Now, if you have specific examples of things that shouldn't be reset, that
> > > could be interesting.
> > 
> > The resume device and friends (ie. controller, bus, etc.).
> 
> I presume the freeze/reset we're talking about occurs immediately after 
> the memory snapshot has been read from the swap partition and immediately 
> before it is installed/activated.  (If occurs before the snapshot is read 
> in, then how would you actually manage to read it?)
> 
> So under these circumstances, how does it hurt anything to reset the 
> resume device rather than to freeze it?

It just shouldn't be necessary.  Actually I think the resume device shouldn't
be frozen too.

> > My point is that it need not be _necessary_ to reset all devices.  We should
> > reset only those which need to be reset.
> 
> > Of course every driver should handle this but that's not the point.  The point
> > is whether we should _force_ the reset on every device.
> 
> I'm not convinced that it hurts anything.  But in any case, it wouldn't
> hurt to follow Pavel's advice and add a flags field to pm_message_t.

Exactly.

Greetings,
Rafael


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

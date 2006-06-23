From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] get USB suspend to work again on
	2.6.17-mm1
Date: Thu, 22 Jun 2006 22:45:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606222241390.18690-100000@netrider.rowland.org>
References: <20060622235112.GA30484@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060622235112.GA30484@kroah.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>, pavel@suse.cz, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006, Greg KH wrote:

> > And yes, we _should_ care about whether or not any interface is
> > still active, until the pm core code starts to pay attention to
> > the driver model tree at all times ... even outside of system-wide
> > suspend transitions.  Today, the pm core code doesn't even use
> > that tree directly, and all runtime state changes (like selective
> > suspend with USB) completely bypass that pm tree.
> 
> Hm, ok, yes, we should care about interfaces, but we need some way to
> only walk them, not anything else that might be attached to us...

In my upcoming patch set this test isn't needed at all, because suspending
a device automatically suspends all of its interfaces first.  I've already
submitted the first few revised patches in that set (not the part that
removes the test, though), but you've probably been too busy to look at
them yet.

Alan Stern


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

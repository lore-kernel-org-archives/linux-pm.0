From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] get USB suspend to work again on
	2.6.17-mm1
Date: Thu, 22 Jun 2006 16:51:12 -0700
Message-ID: <20060622235112.GA30484@kroah.com>
References: <20060622202952.GA14135@kroah.com>
	<200606221624.03182.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200606221624.03182.david-b@pacbell.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>, pavel@suse.cz, Alan Stern <stern@rowland.harvard.edu>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 22, 2006 at 04:24:02PM -0700, David Brownell wrote:
> On Thursday 22 June 2006 1:29 pm, Greg KH wrote:
> > 
> > David, we really should not be caring about what the children of a USB
> > device is doing here, as who knows what type of "device" might hang off
> > of a struct usb_device. 
> 
> Should be _only_ interfaces; everything else descends from an interface.

Not anymore, and who knows what might hang off a USB device in the
future.  We can't necessarily control our children like this, as some
other subsystem might want to use a usb_device as a parent, and there's
nothing wrong with that.

> There was previously an invariant that the interfaces were marked
> as quiescent unless the interface (a) had a driver, and (b) that
> driver was not suspended.  Evidently that has been lost.  This patch
> may be insufficient; ISTR other places relying on that invariant.
> 
> And yes, we _should_ care about whether or not any interface is
> still active, until the pm core code starts to pay attention to
> the driver model tree at all times ... even outside of system-wide
> suspend transitions.  Today, the pm core code doesn't even use
> that tree directly, and all runtime state changes (like selective
> suspend with USB) completely bypass that pm tree.

Hm, ok, yes, we should care about interfaces, but we need some way to
only walk them, not anything else that might be attached to us...

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

From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] get USB suspend to work again on
	2.6.17-mm1
Date: Thu, 22 Jun 2006 16:24:02 -0700
Message-ID: <200606221624.03182.david-b@pacbell.net>
References: <20060622202952.GA14135@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060622202952.GA14135@kroah.com>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>, pavel@suse.cz, Alan Stern <stern@rowland.harvard.edu>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 1:29 pm, Greg KH wrote:
> 
> David, we really should not be caring about what the children of a USB
> device is doing here, as who knows what type of "device" might hang off
> of a struct usb_device. 

Should be _only_ interfaces; everything else descends from an interface.

There was previously an invariant that the interfaces were marked
as quiescent unless the interface (a) had a driver, and (b) that
driver was not suspended.  Evidently that has been lost.  This patch
may be insufficient; ISTR other places relying on that invariant.

And yes, we _should_ care about whether or not any interface is
still active, until the pm core code starts to pay attention to
the driver model tree at all times ... even outside of system-wide
suspend transitions.  Today, the pm core code doesn't even use
that tree directly, and all runtime state changes (like selective
suspend with USB) completely bypass that pm tree.

- Dave



> --- gregkh-2.6.orig/drivers/usb/core/usb.c
> +++ gregkh-2.6/drivers/usb/core/usb.c
> @@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev
>  
>  static int verify_suspended(struct device *dev, void *unused)
>  {
> +	if (dev->driver == NULL)
> +		return 0;
>  	return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
>  }
>  
> 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

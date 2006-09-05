From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] USB device persistence across
	suspend-to-disk
Date: Tue, 5 Sep 2006 12:59:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org>
References: <20060905091318.42c273d2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060905091318.42c273d2.rdunlap@xenotime.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Sep 2006, Randy.Dunlap wrote:

> > +Setting the "persist=y" module parameter for usbcore will cause the
> 
>                 persist=1 ??

Either will work.

> > +kernel to work around these issues.  If usbcore is build into the
> 
> s/build/built/

Got it, thanks.

> > +main kernel instead of as a separate module, you can put
> > +"usbcore.persist=1" on the boot command line.  You can also change the
> > +kernel's behavior on the fly using sysfs: Type
> > +
> > +	echo y >/sys/module/usbcore/parameters/persist
> 
> Does sysfs treat 'y' as '1'?
> Anyway, it would be Good to be consistent.

Yes; I'll change everything to 'y'.

> > +structure.  In effect, the kernel treats the device as though it had
> > +merely been reset instead of unplugged.
> 
> so does the USB device also retain its same USB address?

It does.  It didn't seem worthwhile to mention that point, however.

> > -			dev->have_langid = -1;
> > +			dev->have_langid = 1;

> Different patch (?).

When this is submitted for inclusion, that change will be broken out into 
a separate patch.

Alan Stern


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

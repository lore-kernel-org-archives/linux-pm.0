From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC] USB device persistence
	across suspend-to-disk
Date: Wed, 6 Sep 2006 05:36:38 +0000
Message-ID: <20060906053637.GI7043@ucw.cz>
References: <20060905091318.42c273d2.rdunlap@xenotime.net>
	<Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609051252240.5763-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > +main kernel instead of as a separate module, you can put
> > > +"usbcore.persist=1" on the boot command line.  You can also change the
> > > +kernel's behavior on the fly using sysfs: Type
> > > +
> > > +	echo y >/sys/module/usbcore/parameters/persist
> > 
> > Does sysfs treat 'y' as '1'?
> > Anyway, it would be Good to be consistent.
> 
> Yes; I'll change everything to 'y'.

Actually I'd prefer 0/1... that's what other parts of kernel use IIRC.

Otherwise it looks good to me.
						Pavel
-- 
Thanks for all the (sleeping) penguins.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

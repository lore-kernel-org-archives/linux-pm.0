From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] get USB suspend to work again on
	2.6.17-mm1
Date: Tue, 27 Jun 2006 16:20:02 -0700
Message-ID: <20060627232002.GD15225@kroah.com>
References: <20060623042452.GA23232@kroah.com>
	<20060626235732.GE32008@kroah.com>
	<20060627090304.GA29199@elf.ucw.cz>
	<200606271038.40510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200606271038.40510.david-b@pacbell.net>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 27, 2006 at 10:38:39AM -0700, David Brownell wrote:
> > > > > And we also need to be able to handle devices in the device tree that do
> > > > > not have a suspend/resume function ...
> > > >
> > > > Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> > > > it because it doesn't need them, or is it because nobody has written them 
> > > > yet?  In the latter case, failing the suspend or unbinding the driver are 
> > > > the only safe courses.
> > > 
> > > No, if it's not there, just expect that it knows what it is doing, and
> > > don't fail the thing.  Unless you want to add those methods to _every_
> > > driver in the kernel, and that's going to be a lot of work...
> 
> It seems reasonable to me to require that drivers have at least
> stub "it's actually OK to do nothing here" suspend/resume methods.

No, the point is that these devices have no driver associated with them.
They are "class" devices, and as such, are virtual.

Hm, well, I guess I should go add the suspend callbacks to the class, as
Linus's core changes is going to be expecting that...

Anyway, for virtual devices, it often times makes no sense to have a
suspend function, and as such, they should not be required to provide a
null function...

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

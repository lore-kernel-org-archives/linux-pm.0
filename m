From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH,
	fix] Re: [Regression] 2.6.31-git: tty change broke resume from
	hibernation on MSI Wind U100
Date: Sun, 27 Sep 2009 20:16:04 +0200
Message-ID: <200909272016.04597.rjw__31069.3341227763$1254075368$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0909271329400.5871-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0909271329400.5871-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Young <hidave.darkstar@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sunday 27 September 2009, Alan Stern wrote:
> On Sun, 27 Sep 2009, Rafael J. Wysocki wrote:
> 
> > Tested, works.
> > 
> > Greg, could you please consider taking the patch below?  It fixes a recent
> > hibernation regression for me, so if not this one, another fix is necessary.
> 
> This patch has a mistake.
> 
> > Index: linux-2.6/drivers/usb/serial/usb-serial.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/usb/serial/usb-serial.c
> > +++ linux-2.6/drivers/usb/serial/usb-serial.c
> > @@ -1210,7 +1210,7 @@ static const struct tty_operations seria
> >  	.chars_in_buffer =	serial_chars_in_buffer,
> >  	.tiocmget =		serial_tiocmget,
> >  	.tiocmset =		serial_tiocmset,
> > -	.shutdown = 		serial_release,
> > +	.cleanup = 		serial_release,
> >  	.install = 		serial_install,
> >  	.proc_fops =		&serial_proc_fops,
> >  };
> 
> It isn't enough to change the method pointer.  The code in 
> serial_release() has to be changed too; it must not call tty_shutdown() 
> any more.

Would it be sufficient to remove the tty_shutdown() call from
serial_release()?

Rafael

From: Greg KH <gregkh@suse.de>
Subject: Re: Two problems with system sleep
Date: Fri, 12 Feb 2010 16:21:36 -0800
Message-ID: <20100213002134.GA20375@suse.de>
References: <Pine.LNX.4.44L0.1002121527530.1272-100000@iolanthe.rowland.org>
	<201002130113.01434.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002130113.01434.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 13, 2010 at 01:13:01AM +0100, Rafael J. Wysocki wrote:
> On Friday 12 February 2010, Alan Stern wrote:
> > Rafael:
> > 
> > My newly-installed desktop system is experiencing a couple of problems 
> > with system sleep.  (Oddly enough, the old one was working fairly 
> > well...)
> > 
> > The first has to do with the serial port.  It doesn't appear to resume 
> > correctly.  I booted with:
> > 
> > 	console=ttyS0,115200 console=tty0 earlyprintk=serial,ttyS0,115200
> > 		no_console_suspend
> > 
> > Then I did "echo processors >pm_test ; echo mem >state".  In spite of
> > the no_console_suspend, data stopped going out through the serial port
> > after the following appeared:
> > 
> > [  273.664785] PM: Preparing system for mem sleep
> > [  273.677133] Freezing user space processes ... (elapsed 0.01 seconds) done.
> > [  273.698837] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> > [  273.718799] PM: Entering mem sleep
> > [  273.794463] serial 00:05: disabled
> > 
> > even though things continued to appear on the VT screen.  The only
> > other text to show up on the serial monitor was this line:
> > 
> > [  279.069204] serial 00:05: activated
> > 
> > The normal sequence of messages showed up on the screen, but everything
> > was oddly slow.  Check out some sample timestamps:
> > 
> > [  332.120130] ehci_hcd 0000:00:1d.7: GetStatus port 8 status 001005 POWER sig=se0 PE CONNECT
> > [  334.592054] usb 2-8: finish resume
> > [  335.613747] PM: resume of devices complete after 56629.644 msecs
> > [  337.426230] PM: Finishing wakeup.
> > [  338.430797] Restarting tasks ... 
> > [  339.378108] usb 2-8: usb auto-suspend
> > [  340.554760] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
> > [  342.204128] done.
> > [  342.816603] hub 2-0:1.0: state 7 ports 8 chg 0000 evt 0000
> > 
> > The delay between each line and its successor is proportional to the
> > line's length, as though the kernel were still trying to send the 
> > characters out through the serial port but at 360 baud!  Is anybody in 
> > charge of the 8250 driver these days?
> 
> Quite frankly I'm not sure.  Greg, do you know?

Well, Alan Cox has been looking after it, with me handling patch queues.

That's a pretty slow print speed, very wierd.

Alan Cox, any ideas?

thanks,

greg k-h

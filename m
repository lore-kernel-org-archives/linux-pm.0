From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Fri, 30 Jan 2009 06:33:30 -0800 (PST)
Message-ID: <333776.95358.qm@web36801.mail.mud.yahoo.com>
References: <Pine.LNX.4.44L0.0901291816130.6298-100000@iolanthe.rowland.org>
Reply-To: dqarras@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901291816130.6298-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > (Of course for a layman like me it is a bit saddening
> > that this worked earlier but not anymore.)
> 
> Perhaps Rafael has some idea on what has changed in the
> meantime to cause this problem.  It could have something to do with the
> way ACPI is now integrated with the PCI drivers, for example.

Not sure if this is appropriate but I'll mention that I have dual-boot and with Windows XP SP 3 hibernation works all ok.

> > Please find such a dmesg attached.
> 
> The log doesn't indicate a real cause.  It does show
> that wakeup was disabled on the EHCI controller, but nevertheless that
> controller must have been responsible for waking up your system when the
> mouse was plugged back in.  You can test this by unloading ehci-hcd
> before suspending.

Correct, I tested suspend after removing the offending module and plugging the mouse does not wake the machine anymore! One thing is still different when comparing to Win XP (if I may): hitting mouse buttons will activate the internal led while in suspend even after removing the module but nothing done with the mouse wakes the machine.

> The fact that _un_plugging the mouse didn't cause a
> wakeup has an interesting explanation.  The mouse is a low-speed USB
> device, and as such is managed by the UHCI controller.  Evidently that
> controller really was disabled for wakeup, since unplugging the mouse
> didn't have any effect.  But when a new USB device is plugged in, the
> system doesn't know what speed it runs at.  So the device is
> attached first to EHCI, and then if it proves not to be high-speed it
> gets switched electronically over to UHCI.  Thus the plug-in event
> stimulated the EHCI controller to cause a wakeup.
> 
> This does seem like a firmware problem, but maybe Rafael
> can suggest a way to work around it.

That would be awesome. I'm able to test any patches you might cook up.

Thanks!




      

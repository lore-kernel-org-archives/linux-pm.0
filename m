From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Thu, 29 Jan 2009 18:24:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901291816130.6298-100000@iolanthe.rowland.org>
References: <465476.87234.qm@web36803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <465476.87234.qm@web36803.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Qarras <dqarras@yahoo.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Jan 2009, Daniel Qarras wrote:

> > Besides, the real problem isn't autosuspend at all, as
> > far as I can tell.  The first problem is that the computer wakes up
> > immediately after going into hibernation.  The second problem is that
> > the computer wakes up from suspend immediately when a USB mouse is
> > plugged in.
> 
> Yes, this is a correct description.
> 
> > I don't know what's causing the first problem (which has been around 
> > since 2.6.24).  Maybe a firmware bug.  Perhaps doing
> > "rmmod ehci-hcd" before hibernating will help.
> 
> Correct:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019251.html
> 
> (Of course for a layman like me it is a bit saddening that this worked earlier but not anymore.)

Perhaps Rafael has some idea on what has changed in the meantime to 
cause this problem.  It could have something to do with the way ACPI is 
now integrated with the PCI drivers, for example.

> > To attack the second problem, it would help to see a dmesg
> > log showing the immediate wakeup from a kernel with CONFIG_USB_DEBUG
> > enabled.
> 
> Please find such a dmesg attached.

The log doesn't indicate a real cause.  It does show that wakeup was 
disabled on the EHCI controller, but nevertheless that controller must 
have been responsible for waking up your system when the mouse was 
plugged back in.  You can test this by unloading ehci-hcd before 
suspending.

The fact that _un_plugging the mouse didn't cause a wakeup has an 
interesting explanation.  The mouse is a low-speed USB device, and as 
such is managed by the UHCI controller.  Evidently that controller 
really was disabled for wakeup, since unplugging the mouse didn't have 
any effect.  But when a new USB device is plugged in, the system 
doesn't know what speed it runs at.  So the device is attached first to 
EHCI, and then if it proves not to be high-speed it gets switched 
electronically over to UHCI.  Thus the plug-in event stimulated the 
EHCI controller to cause a wakeup.

This does seem like a firmware problem, but maybe Rafael can suggest a 
way to work around it.

Alan Stern

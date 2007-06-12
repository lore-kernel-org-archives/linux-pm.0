From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: ehci_hcd causes box to resume
	immediately after suspend to RAM
Date: Tue, 12 Jun 2007 14:16:15 +0200
Message-ID: <200706121416.15800.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706091721270.30086-100000@netrider.rowland.org>
	<1181613041.6629.5.camel@localhost.localdomain>
	<200706121359.28888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200706121359.28888.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 12 June 2007 13:59, Rafael J. Wysocki wrote:
> On Tuesday, 12 June 2007 03:50, Zhang Rui wrote:
> > > > > I've tried to suspend with the controller in that state, but it's resumed
> > > > > immediately, as before.
> > > > > 
> > > > > > Maybe also see what ACPI reports.
> > > > > 
> > > > > How can I see that?
> > > > 
> > > > I wish I knew.  Maybe you can try asking on the ACPI mailing list.
> > > > 
> > > > The simplest workaround should be to disable remote wakeup for that 
> > > > controller:
> > > > 
> > > > 	echo disable >/sys/bus/pci/devices/.../power/wakeup
> > > 
> > > I tried that but it didn't help.  Namely, the box resumed right after
> > > suspending as it had done before.
> > > 
> > > The only way to prevent it from resuming immediately after the suspend is to
> > > 'rmmod ehci_hcd' before the suspend.
> > > 
> > > Interestingly enough, I have no such problems with EHCI on the other test box
> > > that is able to suspend to RAM and resume.
> > > 
> > What's the kernel version you are using?
> > Is it the same problem shown here?
> > http://lkml.org/lkml/2007/5/18/55
> > 2.6.22-rc1-mm1 may have this problem.
> 
> Yes, I remeber this thread.

s/remeber/remember/

> The kernel is 2.6.22-rc4 with the patches from
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc4/patches/
> applied.
> 
> Greetings,
> Rafael
 

-- 
"Premature optimization is the root of all evil." - Donald Knuth

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

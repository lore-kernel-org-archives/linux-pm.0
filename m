From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Sun, 04 Jul 2010 01:42:03 +0300
Message-ID: <1278196923.14606.4.camel@localhost.localdomain>
References: <1277940699.4138.29.camel@localhost.localdomain>
	<201007012058.20758.rjw@sisk.pl>
	<1278017083.7029.4.camel@localhost.localdomain>
	<201007012307.38086.rjw@sisk.pl>
	<1278196868.14606.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278196868.14606.3.camel@localhost.localdomain>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-07-04 at 01:41 +0300, Maxim Levitsky wrote:
> On Thu, 2010-07-01 at 23:07 +0200, Rafael J. Wysocki wrote:
> > On Thursday, July 01, 2010, Maxim Levitsky wrote:
> > > On Thu, 2010-07-01 at 20:58 +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, July 01, 2010, Maxim Levitsky wrote:
> > > > > On Thu, 2010-07-01 at 01:40 +0200, Rafael J. Wysocki wrote:
> > > > > > On Thursday, July 01, 2010, Maxim Levitsky wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > 
> > > > > > > This is my desktop, and I don't use it much.
> > > > > > > I updated the kernel from 2.6.33 to 2.6.35-rc3, and my usb mouse (usb
> > > > > > > 1.1 of course) doesn't wake the system anymore.
> > > > > > 
> > > > > > Please wait for 2.6.35-rc4 to appear and see if there's any difference.
> > > > > Why should I?
> > > > > I always compile from git.
> > > > 
> > > > Well, you didn't say that.
> > > > 
> > > > > Just pulled Linus' tree, and nothing changed.
> > > > 
> > > > If you have an Ethernet adapter in that box and you can set up for Wake-on-LAN,
> > > > please check if that works.
> > > 
> > > Ethernet adapter (e1000e) is broken by another regression (wol maybe
> > > still works...) ;-)
> > 
> > Well, what exactly do you mean by broken?  It definitely works in my test box.
> > 
> > > I test this, and probably bisect the problem anyway.
> > 
> > It may not be necessary if the WoL test fails.
> > 
> > > Note that wakeup from PS/2 keyboard does work.
> > > (And it doesn't is I don't turn flags in /proc/acpi/wakeup...)
> > > 
> > > Me thinks about doing a dual-bisect for both regressions at same
> > > time....
> > 
> > If you have the time for that ...
> 
> 
> Alan. thanks for saving me from another bisect...
> latest git tip works again.

I mean, I think that
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=48826626263d4a61d06fd8c5805da31f925aefa0

fixed the problem.


> 
> (of course I need to explicitly enable power/wakeup on the mouse), but I
> can live with that.)
> 
> 
> I want to note that I still need to enable wakeup in /power/acpi/wakeup
> to make USB mouse wakeup the system.
> This isn't a regression, but I thought that I don't need that anymore.
> 
> 
> Best regards,
> 	Maxim Levitsky
> 
> 
> 
> 

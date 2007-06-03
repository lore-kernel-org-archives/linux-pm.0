From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ehci_hcd causes box to resume immediately
	after suspend to RAM
Date: Mon, 4 Jun 2007 00:35:31 +0200
Message-ID: <200706040035.31605.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706031120560.23975-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0706031120560.23975-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 June 2007 17:31, Alan Stern wrote:
> On Sun, 3 Jun 2007, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > One of my test boxes suspends to RAM just fine except that if ehci_hcd is
> > loaded before the suspend, the box resumes immediately after going to sleep.
> 
> Evidently the hardware thinks a wakeup event has occurred.  It is 
> possible to disable remote wakeup via sysfs, but it would be more 
> interesting to find out the real reason for the wakeup.
> 
> I don't know how to go about doing that, however.  It might be some 
> interaction at the ACPI level, and it might involve the PCI PME# 
> signal.
> 
> Do you have any USB devices attached when you suspend?

Not that I know of.

> You can try using the patch below to see what happens when you manually
> suspend the controller.  It enables PCI devices to respond to the
> legacy power/state attribute.  You should look at what "lspci -vv" says
> about the controller's power management signals, both before and after
> suspending the PCI device entry.  Maybe also see what ACPI reports.

I'll be able to do this in a couple of days, when I have access to the machine
again.

Greetings,
Rafael


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

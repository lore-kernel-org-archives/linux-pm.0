From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd causes box to resume immediately
 after suspend to RAM
Date: Thu, 14 Jun 2007 18:26:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706141823220.5119-100000@iolanthe.rowland.org>
References: <200706140001.15354.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200706140001.15354.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 14 Jun 2007, Rafael J. Wysocki wrote:

> > Hmmm...  If you turn on CONFIG_USB_DEBUG, what shows up in 
> > /sys/class/usb_host/usb_hostN/registers where N is the bus number of 
> > the controller?
> 
> bus pci, device 0000:00:1d.7 (driver 10 Dec 2004)
> EHCI Host Controller
> EHCI 1.00, hcd state 4
> ownership 00000001
> SMI sts/enable 0x80080000
> structural params 0x00103206
> capability params 0x00006871
> status 1008 Halt FLR
> command 010000 (park)=0 ithresh=1 period=1024 HALT
> intrenable 37 IAA FATAL PCD ERR INT
> uframe 36f1
> port 1 status 701000 POWER sig=se0
> port 2 status 701000 POWER sig=se0
> port 3 status 701000 POWER sig=se0
> port 4 status 701000 POWER sig=se0
> port 5 status 701000 POWER sig=se0
> port 6 status 701000 POWER sig=se0
> irq normal 0 err 0 reclaim 0 (lost 0)
> complete 0 unlink 0

Nothing special there.

> > Also, can you post a dmesg log (with CONFIG_USB_DEBUG enabled) showing 
> > what happens during the suspend and immediate resume?
> 
> [That's after I have disabled the wakeup on the EHCI  controller.]
...
> Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 6 chg 0000 evt 0000
> ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001020 POWER sig=se0 OCC
> hub 1-0:1.0: over-current change on port 3
> hub 1-0:1.0: trying to enable port power on non-switchable hub
> done.
> ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001020 POWER sig=se0 OCC
> hub 1-0:1.0: over-current change on port 4
> hub 1-0:1.0: trying to enable port power on non-switchable hub
> ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001020 POWER sig=se0 OCC
> hub 1-0:1.0: over-current change on port 5
> hub 1-0:1.0: trying to enable port power on non-switchable hub
> ehci_hcd 0000:00:1d.7: GetStatus port 6 status 001020 POWER sig=se0 OCC
> hub 1-0:1.0: over-current change on port 6
> hub 1-0:1.0: trying to enable port power on non-switchable hub

That's odd.  Where could these overcurrent changes be coming from?  
And how come they don't show up on ports 1 and 2?

There's an excellent chance that they are responsible for your 
immediate resumes.

Alan Stern


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

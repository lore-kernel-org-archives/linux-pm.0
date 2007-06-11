From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd causes box to resume immediately
 after suspend to RAM
Date: Mon, 11 Jun 2007 16:10:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706111536330.2749-100000@iolanthe.rowland.org>
References: <200706112115.54395.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200706112115.54395.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Jun 2007, Rafael J. Wysocki wrote:

> > At that point, does "lspci -vv" show that the controller is trying to 
> > signal a wakeup event?  That is, is the PME# signal asserted?
> > 
> > (Not that knowing this will help very much -- I'm not sure what we 
> > could do with that information, and in any case there are other ways 
> > besides PME# for on-board devices to report wakeup requests.  I ask 
> > mainly out of curiousity.)
> 
> It shows this literally:
> 
> 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
> 	Subsystem: ASUSTeK Computer Inc. Unknown device 8089
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin D routed to IRQ 20
> 	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D3 PME-Enable+ DSel=0 DScale=0 PME-
> 	Capabilities: [58] Debug port

Which means that the controller is in D3 and it supports PME#, but PME#
isn't turned on.  But as I said, Intel controllers may signal wakeup
requests in a different way (UHCI controllers definitely do, but maybe
not EHCI).

> > The simplest workaround should be to disable remote wakeup for that 
> > controller:
> > 
> > 	echo disable >/sys/bus/pci/devices/.../power/wakeup
> 
> I tried that but it didn't help.  Namely, the box resumed right after
> suspending as it had done before.
> 
> The only way to prevent it from resuming immediately after the suspend is to
> 'rmmod ehci_hcd' before the suspend.

Hmmm...  If you turn on CONFIG_USB_DEBUG, what shows up in 
/sys/class/usb_host/usb_hostN/registers where N is the bus number of 
the controller?

Also, can you post a dmesg log (with CONFIG_USB_DEBUG enabled) showing 
what happens during the suspend and immediate resume?

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

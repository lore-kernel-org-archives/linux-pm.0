From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ehci_hcd causes box to resume immediately
	after suspend to RAM
Date: Mon, 11 Jun 2007 21:15:53 +0200
Message-ID: <200706112115.54395.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706091721270.30086-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0706091721270.30086-100000@netrider.rowland.org>
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

On Saturday, 9 June 2007 23:26, Alan Stern wrote:
> On Sat, 9 Jun 2007, Rafael J. Wysocki wrote:
> 
> > > You can try using the patch below to see what happens when you manually
> > > suspend the controller.  It enables PCI devices to respond to the
> > > legacy power/state attribute.  You should look at what "lspci -vv" says
> > > about the controller's power management signals, both before and after
> > > suspending the PCI device entry.
> > 
> > It works as expected, AFAICS.  That is, after I echo '2' to the 'state' file,
> > it shows that the controller is in D3.
> 
> At that point, does "lspci -vv" show that the controller is trying to 
> signal a wakeup event?  That is, is the PME# signal asserted?
> 
> (Not that knowing this will help very much -- I'm not sure what we 
> could do with that information, and in any case there are other ways 
> besides PME# for on-board devices to report wakeup requests.  I ask 
> mainly out of curiousity.)

It shows this literally:

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8089
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 20
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D3 PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

> > I've tried to suspend with the controller in that state, but it's resumed
> > immediately, as before.
> > 
> > > Maybe also see what ACPI reports.
> > 
> > How can I see that?
> 
> I wish I knew.  Maybe you can try asking on the ACPI mailing list.
> 
> The simplest workaround should be to disable remote wakeup for that 
> controller:
> 
> 	echo disable >/sys/bus/pci/devices/.../power/wakeup

I tried that but it didn't help.  Namely, the box resumed right after
suspending as it had done before.

The only way to prevent it from resuming immediately after the suspend is to
'rmmod ehci_hcd' before the suspend.

Interestingly enough, I have no such problems with EHCI on the other test box
that is able to suspend to RAM and resume.

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

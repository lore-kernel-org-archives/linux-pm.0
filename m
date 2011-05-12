From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: xHCI and suspend/resume
Date: Thu, 12 May 2011 17:49:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1105121733370.1917-100000__20916.4583393887$1305237138$gmane$org@iolanthe.rowland.org>
References: <BANLkTinGcS4YyPzc8zLzfUEBWmcOzYJ0jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinGcS4YyPzc8zLzfUEBWmcOzYJ0jA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dwight Schauer <dschauer@gmail.com>
Cc: dschauer@ti.com, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, "Xu, Andiry" <Andiry.Xu@amd.com>
List-Id: linux-pm@vger.kernel.org

For new readers: The problem is that an xHCI USB host controller does
not wake up a suspended system properly.

On Thu, 12 May 2011, Dwight Schauer wrote:

> Thanks Alan.
> 
> OK, this is with 2.6.39-rc7-gregkh
> 
> 05:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host
> Controller (rev 03) (prog-if 30 [XHCI])
>         Subsystem: Melco Inc Device 0241
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at fe9fe000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold-)
>                 Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME+

That's the important part for power management and wakeup.  The 
controller does support PCI wakeup.  In fact, at the time you ran lspci 
the controller _was_ suspended and it was signalling a wakeup request!  
Obviously something is wrong somewhere...

> @@@ With "on" in power/control I get this upon plugging in a keyboard:
...
> @@@ and upon removing it:

All normal.

> @@@ If I put "auto" in power/control I get this:
> 
> xhci_hcd 0000:05:00.0: hcd_pci_runtime_suspend: 0
> xhci_hcd 0000:05:00.0: PME# enabled

This means the controller was suspended with wakeup enabled, as it 
should be.

> @@@ Upon plugging in a keyboard nothing.

Indeed, that is a problem.  Since wakeup doesn't work right at runtime, 
it's not surprising that it also fails during system sleep.

> @@@ Setting power/wakeup to "enabled" (it was "disabled") has no
> effect on this behaviour.

The power/wakeup attribute affects only the wakeup setting for system 
sleep; it doesn't affect wakeups for runtime PM.

Clearly something is wrong.  But it looks like the problem might be
somewhere else, not in the xHCI driver.  Is your BIOS up to date?

CC-ing the linux-pm mailing list in case anybody there has some ideas.

Alan Stern

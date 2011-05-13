From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: xHCI and suspend/resume
Date: Fri, 13 May 2011 22:04:47 +0200
Message-ID: <201105132204.47549.rjw__5088.39659528366$1305317396$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105130029.33667.rjw@sisk.pl>
	<BANLkTinSgyFRsY+7dca1HfVmF-tV8cHb-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinSgyFRsY+7dca1HfVmF-tV8cHb-g@mail.gmail.com>
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
Cc: dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, May 13, 2011, Dwight Schauer wrote:
> On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
> >> On Thursday, May 12, 2011, Alan Stern wrote:
> >> > For new readers: The problem is that an xHCI USB host controller does
> >> > not wake up a suspended system properly.
> >> >
> >> > On Thu, 12 May 2011, Dwight Schauer wrote:
> >> >
> >> > > Thanks Alan.
> >> > >
> >> > > OK, this is with 2.6.39-rc7-gregkh
> >> > >
> >> > > 05:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host
> >> > > Controller (rev 03) (prog-if 30 [XHCI])
> >> > >         Subsystem: Melco Inc Device 0241
> >> > >         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> >> > > ParErr- Stepping- SERR+ FastB2B- DisINTx+
> >> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> >> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >> > >         Interrupt: pin A routed to IRQ 17
> >> > >         Region 0: Memory at fe9fe000 (64-bit, non-prefetchable) [size=8K]
> >> > >         Capabilities: [50] Power Management version 3
> >> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> >> > > PME(D0+,D1-,D2-,D3hot+,D3cold-)
> >> > >                 Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME+
> >> >
> >> > That's the important part for power management and wakeup.  The
> >> > controller does support PCI wakeup.  In fact, at the time you ran lspci
> >> > the controller _was_ suspended and it was signalling a wakeup request!
> >> > Obviously something is wrong somewhere...
> >> >
> >> > > @@@ With "on" in power/control I get this upon plugging in a keyboard:
> >> > ...
> >> > > @@@ and upon removing it:
> >> >
> >> > All normal.
> >> >
> >> > > @@@ If I put "auto" in power/control I get this:
> >> > >
> >> > > xhci_hcd 0000:05:00.0: hcd_pci_runtime_suspend: 0
> >> > > xhci_hcd 0000:05:00.0: PME# enabled
> >> >
> >> > This means the controller was suspended with wakeup enabled, as it
> >> > should be.
> >> >
> >> > > @@@ Upon plugging in a keyboard nothing.
> >> >
> >> > Indeed, that is a problem.  Since wakeup doesn't work right at runtime,
> >> > it's not surprising that it also fails during system sleep.
> >> >
> ....
> >> >
> >> > Clearly something is wrong.  But it looks like the problem might be
> >> > somewhere else, not in the xHCI driver.  Is your BIOS up to date?
> >> >
> >> > CC-ing the linux-pm mailing list in case anybody there has some ideas.
> >>
> >> I need a boot log from 2.6.39-rc6 (or current Linus') on the affected system.
> >
> > That should have been -rc7, sorry.
> >
> > Thanks,
> > Rafael
> 
> Rafael,
> 
> I updated the BIOS, but the results are the same.

I'm not really sure if that matters.

Thanks for the boot log.

Please send the contents of /proc/interrupts before and after you've tried
to resume the xHCI controller.

Thanks,
Rafael

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Wed, 18 May 2005 19:40:08 +0200
Message-ID: <200505181940.09407.rjw@sisk.pl>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<200505172128.10344.rjw@sisk.pl>
	<20050518012604.GC11189@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050518012604.GC11189@neo.rr.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 18 of May 2005 03:26, Adam Belay wrote:
> On Tue, May 17, 2005 at 09:28:10PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 17 of May 2005 20:35, David Brownell wrote:
> > > On Tuesday 17 May 2005 2:10 am, Rafael J. Wysocki wrote:
> > > 
> > > > Could you please have a look at http://bugzilla.kernel.org/show_bug.cgi?id=4416
> > > 
> > > Sorry, I don't have much time for such things; especially for
> > > problems that only appear in the MM tree (with so many non-USB
> > > changes) ... and which already appear to be board-specific, and
> > > tied to ACPI changes.
> > 
> > Never mind.  :-)
> > 
> > > > There seems to be a problem with OHCI and EHCI drivers wrt suspend/resume
> > > > (swsusp) in the current -mm on that box.
> > > 
> > > Is that with or without those ACPI fixes?
> > 
> > Both ...
> > 
> > Rafael
> > 
> 
> Have you checked which of these device drivers are calling free_irq() in
> their suspend routines.

AFAICS, the EHCI and OHCI drivers do, but the snd_intel8x0 driver does not.
Anyway this does not seem to be relevant, as the box hangs when the
drivers' resume routines are called (ie on resume-during-resume).

All of the drivers that cause the problem are compiled as modules, so their
suspend routines are not called during swsusp resume.

> Also could I see /proc/interrupts (with an offending 
> combination of drivers loaded) and a list of the hardware you think might be
> involved.

The offending devices are (from lspci):

0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)

IOW, it's the nForce3 chipset.

Also, there are multiple configurations in which the problem appears (please
see below).

> Have you been able to find a pair of drivers that will cause this 
> problem?

The drivers that cause this problem (on this particular box) are:

ehci_hcd
ohci_hcd
snd_intel8x0

If any of them is loaded on suspend, the box hangs solid during resume (please
note that I was unable to reproduce the problem on a different box, using the
same drivers with the AMD chipset and the NEC USB 2.0).

Here go various /proc/interrupts that correspond to the "hanging" driver
configurations:

1) whith snd_intel8x0

           CPU0       
  0:    1145893          XT-PIC  timer
  1:       1187          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:        428          XT-PIC  acpi
 10:       4898          XT-PIC  NVidia nForce3
 11:          0          XT-PIC  yenta, yenta
 12:        119          XT-PIC  i8042
 14:       9787          XT-PIC  ide0
 15:       7294          XT-PIC  ide1
NMI:          0 
LOC:    1145536 
ERR:          0
MIS:          0

2) with EHCI

           CPU0       
  0:     146184          XT-PIC  timer
  1:        243          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          5          XT-PIC  ehci_hcd:usb1
  8:          0          XT-PIC  rtc
  9:         76          XT-PIC  acpi
 11:          0          XT-PIC  yenta, yenta
 12:        119          XT-PIC  i8042
 14:        759          XT-PIC  ide0
 15:       7240          XT-PIC  ide1
NMI:          0 
LOC:     146005 
ERR:          0
MIS:          0

3) with OHCI

           CPU0       
  0:     152128          XT-PIC  timer
  1:        205          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:         77          XT-PIC  acpi
 11:         25          XT-PIC  yenta, yenta, ohci_hcd:usb1, ohci_hcd:usb2
 12:        119          XT-PIC  i8042
 14:        813          XT-PIC  ide0
 15:       7310          XT-PIC  ide1
NMI:          0 
LOC:     151961 
ERR:          0
MIS:          0

Of course any combination of the three causes the problem.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

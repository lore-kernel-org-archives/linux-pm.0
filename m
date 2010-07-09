From: Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Subject: Re: HDD not suspending properly / dead on resume
Date: Sat, 10 Jul 2010 01:04:38 +0200
Message-ID: <201007100104.38693.stephan.diestelhorst@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201007092347.29244.stephan.diestelhorst@gmail.com> <201007092353.25731.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gs6NMn6cBn3M51e"
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201007092353.25731.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_Gs6NMn6cBn3M51e
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> On Friday, July 09, 2010, Stephan Diestelhorst wrote:
> > I wrote:
> > >   I have an issue with suspend to RAM and I/O load on a disk. Symptoms
> > > are that the disk does not respond to requests when woken up, producing
> > > only I/O errors on all tested kernels (newest 2.6.35-rc4 (Ubuntu
> > > mainline PPA build)):
> > > 
> > <snip>
> >  
> > > This can be triggered most reliably with multiple "direct" writes to
> > > disk, I create the load with the attached script. If the issue is
> > > triggered, suspend (through pm-suspend) takes very long.
> > 
> > > IMHO the interesting log output during suspend is:
> > > [ 1674.700125] ata1.00: qc timeout (cmd 0xec)
> > 
> > Almighty google suggested to try "pci=nomsi", which seems to have
> > cured the issue for me for now. Is that plausible? I'll keep this
> > under observation.
> 
> Hmm.  How does your /proc/interrupts look like?

This has been yet another red herring. After trying out the kernel
option three times with two different kernels, it failed yet again
with the same symptoms. 

I have attached /proc/interrupts for 2.6.35-rc4, once with pci=nomsi
and once without, but again, I do not think this makes a difference :-/

> Also, do you have a link to this "Google suggestion"?

It was some german forum, a guy with completely different HW, but the
same symptom. I thought trying out the option wouldn't hurt.

Maybe it came for example from http://lkml.org/lkml/2008/12/20/3
originally.

Stephan

--Boundary-00=_Gs6NMn6cBn3M51e
Content-Type: text/plain;
  charset="UTF-8";
  name="proc_interrupts.vanilla"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc_interrupts.vanilla"

           CPU0       CPU1       
  0:         54       5915   IO-APIC-edge      timer
  1:        137         34   IO-APIC-edge      i8042
  7:          1          0   IO-APIC-edge    
  8:          0          1   IO-APIC-edge      rtc0
  9:         20        110   IO-APIC-fasteoi   acpi
 12:          1        654   IO-APIC-edge      i8042
 16:          1        276   IO-APIC-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, ath9k, hda_intel
 17:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
 18:          1        330   IO-APIC-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7
 19:          0         21   IO-APIC-fasteoi   ehci_hcd:usb2
 22:        449       3999   IO-APIC-fasteoi   ahci
 44:          0          1   PCI-MSI-edge      sky2@pci:0000:04:00.0
 45:          0         17   PCI-MSI-edge      hda_intel
NMI:          0          0   Non-maskable interrupts
LOC:       3120        689   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
PND:          0          0   Performance pending work
RES:      13688       8555   Rescheduling interrupts
CAL:         81         54   Function call interrupts
TLB:        250        287   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          1          1   Machine check polls
ERR:          1
MIS:          0

--Boundary-00=_Gs6NMn6cBn3M51e
Content-Type: text/plain;
  charset="UTF-8";
  name="proc_interrupts.pci=nomsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc_interrupts.pci=nomsi"

           CPU0       CPU1       
  0:         73       8241   IO-APIC-edge      timer
  1:         37        396   IO-APIC-edge      i8042
  7:          1          0   IO-APIC-edge    
  8:          0          1   IO-APIC-edge      rtc0
  9:          1        175   IO-APIC-fasteoi   acpi
 12:       3030        157   IO-APIC-edge      i8042
 16:          3        296   IO-APIC-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, hda_intel, ath9k
 17:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
 18:          1         29   IO-APIC-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7, sky2@pci:0000:04:00.0
 19:          0         51   IO-APIC-fasteoi   ehci_hcd:usb2, hda_intel
 22:         55       7629   IO-APIC-fasteoi   ahci
NMI:          0          0   Non-maskable interrupts
LOC:       4255        738   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
PND:          0          0   Performance pending work
RES:      16044      10388   Rescheduling interrupts
CAL:         81         51   Function call interrupts
TLB:        325        423   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          1          1   Machine check polls
ERR:          1
MIS:          0

--Boundary-00=_Gs6NMn6cBn3M51e--

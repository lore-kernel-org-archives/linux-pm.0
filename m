From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [regression] "drm/i915: implement new pm ops" disables
 irq on aborted s2disk
Date: Wed, 03 Feb 2010 11:18:56 +0000
Message-ID: <4B695BA0.4000007__11521.453530486$1265196033$gmane$org@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Eric Anholt <eric@anholt.net>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi

I found this regression on my EeePC 701 with modesetting enabled.  When 
I hibernate using s2disk, I can abort the hibernation by pressing the 
backspace key.  Doing so breaks X on 2.6.32-rc6 (but not 2.6.32).

X resumes where it left off, but the problem is that the screen is 
frozen (except for the cursor).  The system still responds to input.  
E.g. if I hibernate from Konsole and type "find /" on resume, I don't 
see any result on the screen, but I can see the disk activity LED 
flashing madly.  I can also switch to text consoles, which work as normal.

The first bad commit in this scenario is v2.6.32-7504-gcbda12d: 
"drm/i915: implement new pm ops for i915".  I think the problem is that 
it (deliberately) turns "thaw" into a no-op.  That said, this "first 
bad" behaviour was somewhat different.  When I checked out this commit 
and tested it, it looked more like X was crashing and being repeatedly 
restarted.  The screen went black, and every few seconds it flickered, 
showing a text console for a fraction of a second and then going black 
again.

A few commits further on at v2.6.32-7518-ge3d8aff, I get the same 
behaviour as v2.6.33-rc6.  I didn't bother to find out exactly where 
this change happens.

On v2.6.32-7518-ge3d8aff, I was able to observe that aborting s2disk 
leaves the i915 interrupt [IRQ16] disabled:

Before s2disk:

$ cat /proc/interrupts
            CPU0                        
   0:       2030   IO-APIC-edge      timer
   1:        191   IO-APIC-edge      i8042
   8:          1   IO-APIC-edge      rtc0
   9:         51   IO-APIC-fasteoi   acpi
  12:        525   IO-APIC-edge      i8042
  14:          0   IO-APIC-edge      ata_piix
  15:       4954   IO-APIC-edge      ata_piix
  16:        123   IO-APIC-fasteoi   uhci_hcd:usb5, i915
  18:        134   IO-APIC-fasteoi   uhci_hcd:usb4, ath
  19:          0   IO-APIC-fasteoi   uhci_hcd:usb3     
  23:        345   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
  27:        169   PCI-MSI-edge      HDA Intel
  28:        150   PCI-MSI-edge      eth0
 NMI:          0   Non-maskable interrupts
...

After aborting s2disk:

$ cat /proc/interrupts
            CPU0
   0:       3241   IO-APIC-edge      timer
   1:        325   IO-APIC-edge      i8042
   8:          1   IO-APIC-edge      rtc0
   9:         79   IO-APIC-fasteoi   acpi
  12:        525   IO-APIC-edge      i8042
  14:          0   IO-APIC-edge      ata_piix
  15:       5812   IO-APIC-edge      ata_piix
  16:        160   IO-APIC-fasteoi   uhci_hcd:usb5
  18:        231   IO-APIC-fasteoi   uhci_hcd:usb4, ath
  19:          0   IO-APIC-fasteoi   uhci_hcd:usb3
  23:        726   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
  27:          0   PCI-MSI-edge      HDA Intel
  28:        102   PCI-MSI-edge      eth0
 NMI:          0   Non-maskable interrupts
...


Without looking at the code, my suggestion is that

a) It looks like "freeze" disables the interrupt, and "thaw" is no 
longer re-enabling it.

b) *If* this is the only problem, it could be fixed by not explicitly 
disabling the interrupt in the "freeze" callback.  In any case this 
would be the right thing to do, since the PCI core now takes 
responsibility for disabling IRQs over suspend (mentioned here: 
http://article.gmane.org/gmane.linux.kernel.pci/4696).

Regards
Alan

From: Dwight Schauer <dschauer@gmail.com>
Subject: Re: xHCI and suspend/resume
Date: Fri, 13 May 2011 15:21:48 -0500
Message-ID: <BANLkTim4R0u1O4p+Wm1gAxurrdts1agpFg__40472.8102418177$1305564313$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105130029.33667.rjw@sisk.pl>
	<BANLkTinSgyFRsY+7dca1HfVmF-tV8cHb-g@mail.gmail.com>
	<201105132204.47549.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105132204.47549.rjw@sisk.pl>
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
Cc: dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 13, 2011 at 3:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, May 13, 2011, Dwight Schauer wrote:
>> On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
>> >> On Thursday, May 12, 2011, Alan Stern wrote:
>> >> > For new readers: The problem is that an xHCI USB host controller do=
es
>> >> > not wake up a suspended system properly.
>> >> >
>> >> > On Thu, 12 May 2011, Dwight Schauer wrote:
>> >> >
>> >> > > Thanks Alan.
>> >> > >
>> >> > > OK, this is with 2.6.39-rc7-gregkh
>> >> > >
>> >> > > 05:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host
>> >> > > Controller (rev 03) (prog-if 30 [XHCI])
>> >> > > =A0 =A0 =A0 =A0 Subsystem: Melco Inc Device 0241
>> >> > > =A0 =A0 =A0 =A0 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV-=
 VGASnoop-
>> >> > > ParErr- Stepping- SERR+ FastB2B- DisINTx+
>> >> > > =A0 =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast >TAbort-
>> >> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >> > > =A0 =A0 =A0 =A0 Interrupt: pin A routed to IRQ 17
>> >> > > =A0 =A0 =A0 =A0 Region 0: Memory at fe9fe000 (64-bit, non-prefetc=
hable) [size=3D8K]
>> >> > > =A0 =A0 =A0 =A0 Capabilities: [50] Power Management version 3
>> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1- D2- AuxCu=
rrent=3D0mA
>> >> > > PME(D0+,D1-,D2-,D3hot+,D3cold-)
>> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D3 NoSoftRst+ PME-Enable+=
 DSel=3D0 DScale=3D0 PME+
>> >> >
>> >> > That's the important part for power management and wakeup. =A0The
>> >> > controller does support PCI wakeup. =A0In fact, at the time you ran=
 lspci
>> >> > the controller _was_ suspended and it was signalling a wakeup reque=
st!
>> >> > Obviously something is wrong somewhere...
>> >> >
>> >> > > @@@ With "on" in power/control I get this upon plugging in a keyb=
oard:
>> >> > ...
>> >> > > @@@ and upon removing it:
>> >> >
>> >> > All normal.
>> >> >
>> >> > > @@@ If I put "auto" in power/control I get this:
>> >> > >
>> >> > > xhci_hcd 0000:05:00.0: hcd_pci_runtime_suspend: 0
>> >> > > xhci_hcd 0000:05:00.0: PME# enabled
>> >> >
>> >> > This means the controller was suspended with wakeup enabled, as it
>> >> > should be.
>> >> >
>> >> > > @@@ Upon plugging in a keyboard nothing.
>> >> >
>> >> > Indeed, that is a problem. =A0Since wakeup doesn't work right at ru=
ntime,
>> >> > it's not surprising that it also fails during system sleep.
>> >> >
>> ....
>> >> >
>> >> > Clearly something is wrong. =A0But it looks like the problem might =
be
>> >> > somewhere else, not in the xHCI driver. =A0Is your BIOS up to date?
>> >> >
>> >> > CC-ing the linux-pm mailing list in case anybody there has some ide=
as.
>> >>
>> >> I need a boot log from 2.6.39-rc6 (or current Linus') on the affected=
 system.
>> >
>> > That should have been -rc7, sorry.
>> >
>> > Thanks,
>> > Rafael
>>
>> Rafael,
>>
>> I updated the BIOS, but the results are the same.
>
> I'm not really sure if that matters.
>
> Thanks for the boot log.
>
> Please send the contents of /proc/interrupts before and after you've tried
> to resume the xHCI controller.
>
> Thanks,
> Rafael

@@@ "on" in power/control

cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:        160          2        432     114714   IO-APIC-edge      timer
   1:          0          0          1          7   IO-APIC-edge      i8042
   4:          0          0          0          2   IO-APIC-edge
   8:          0          0          1        112   IO-APIC-edge      rtc0
   9:          0          0          0          2   IO-APIC-fasteoi   acpi
  16:          0          0          0        439   IO-APIC-fasteoi   hda_i=
ntel
  17:          0          0          0          4   IO-APIC-fasteoi
ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb6
  18:          0          0          4        667   IO-APIC-fasteoi
ahci, ohci_hcd:usb8, ohci_hcd:usb9, ohci_hcd:usb10, ohci_hcd:usb11,
radeon
  19:          0          1        367      23884   IO-APIC-fasteoi
pata_jmicron, hda_intel
  40:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  41:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  42:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  43:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  44:          0          0          0          1   PCI-MSI-edge      xhci_=
hcd
  45:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  46:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  47:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  48:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  49:          0          0          1         70   PCI-MSI-edge      xhci_=
hcd
  50:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  51:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  52:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  53:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  54:          0          0         53      10057   PCI-MSI-edge      ahci
  55:          0          0        264      70106   PCI-MSI-edge      eth0
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:      23649      25377      13777       1796   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance
monitoring interrupts
 IWI:          0          0          0          0   IRQ work interrupts
 RES:      14809       7675       5676      13388   Rescheduling interrupts
 CAL:         95        138        135         60   Function call interrupts
 TLB:        214        453        438        191   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:         17         17         17         17   Machine check polls
 ERR:          0
 MIS:          0

@@@ plug in keyboard

cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:        160          2        435     116427   IO-APIC-edge      timer
   1:          0          0          1          7   IO-APIC-edge      i8042
   4:          0          0          0          2   IO-APIC-edge
   8:          0          0          1        112   IO-APIC-edge      rtc0
   9:          0          0          0          2   IO-APIC-fasteoi   acpi
  16:          0          0          0        439   IO-APIC-fasteoi   hda_i=
ntel
  17:          0          0          0          4   IO-APIC-fasteoi
ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb6
  18:          0          0          4        667   IO-APIC-fasteoi
ahci, ohci_hcd:usb8, ohci_hcd:usb9, ohci_hcd:usb10, ohci_hcd:usb11,
radeon
  19:          0          1        369      24272   IO-APIC-fasteoi
pata_jmicron, hda_intel
  40:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  41:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  42:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  43:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  44:          0          0          0          1   PCI-MSI-edge      xhci_=
hcd
  45:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  46:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  47:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  48:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  49:          0          0          1         90   PCI-MSI-edge      xhci_=
hcd
  50:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  51:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  52:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  53:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  54:          0          0         53      10107   PCI-MSI-edge      ahci
  55:          0          0        264      70471   PCI-MSI-edge      eth0
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:      23959      25836      13974       1813   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance
monitoring interrupts
 IWI:          0          0          0          0   IRQ work interrupts
 RES:      14962       7794       5738      13477   Rescheduling interrupts
 CAL:         95        138        135         60   Function call interrupts
 TLB:        217        461        448        192   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:         17         17         17         17   Machine check polls
 ERR:          0
 MIS:          0

usb usb5: usb wakeup-resume
usb usb5: usb auto-resume
hub 5-0:1.0: hub_resume
hub 5-0:1.0: port 2: status 0101 change 0001
hub 5-0:1.0: state 7 ports 2 chg 0004 evt 0000
hub 5-0:1.0: port 2, status 0101, change 0000, 12 Mb/s
usb 5-2: new low speed USB device number 5 using xhci_hcd
usb 5-2: skipped 1 descriptor after interface
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: default language 0x0409
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: udev 5, busnum 5, minor =3D 516
usb 5-2: New USB device found, idVendor=3D413c, idProduct=3D2005
usb 5-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 5-2: Product: DELL USB Keyboard
usb 5-2: Manufacturer: DELL
usb 5-2: usb_probe_device
usb 5-2: configuration #1 chosen from 1 choice
usb 5-2: ep 0x81 - rounding interval to 64 microframes, ep desc says
80 microframes
usb 5-2: Successful Endpoint Configure command
usb 5-2: adding 5-2:1.0 (config #1, interface 0)
usbhid 5-2:1.0: usb_probe_interface
usbhid 5-2:1.0: usb_probe_interface - got id
input: DELL DELL USB Keyboard as
/devices/pci0000:00/0000:00:15.1/0000:06:00.0/usb5/5-2/5-2:1.0/input/input10
generic-usb 0003:413C:2005.0006: input,hidraw0: USB HID v1.10 Keyboard
[DELL DELL USB Keyboard] on usb-0000:06:00.0-2/input0
drivers/usb/core/inode.c: creating file '005'

@@@ "auto" into power/control
@@@ unplug keyboard

hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0004
hub 5-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
usb 5-2: USB disconnect, device number 5
usb 5-2: unregistering device
usb 5-2: unregistering interface 5-2:1.0
xhci_hcd 0000:06:00.0: shutdown urb ffff880117c0ce40 ep1in-intr
usb 5-2: usb_disable_device nuking all URBs
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 5-0:1.0: hub_suspend
usb usb5: bus auto-suspend
xhci_hcd 0000:06:00.0: hcd_pci_runtime_suspend: 0
xhci_hcd 0000:06:00.0: PME# enabled

cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:        160          2        441     121725   IO-APIC-edge      timer
   1:          0          0          1          7   IO-APIC-edge      i8042
   4:          0          0          0          2   IO-APIC-edge
   8:          0          0          1        112   IO-APIC-edge      rtc0
   9:          0          0          0          2   IO-APIC-fasteoi   acpi
  16:          0          0          0        439   IO-APIC-fasteoi   hda_i=
ntel
  17:          0          0          0          4   IO-APIC-fasteoi
ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb6
  18:          0          0          4        669   IO-APIC-fasteoi
ahci, ohci_hcd:usb8, ohci_hcd:usb9, ohci_hcd:usb10, ohci_hcd:usb11,
radeon
  19:          0          1        382      25389   IO-APIC-fasteoi
pata_jmicron, hda_intel
  40:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  41:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  42:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  43:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  44:          0          0          0          1   PCI-MSI-edge      xhci_=
hcd
  45:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  46:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  47:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  48:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  49:          0          0          1         93   PCI-MSI-edge      xhci_=
hcd
  50:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  51:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  52:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  53:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  54:          0          0         53      10259   PCI-MSI-edge      ahci
  55:          0          0        265      71801   PCI-MSI-edge      eth0
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:      24950      27263      14491       1854   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance
monitoring interrupts
 IWI:          0          0          0          0   IRQ work interrupts
 RES:      15279       8090       5883      13849   Rescheduling interrupts
 CAL:         95        138        135         60   Function call interrupts
 TLB:        224        472        469        193   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:         18         18         18         18   Machine check polls
 ERR:          0
 MIS:          0

@@@ plug keyboard back in

cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:        160          2        444     122646   IO-APIC-edge      timer
   1:          0          0          1          7   IO-APIC-edge      i8042
   4:          0          0          0          2   IO-APIC-edge
   8:          0          0          1        112   IO-APIC-edge      rtc0
   9:          0          0          0          2   IO-APIC-fasteoi   acpi
  16:          0          0          0        439   IO-APIC-fasteoi   hda_i=
ntel
  17:          0          0          0          4   IO-APIC-fasteoi
ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb6
  18:          0          0          4        669   IO-APIC-fasteoi
ahci, ohci_hcd:usb8, ohci_hcd:usb9, ohci_hcd:usb10, ohci_hcd:usb11,
radeon
  19:          0          1        385      25596   IO-APIC-fasteoi
pata_jmicron, hda_intel
  40:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  41:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  42:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  43:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  44:          0          0          0          1   PCI-MSI-edge      xhci_=
hcd
  45:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  46:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  47:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  48:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  49:          0          0          1         93   PCI-MSI-edge      xhci_=
hcd
  50:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  51:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  52:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  53:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  54:          0          0         53      10289   PCI-MSI-edge      ahci
  55:          0          0        266      71934   PCI-MSI-edge      eth0
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:      25130      27508      14608       1864   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance
monitoring interrupts
 IWI:          0          0          0          0   IRQ work interrupts
 RES:      15335       8131       5912      13899   Rescheduling interrupts
 CAL:         95        138        135         60   Function call interrupts
 TLB:        225        475        475        194   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:         18         18         18         18   Machine check polls
 ERR:          0
 MIS:          0

@@@ "on" into power/control

cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:        160          2        445     124015   IO-APIC-edge      timer
   1:          0          0          1          7   IO-APIC-edge      i8042
   4:          0          0          0          2   IO-APIC-edge
   8:          0          0          1        112   IO-APIC-edge      rtc0
   9:          0          0          0          2   IO-APIC-fasteoi   acpi
  16:          0          0          0        439   IO-APIC-fasteoi   hda_i=
ntel
  17:          0          0          0          4   IO-APIC-fasteoi
ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb6
  18:          0          0          4        669   IO-APIC-fasteoi
ahci, ohci_hcd:usb8, ohci_hcd:usb9, ohci_hcd:usb10, ohci_hcd:usb11,
radeon
  19:          0          1        386      25875   IO-APIC-fasteoi
pata_jmicron, hda_intel
  40:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  41:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  42:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  43:          0          0          0          0   PCI-MSI-edge      PCIe =
PME
  44:          0          0          0          1   PCI-MSI-edge      xhci_=
hcd
  45:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  46:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  47:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  48:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  49:          0          0          2        112   PCI-MSI-edge      xhci_=
hcd
  50:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  51:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  52:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  53:          0          0          0          0   PCI-MSI-edge      xhci_=
hcd
  54:          0          0         53      10320   PCI-MSI-edge      ahci
  55:          0          0        266      72225   PCI-MSI-edge      eth0
 NMI:          0          0          0          0   Non-maskable interrupts
 LOC:      25359      27894      14781       1874   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          0          0          0   Performance
monitoring interrupts
 IWI:          0          0          0          0   IRQ work interrupts
 RES:      15432       8268       5978      14030   Rescheduling interrupts
 CAL:         95        138        135         60   Function call interrupts
 TLB:        229        483        483        195   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:         18         18         18         18   Machine check polls
 ERR:          0
 MIS:          0

xhci_hcd 0000:06:00.0: PME# disabled
xhci_hcd 0000:06:00.0: setting latency timer to 64
xhci_hcd 0000:06:00.0: hcd_pci_runtime_resume: 0
usb usb5: usb wakeup-resume
usb usb5: usb auto-resume
hub 5-0:1.0: hub_resume
hub 5-0:1.0: port 2: status 0101 change 0001
hub 5-0:1.0: state 7 ports 2 chg 0004 evt 0000
hub 5-0:1.0: port 2, status 0101, change 0000, 12 Mb/s
usb 5-2: new low speed USB device number 6 using xhci_hcd
usb 5-2: skipped 1 descriptor after interface
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: default language 0x0409
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
xhci_hcd 0000:06:00.0: WARN: short transfer on control ep
usb 5-2: udev 6, busnum 5, minor =3D 517
usb 5-2: New USB device found, idVendor=3D413c, idProduct=3D2005
usb 5-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 5-2: Product: DELL USB Keyboard
usb 5-2: Manufacturer: DELL
usb 5-2: usb_probe_device
usb 5-2: configuration #1 chosen from 1 choice
usb 5-2: ep 0x81 - rounding interval to 64 microframes, ep desc says
80 microframes
usb 5-2: Successful Endpoint Configure command
usb 5-2: adding 5-2:1.0 (config #1, interface 0)
usbhid 5-2:1.0: usb_probe_interface
usbhid 5-2:1.0: usb_probe_interface - got id
input: DELL DELL USB Keyboard as
/devices/pci0000:00/0000:00:15.1/0000:06:00.0/usb5/5-2/5-2:1.0/input/input11
generic-usb 0003:413C:2005.0007: input,hidraw0: USB HID v1.10 Keyboard
[DELL DELL USB Keyboard] on usb-0000:06:00.0-2/input0
drivers/usb/core/inode.c: creating file '006'

@@@ That is all

I see that with "auto" in power/control no xhci interrupts occur when
the keyboard is plugged in, but they occur after "on" is put back into
power/control.

-- Dwight Schauer

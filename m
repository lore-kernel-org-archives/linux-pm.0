From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21 -- Forced to hard power off from attempted
	hibernation
Date: Tue, 8 May 2007 12:24:48 +0200
Message-ID: <200705081224.48600.rjw@sisk.pl>
References: <a44ae5cd0705080009l2e7bac9ayc379acdfe17e2507@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <a44ae5cd0705080009l2e7bac9ayc379acdfe17e2507@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: lkml@kernel.org, Miles Lane <miles.lane@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 8 May 2007 09:09, Miles Lane wrote:
> Hello,
> 
> When I tried to hibernate my laptop (HP Pavilion dv1240us), everything
> seemed to be working,  but the power never shut off.  I had to hold
> down the power button for five seconds.

Does the log below finish where the machine hanged?
 
> [ 2813.923051] PM: suspend-to-disk mode set to 'shutdown'
> [ 2813.939718] Stopping tasks ... done.
> [ 2814.489718] Shrinking memory... \[ACPI Debug]  String: [0x1C]
> "Temperature increasing: _Q80"
> [ 2815.486385]done (41580 pages freed)
> [ 2815.529718] Freed 166320 kbytes in 1.03 seconds (161.47 MB/s)
> [ 2815.529718] Suspending console(s)
> [ 2815.529718] platform bluetooth: freeze
> [ 2815.529718] ac97 0-0:unknown codec: freeze
> [ 2815.529718] iTCO_wdt iTCO_wdt: freeze
> [ 2815.529718]  usbdev4.1: PM: suspend 0->1, parent usb4 already 2
> [ 2815.529718]  usbdev4.1_ep81: PM: suspend 0->1, parent 4-0:1.0 already 2
> [ 2815.529718] hub 4-0:1.0: PM: suspend 2-->1
> [ 2815.529718] hub 4-0:1.0: PM: suspend 2->1, parent usb4 already 2
> [ 2815.529718]  usbdev4.1_ep00: PM: suspend 0->1, parent usb4 already 2
> [ 2815.529718] usb usb4: PM: suspend 2-->1
> [ 2815.529718]  usbdev3.1: PM: suspend 0->1, parent usb3 already 2
> [ 2815.529718]  usbdev3.1_ep81: PM: suspend 0->1, parent 3-0:1.0 already 2
> [ 2815.529718] hub 3-0:1.0: PM: suspend 2-->1
> [ 2815.529718] hub 3-0:1.0: PM: suspend 2->1, parent usb3 already 2
> [ 2815.529718]  usbdev3.1_ep00: PM: suspend 0->1, parent usb3 already 2
> [ 2815.529718] usb usb3: PM: suspend 2-->1
> [ 2815.529718]  usbdev2.1: PM: suspend 0->1, parent usb2 already 2
> [ 2815.529718]  usbdev2.1_ep81: PM: suspend 0->1, parent 2-0:1.0 already 2
> [ 2815.529718] hub 2-0:1.0: PM: suspend 2-->1
> [ 2815.529718] hub 2-0:1.0: PM: suspend 2->1, parent usb2 already 2
> [ 2815.529718]  usbdev2.1_ep00: PM: suspend 0->1, parent usb2 already 2
> [ 2815.529718] usb usb2: PM: suspend 2-->1
> [ 2815.529718] sr 1:0:0:0: freeze
> [ 2815.543051] sd 0:0:0:0: freeze
> [ 2815.559718]  usbdev1.1: PM: suspend 0->1, parent usb1 already 2
> [ 2815.559718]  usbdev1.1_ep81: PM: suspend 0->1, parent 1-0:1.0 already 2
> [ 2815.559718] hub 1-0:1.0: PM: suspend 2-->1
> [ 2815.559718] hub 1-0:1.0: PM: suspend 2->1, parent usb1 already 2
> [ 2815.559718]  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 2
> [ 2815.559718] usb usb1: PM: suspend 2-->1
> [ 2815.559718] psmouse serio1: freeze
> [ 2815.559718] atkbd serio0: freeze
> [ 2815.559718] i8042 i8042: freeze
> [ 2815.559718] serial8250 serial8250: freeze
> [ 2815.559718] vesafb vesafb.0: freeze
> [ 2815.559718] platform pcspkr: freeze
> [ 2815.559718] i8042 aux 00:06: freeze
> [ 2815.559718] i8042 kbd 00:05: freeze
> [ 2815.559718] system 00:04: freeze
> [ 2815.559718] pnp 00:03: freeze
> [ 2815.559718] pnp 00:02: freeze
> [ 2815.559718] pnp 00:01: freeze
> [ 2815.559718] pnp 00:00: freeze
> [ 2815.559718] sdhci 0000:01:09.4: freeze
> [ 2815.559718] sdhci [sdhci_suspend()]: Suspending...
> [ 2815.559718] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [ 2815.559718] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [ 2815.559718] mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
> [ 2815.559718] ACPI: PCI interrupt for device 0000:01:09.4 disabled
> [ 2815.573051] tifm_7xx1 0000:01:09.3: freeze
> [ 2815.573051] ACPI: PCI interrupt for device 0000:01:09.3 disabled
> [ 2815.589718] ohci1394 0000:01:09.2: freeze
> [ 2815.606385] yenta_cardbus 0000:01:09.0: freeze
> [ 2815.606385] pci 0000:01:06.0: freeze
> [ 2815.606385] pci 0000:01:00.0: freeze
> [ 2815.606385] pci 0000:00:1f.6: freeze
> [ 2815.606385] Intel ICH 0000:00:1f.5: freeze
> [ 2815.606385] codec_write 0: semaphore is not ready for register 0x26
> [ 2815.606385] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
> [ 2815.606385] pci 0000:00:1f.3: freeze
> [ 2815.606385] ata_piix 0000:00:1f.1: freeze
> [ 2815.623051] ACPI: PCI interrupt for device 0000:00:1f.1 disabled
> [ 2815.623051] pci 0000:00:1f.0: freeze
> [ 2815.623051] pci 0000:00:1e.0: freeze
> [ 2815.623051] ehci_hcd 0000:00:1d.7: freeze
> [ 2815.623051] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> [ 2815.639718] ehci_hcd 0000:00:1d.7: --> PCI D3/wakeup
> [ 2815.639718] uhci_hcd 0000:00:1d.2: freeze
> [ 2815.639718] uhci_hcd 0000:00:1d.2: uhci_suspend
> [ 2815.639718] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
> [ 2815.639718] uhci_hcd 0000:00:1d.2: --> PCI D0/legacy
> [ 2815.639718] uhci_hcd 0000:00:1d.1: freeze
> [ 2815.639718] uhci_hcd 0000:00:1d.1: uhci_suspend
> [ 2815.639718] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
> [ 2815.639718] uhci_hcd 0000:00:1d.1: --> PCI D0/legacy
> [ 2815.639718] uhci_hcd 0000:00:1d.0: freeze
> [ 2815.639718] uhci_hcd 0000:00:1d.0: uhci_suspend
> [ 2815.639718] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
> [ 2815.639718] uhci_hcd 0000:00:1d.0: --> PCI D0/legacy
> [ 2815.639718] pci 0000:00:02.1: freeze
> [ 2815.639718] pci 0000:00:02.0: freeze
> [ 2815.639718] pci 0000:00:00.3: freeze
> [ 2815.639718] pci 0000:00:00.1: freeze
> [ 2815.639718] agpgart-intel 0000:00:00.0: freeze
> [ 2815.639718] acpi thermal:01: freeze
> [ 2815.639718] acpi thermal:00: freeze
> [ 2815.639718] acpi pnp0c14:00: freeze
> [ 2815.639718] acpi device:18: freeze
> [ 2815.639718] acpi device:17: freeze
> [ 2815.639718] acpi device:16: freeze
> [ 2815.639718] acpi device:15: freeze
> [ 2815.639718] acpi device:14: freeze
> [ 2815.639718] acpi device:13: freeze
> [ 2815.639718] acpi device:12: freeze
> [ 2815.639718] acpi device:11: freeze
> [ 2815.639718] acpi device:10: freeze
> [ 2815.639718] acpi device:0f: freeze
> [ 2815.639718] acpi device:0e: freeze
> [ 2815.639718] acpi device:0d: freeze
> [ 2815.639718] acpi device:0c: freeze
> [ 2815.639718] acpi device:0b: freeze
> [ 2815.639718] acpi SYN0110:00: freeze
> [ 2815.639718] acpi PNP0303:00: freeze
> [ 2815.639718] ec PNP0C09:00: freeze
> [ 2815.639718] acpi PNP0C02:00: freeze
> [ 2815.639718] acpi PNP0200:00: freeze
> [ 2815.639718] acpi PNP0C04:00: freeze
> [ 2815.639718] acpi PNP0B00:00: freeze
> [ 2815.639718] acpi PNP0000:00: freeze
> [ 2815.639718] acpi PNP0100:00: freeze
> [ 2815.639718] pci_link PNP0C0F:07: freeze
> [ 2815.639718] pci_link PNP0C0F:06: freeze
> [ 2815.639718] pci_link PNP0C0F:05: freeze
> [ 2815.639718] pci_link PNP0C0F:04: freeze
> [ 2815.639718] pci_link PNP0C0F:03: freeze
> [ 2815.639718] pci_link PNP0C0F:02: freeze
> [ 2815.639718] pci_link PNP0C0F:01: freeze
> [ 2815.639718] pci_link PNP0C0F:00: freeze
> [ 2815.639718] acpi device:0a: freeze
> [ 2815.639718] acpi device:09: freeze
> [ 2815.639718] acpi device:08: freeze
> [ 2815.639718] acpi device:07: freeze
> [ 2815.639718] acpi device:06: freeze
> [ 2815.639718] acpi device:05: freeze
> [ 2815.639718] acpi device:04: freeze
> [ 2815.639718] acpi device:03: freeze
> [ 2815.639718] acpi device:02: freeze
> [ 2815.639718] video video:00: freeze
> [ 2815.639718] acpi device:01: freeze
> [ 2815.639718] pci_root PNP0A03:00: freeze
> [ 2815.639718] button PNP0C0E:00: freeze
> [ 2815.639718] button PNP0C0D:00: freeze
> [ 2815.639718] battery PNP0C0A:00: freeze
> [ 2815.639718] ac ACPI0003:00: freeze
> [ 2815.639718] acpi device:00: freeze
> [ 2815.639718] processor ACPI0007:00: freeze
> [ 2815.639718] button button_power:00: freeze
> [ 2815.639718] acpi acpi_system:00: freeze
> [ 2815.639718] PM: snapshotting memory.
> [ 2815.639718] platform bluetooth: LATE freeze
> [ 2815.639718] iTCO_wdt iTCO_wdt: LATE freeze
> [ 2815.639718] serial8250 serial8250: LATE freeze
> [ 2815.639718] vesafb vesafb.0: LATE freeze
> [ 2815.639718] platform pcspkr: LATE freeze
> [ 2815.639718] sdhci 0000:01:09.4: LATE freeze
> [ 2815.639718] tifm_7xx1 0000:01:09.3: LATE freeze
> [ 2815.639718] ohci1394 0000:01:09.2: LATE freeze
> [ 2815.639718] yenta_cardbus 0000:01:09.0: LATE freeze
> [ 2815.639718] pci 0000:01:06.0: LATE freeze
> [ 2815.639718] pci 0000:01:00.0: LATE freeze
> [ 2815.639718] pci 0000:00:1f.6: LATE freeze
> [ 2815.639718] Intel ICH 0000:00:1f.5: LATE freeze
> [ 2815.639718] pci 0000:00:1f.3: LATE freeze
> [ 2815.639718] pci 0000:00:1f.0: LATE freeze
> [ 2815.639718] pci 0000:00:1e.0: LATE freeze
> [ 2815.639718] pci 0000:00:02.1: LATE freeze
> [ 2815.639718] pci 0000:00:02.0: LATE freeze
> [ 2815.639718] pci 0000:00:00.3: LATE freeze
> [ 2815.639718] pci 0000:00:00.1: LATE freeze
> [ 2815.639718] agpgart-intel 0000:00:00.0: LATE freeze
> [ 2815.639718] swsusp: critical section:
> [ 2815.639718] swsusp: Need to copy 124696 pages
> [ 2815.639718] swsusp: Normal pages needed: 114475 + 1024 + 24,
> available pages: 118745
> [ 2815.639718] Intel machine check architecture supported.
> [ 2815.639718] Intel machine check reporting enabled on CPU#0.
> [ 2815.639718] agpgart-intel 0000:00:00.0: EARLY resume
> [ 2815.639718] PCI: Calling quirk c01be2f7 for 0000:00:00.0
> [ 2815.639718] pci 0000:00:00.1: EARLY resume
> [ 2815.639718] PCI: Calling quirk c01be2f7 for 0000:00:00.1
> [ 2815.639718] pci 0000:00:00.3: EARLY resume
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> 
> 

-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

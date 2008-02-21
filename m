From: Alan Stern <stern@rowland.harvard.edu>
Subject: Strange delays during suspend
Date: Thu, 21 Feb 2008 16:47:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802211640230.2114-100000@iolanthe.rowland.org>
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
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Below is a dmesg log from a suspend test with pm_test set to 
"devices".  I have notated a few unaccountable delays.  Can anybody 
explain them?

Alan Stern



[  840.249145] PM: Syncing filesystems ... done.
[  840.249145] PM: Preparing system for mem sleep
[  840.250891] Freezing user space processes ... (elapsed 0.00 seconds) done.
[  840.252175] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
[  840.252448] PM: Entering mem sleep
[  840.252699] ACPI: Preparing to enter system sleep state S3
[  840.328163] sd 1:0:0:0: suspended
[  840.328246]  host1: suspended
[  840.335202] usb 2-2.3: usb suspend
[  840.349326] hub 2-2:1.0: hub_suspend
[  840.351377] uhci_hcd 0000:00:1d.1: release dev 2 ep81-INT, period 128, phase 0, 12 us
[  840.353410] usb 2-2: usb suspend
[  840.369254] hub 2-0:1.0: hub_suspend
[  840.369321] usb usb2: bus suspend
[  840.369389] usb usb2: suspend_rh

Here's an 878 ms delay.  Serial driver?

[  841.247855] serial 00:08: disabled
[  841.261353] ACPI: PCI interrupt for device 0000:01:01.2 disabled
[  841.277223] ehci_hcd 0000:01:01.2: --> PCI D3/wakeup
[  841.277314] uhci_hcd 0000:01:01.1: uhci_suspend
[  841.277457] ACPI: PCI interrupt for device 0000:01:01.1 disabled
[  841.293225] uhci_hcd 0000:01:01.1: --> PCI D3
[  841.293308] uhci_hcd 0000:01:01.0: uhci_suspend
[  841.293450] ACPI: PCI interrupt for device 0000:01:01.0 disabled
[  841.309225] uhci_hcd 0000:01:01.0: --> PCI D3
[  841.309393] ACPI: PCI interrupt for device 0000:01:00.2 disabled
[  841.325224] ehci_hcd 0000:01:00.2: --> PCI D3/wakeup
[  841.325397] ACPI: PCI interrupt for device 0000:01:00.1 disabled
[  841.341465] ohci_hcd 0000:01:00.1: --> PCI D3
[  841.341636] ACPI: PCI interrupt for device 0000:01:00.0 disabled
[  841.357225] ohci_hcd 0000:01:00.0: --> PCI D3
[  841.357661] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[  841.373244] ehci_hcd 0000:00:1d.7: --> PCI D3/wakeup
[  841.373342] uhci_hcd 0000:00:1d.2: uhci_suspend
[  841.373463] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[  841.373527] uhci_hcd 0000:00:1d.2: --> PCI D0/legacy
[  841.373591] uhci_hcd 0000:00:1d.1: uhci_suspend
[  841.373710] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[  841.373776] uhci_hcd 0000:00:1d.1: --> PCI D0/legacy
[  841.373873] uhci_hcd 0000:00:1d.0: uhci_suspend
[  841.373991] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[  841.374055] uhci_hcd 0000:00:1d.0: --> PCI D0/legacy
[  841.374316] suspend debug: Waiting for 5 seconds.

This is supposed to be 5 seconds, but it turned out to be 23 seconds 
instead.

[  864.420397] uhci_hcd 0000:00:1d.0: PCI legacy resume
[  864.420480] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
[  864.420606] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[  864.420719] uhci_hcd 0000:00:1d.0: uhci_resume
[  864.420792] uhci_hcd 0000:00:1d.1: PCI legacy resume
[  864.420862] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[  864.420983] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[  864.421095] uhci_hcd 0000:00:1d.1: uhci_resume
[  864.421186] uhci_hcd 0000:00:1d.2: PCI legacy resume
[  864.421255] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[  864.421377] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[  864.421488] uhci_hcd 0000:00:1d.2: uhci_resume
[  864.421571] ehci_hcd 0000:00:1d.7: resume from PCI D3
[  864.441529] PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
[  864.441598] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
[  864.441721] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[  864.441808] PM: Writing back config space on device 0000:00:1d.7 at offset f (was 400, writing 40a)
[  864.441921] PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, writing ffa7fc00)
[  864.442015] PM: Writing back config space on device 0000:00:1d.7 at offset 1 (was 2900006, writing 2900106)
[  864.442179] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[  864.442344] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
[  864.442574] ohci_hcd 0000:01:00.0: resume from PCI D3
[  864.458695] PCI: Enabling device 0000:01:00.0 (0000 -> 0002)
[  864.458764] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[  864.458931] PM: Writing back config space on device 0000:01:00.0 at offset 1 (was 2100006, writing 2100116)
[  864.459030] ohci_hcd 0000:01:00.0: powerup ports
[  864.482683] ohci_hcd 0000:01:00.1: resume from PCI D3
[  864.498675] PCI: Enabling device 0000:01:00.1 (0000 -> 0002)
[  864.498744] ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 22 (level, low) -> IRQ 22
[  864.498910] PM: Writing back config space on device 0000:01:00.1 at offset 1 (was 2100006, writing 2100116)
[  864.499009] ohci_hcd 0000:01:00.1: powerup ports
[  864.522686] ehci_hcd 0000:01:00.2: resume from PCI D3
[  864.538678] PCI: Enabling device 0000:01:00.2 (0000 -> 0002)
[  864.538746] ACPI: PCI Interrupt 0000:01:00.2[C] -> GSI 23 (level, low) -> IRQ 23
[  864.538913] PM: Writing back config space on device 0000:01:00.2 at offset 1 (was 2100006, writing 2100116)
[  864.539025] uhci_hcd 0000:01:01.0: resume from PCI D3
[  864.554679] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 22
[  864.554859] uhci_hcd 0000:01:01.0: uhci_resume
[  864.554940] uhci_hcd 0000:01:01.1: resume from PCI D3
[  864.570684] ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 21 (level, low) -> IRQ 21
[  864.570864] uhci_hcd 0000:01:01.1: uhci_resume
[  864.570944] ehci_hcd 0000:01:01.2: resume from PCI D3
[  864.586691] ACPI: PCI Interrupt 0000:01:01.2[C] -> GSI 20 (level, low) -> IRQ 20
[  864.602692] PM: Writing back config space on device 0000:01:08.0 at offset f (was 38080100, writing 3808010b)
[  864.602803] PM: Writing back config space on device 0000:01:08.0 at offset 5 (was 1, writing d801)
[  864.602890] PM: Writing back config space on device 0000:01:08.0 at offset 4 (was 0, writing ff8fc000)
[  864.602978] PM: Writing back config space on device 0000:01:08.0 at offset 3 (was 0, writing 2008)
[  864.603068] PM: Writing back config space on device 0000:01:08.0 at offset 1 (was 2900000, writing 2900117)
[  864.628107] serial 00:08: activated
[  864.630669] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[  866.630915] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

A delay of 1680 ms.  Disk spin-up?

[  868.311178] hda: UDMA/100 mode selected
[  868.313681] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4

And another similar delay.

[  871.562230] hdb: UDMA/100 mode selected
[  871.563103] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[  871.563103] hdc: UDMA/33 mode selected
[  871.921139] usb usb2: usb resume
[  871.921201] usb usb2: wakeup_rh
[  871.959142] hub 2-0:1.0: hub_resume
[  871.959406] uhci_hcd 0000:00:1d.1: port 2 portsc 0095,01
[  871.975140] usb 2-2: finish reset-resume
[  872.087166] usb 2-2: reset full speed USB device using uhci_hcd and address 2
[  872.223166] usb 2-2: ep0 maxpacket = 8
[  872.243129] hub 2-2:1.0: enabling power on all ports
[  872.349129] uhci_hcd 0000:00:1d.1: reserve dev 2 ep81-INT, period 128, phase 0, 12 us
[  872.367164] usb 2-2.3: finish reset-resume
[  872.441120] usb 2-2.3: reset full speed USB device using uhci_hcd and address 3
[  872.553174]  host1: resumed
[  872.553245] sd 1:0:0:0: resumed
[  872.555243] PM: Finishing wakeup.
[  872.555311] Restarting tasks ... <7>hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  872.555950] hub 2-2:1.0: state 7 ports 4 chg 0000 evt 0008
[  872.560625] done.

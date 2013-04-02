From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: suspended DRAM bridge
Date: Tue, 02 Apr 2013 16:30:05 +0200
Message-ID: <515AEB6D.3020502@fold.natur.cuni.cz>
References: <5159BAC9.80700@fold.natur.cuni.cz> <35938665.ZFvDxnCU3l@vostro.rjw.lan> <5159F775.30805@fold.natur.cuni.cz> <1461283.gKidiaRK7T@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:58956 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761021Ab3DBOaJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Apr 2013 10:30:09 -0400
In-Reply-To: <1461283.gKidiaRK7T@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Rafael J. Wysocki wrote:
> Now, if you want me (or anyone else on this list) to help you, why don't you
> test 3.9-rc5 with the patch at https://patchwork.kernel.org/patch/2368081/
> applied and send *one* message describing *briefly* what *does* *not* *work*
> for you, without attaching any logs, lspci outputs and so on just yet?
> 
> Then, we can try to address the problems you have in 3.9-rc5 and go back to the
> (still supported) 'stable' kernels from there.

So, I tried 3.9-rc5 with the above patch and neither of my issues with dead xHCI
port nor pciehp being completely broken fixed. I did not test whether there is an
improvement on the acpiphp side (which was a regression in 3.8 compared to 3.7).
I tested all under laptop-mode-tools which enabled the powersaving.



The xHCI issue while pcie_aspm=off:
An unplug of a mouse results in:

/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
[cut]
-/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
+/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended

After the unplug the TI chip does not detect a device being re-connected to the port
while it is suspended. I think this just repeats what Sarah already said. Either 'lsusb -v'
or 'echo on > /sys/bus/pci/devices/0000:0b:00.0/power/control' recover from the problem.
That also ensures the dead port does not happen again upon next USB device unplug.
Either pcieport should deny suspend of the particular device underneath or xhci_hcd
should do it by itself as it actually caused the suicide itself.




The eSATA-card based pciehp testing while pcie_aspm=off:
Although 1c.7 and 11:00 were not suspended an eject of the cold-plugged card was unnoticed.
That results in /proc/iomem and /proc/interrupts reporting old values claiming the cold-boot
status did not change during hot eject.
'lspci -vvv' reports 0xff values for a broken 11:00 entry which covers only the very first
line of an entry (like lspci without extra verbosity).
Then, rmmod sata_sil24 removes just the driver association with memory ranges
assigned to it but the 11:00 device remains in /proc/iomem with its memory ranges.
At the same time /proc/interrupts claims IRQ 19 was released (if we can trust it).
If it's unclear, due to those 0xff one cannot squeeze any details from lspci.
In dmesg just the rmmod caused some new lines (confirming the eject was unnoticed).

Subsequent hot insert of the card does not result in IRQ being obtained if we trust
/proc/interrupts claimed it was never released. But, lspci shows it received
IRQ 19 and compared to cold-booted state with a card inserted and driver loaded,
'Latency: 0, Cache Line Size: 64 bytes' does not appear anymore in 'lspci -vvv'
describing the hot plugged card. Actually, the whole line is gone.

During the hot insert a driver was not loaded so manual modprobe sata_sil24 loads the
driver but the driver is failing already during its init with 'enabling device (0000 -> 0003)'
and 'failed to clear port RST' while it claims it is using IRQ 19.
Loading of the driver caused 'Latency: 0' line to pop up in 'lspci -vvv' for the 11:00 device.

Attaching a SATA drive to the eSATA card is not noticed anywhere.

Subsequent rescan-scsi-bus call from a shell does not help, sata_sil24 tries same procedure
like during its initialization which failed. So it fails again. SATA disk attached to the card
is not detected, link remains down.



I could have distilled more out of the log files but you wanted the answer to be brief,
so, in brief, it still doesn't work.


Because this goes only to you two and linux-pm, please let me know whether linux-pci
and linux-acpi should be updated on this. They got quite a lot of info last days/weeks
and this email goes to maybe a lot other people and avoid those who were already involved.
I will leave it up to you. Just a note.

Martin

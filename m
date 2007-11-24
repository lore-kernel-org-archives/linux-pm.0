From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: cannot resume using USB keyboard/mouse
Date: Sat, 24 Nov 2007 19:26:05 +0200
Message-ID: <200711241926.05105.maximlevitsky@gmail.com>
References: <4747C169.10807@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4747C169.10807@cs.wisc.edu>
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
List-Id: linux-pm@vger.kernel.org

On Saturday 24 November 2007 08:15:05 Ben Liblit wrote:
> When I suspend my desktop box, I cannot resume again by pressing a key 
> on my USB keyboard or clicking a button on my USB mouse.  I have to 
> press the chassis power button to wake things up again.  (I'd expect 
> this to be necessary after hibernation, but not after suspend.)  The 
> same machine resumes from suspend using keyboard or mouse buttons under 
> Vista, so I know this is something that the hardware is capable of.
> 
> Is this a bug?  Or is there some local configuration tweak I should be 
> making to tell the system to wake up in response to USB key presses & 
> mouse clicks?
> 
> I'm running Fedora 8, with a Fedora-provided kernel version 
> 2.6.23.1-49.fc8.  Attached below is a pruned-down hardware description 
> (from lshw) showing the mouse and keyboard, plus other buses and bridges 
> by which they are connected.  Are there any other useful details I can 
> provide?
> 
> Thanks!
> 
> -- Ben
> 


You probably need to tell the system which devices can do the wakeup.
To do so first do a "cat /proc/acpi/wakeup".

and then write corresponding device name (the first column) to that file
(under root)

For example, mine /proc/acpi/wakeup:

maxim@MAIN:~$ cat /proc/acpi/wakeup
Device  S-state   Status   Sysfs node
SLPB      S4    *enabled
P32       S4     enabled   pci:0000:00:1e.0
UAR1      S4     enabled   pnp:00:0a
ILAN      S4     enabled   pci:0000:00:19.0
PEGP      S4     enabled   pci:0000:00:01.0
PEX0      S4     enabled   pci:0000:00:1c.0
PEX1      S4     enabled   pci:0000:00:1c.1
PEX2      S4     enabled   pci:0000:00:1c.2
PEX3      S4     enabled   pci:0000:00:1c.3
PEX4      S4     enabled   pci:0000:00:1c.4
PEX5      S4     enabled
UHC1      S3     enabled   pci:0000:00:1d.0
UHC2      S3     enabled   pci:0000:00:1d.1
UHC3      S3     enabled   pci:0000:00:1d.2
UHC4      S3     enabled
EHCI      S3     enabled   pci:0000:00:1d.7
EHC2      S3     enabled   pci:0000:00:1a.7
UH42      S3     enabled   pci:0000:00:1a.0
UHC5      S3     enabled   pci:0000:00:1a.1
AZAL      S3     enabled   pci:0000:00:1b.0
maxim@MAIN:~$


the UHC1-5, EHCI and EHC2 are the usb1.0 resume devices (ports)
so I can do

echo "UHC1" > /proc/acpi/wakeup
echo "UHC2" > /proc/acpi/wakeup

....


And then check whenever the "status" column" shows "enabled"

Note: some resume devices are connected together:

For example doing 'echo "ILAN" > /proc/acpi/wakeup' enables the 
LAN , EHCI , AZAL.

So my script that enables all wakeup devices is:


#! /bin/bash

echo "UHC1" > /proc/acpi/wakeup		# ICH8 UHCI1
echo "UHC2" > /proc/acpi/wakeup		# ICH8 UHCI2
echo "UHC3" > /proc/acpi/wakeup		# ICH8 UHCI3
echo "UHC4" > /proc/acpi/wakeup		# ICH8 UHCI4
echo "UHC5" > /proc/acpi/wakeup		# ICH8 UHCI5

echo "ILAN" > /proc/acpi/wakeup		# ICH8 internal (lan/HDA/EHCI)
echo "P32" >  /proc/acpi/wakeup 	# ICH8 external (PCI/PCI express)
echo "UAR1" > /proc/acpi/wakeup		# SUPERIO (UART/Sleep button)

And last thing, writing to /proc/acpi/wakeup a device name that is already enabled,
disables it, so if I for example run the above script twice (with wakeup devices disabled), all wakeup devices will be disabled again.

Best regards,
	Maxim Levitsky

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Thu, 1 Jul 2010 01:40:08 +0200
Message-ID: <201007010140.08158.rjw@sisk.pl>
References: <1277940699.4138.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277940699.4138.29.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 01, 2010, Maxim Levitsky wrote:
> Hi,
> 
> 
> This is my desktop, and I don't use it much.
> I updated the kernel from 2.6.33 to 2.6.35-rc3, and my usb mouse (usb
> 1.1 of course) doesn't wake the system anymore.

Please wait for 2.6.35-rc4 to appear and see if there's any difference.

> I used (and still do) to enable wakeup via /proc/acpi/wakeup.
> 
> 
> maxim@MAIN:~$ cat bin/system/wake_all 
> #! /bin/bash
> 
> echo "UHC1" > /proc/acpi/wakeup		# ICH8 UHCI1
> echo "UHC2" > /proc/acpi/wakeup		# ICH8 UHCI2
> echo "UHC3" > /proc/acpi/wakeup		# ICH8 UHCI3
> echo "UHC4" > /proc/acpi/wakeup		# ICH8 UHCI4
> echo "UHC5" > /proc/acpi/wakeup		# ICH8 UHCI5
> 
> echo "ILAN" > /proc/acpi/wakeup		# ICH8 internal (lan/azal//EHCI)
> echo "P32" >  /proc/acpi/wakeup 	# ICH8 external (PCI/PCI express)
> echo "UAR1" > /proc/acpi/wakeup		# SUPERIO (UART/Sleep button)

That shouldn't be necessary.

> I checked, and it looks like power/wakeup attributes are enabled:
> 
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0# cat power/wakeup 
> enabled
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0# cd usb5/
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5# cat power/wakeup 
> enabled
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5# cd 5-1/
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1# cat power/wakeup 
> enabled <--- this I set manually to enabled, didn't help
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1# cat id
> idProduct  idVendor   
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1# cat idVendor 
> 1241
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1# lsusb
> Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 005 Device 003: ID 06a3:ff52 Saitek PLC Cyborg 3D Rumble Force Joystick
> Bus 005 Device 002: ID 1241:1166 Belkin MI-2150 Trust Mouse
> Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> root@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1# 
> 
> maxim@MAIN:~$ cat /proc/acpi/wakeup 
> Device	S-state	  Status   Sysfs node
> SLPB	  S4	*enabled   
> P32	  S4	*enabled   pci:0000:00:1e.0
> UAR1	  S4	*enabled   pnp:00:0a
> ILAN	  S4	*enabled   pci:0000:00:19.0
> PEGP	  S4	*enabled   
> PEX0	  S4	*enabled   pci:0000:00:1c.0
> PEX1	  S4	*enabled   pci:0000:00:1c.1
> PEX2	  S4	*enabled   pci:0000:00:1c.2
> PEX3	  S4	*enabled   pci:0000:00:1c.3
> PEX4	  S4	*enabled   pci:0000:00:1c.4
> PEX5	  S4	*enabled   
> UHC1	  S3	*enabled   pci:0000:00:1d.0
> UHC2	  S3	*enabled   pci:0000:00:1d.1
> UHC3	  S3	*enabled   pci:0000:00:1d.2
> UHC4	  S3	*enabled   
> EHCI	  S3	*enabled   pci:0000:00:1d.7
> EHC2	  S3	*enabled   pci:0000:00:1a.7
> UH42	  S3	*enabled   pci:0000:00:1a.0
> UHC5	  S3	*enabled   pci:0000:00:1a.1
> AZAL	  S3	*enabled   pci:0000:00:1b.0
> 
> 
> maxim@MAIN:~$ lsusb -t
> /:  Bus 07.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
>     |__ Port 1: Dev 2, If 0, Class=HID, Driver=usbhid, 1.5M
>     |__ Port 2: Dev 3, If 0, Class=HID, Driver=usbhid, 1.5M
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=uhci_hcd/2p, 12M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/6p, 480M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/4p, 480M
> 
> 
> 
> I don't have much time now for testing, but will try my best to do so.

Rafael

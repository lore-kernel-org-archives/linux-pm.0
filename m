From: Jan Dittmer <jdi@l4x.org>
Subject: Suspend to RAM, Sony Vaio PCG-SRX51P, lcd stays off
Date: Thu, 15 Feb 2007 11:23:05 +0100
Message-ID: <45D43489.3060409@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: stelian@popies.net, linux-acpi@vger.kernel.org, linux-pm@osdl.org, adaplas@pol.net, dawes@xfree86.org
Cc: Linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi there,

I own an older Sony Vaio SRX51P, European Model, P3 based. s2ram
identifies it with

    sys_vendor   = "Sony Corporation    "
    sys_product  = "PCG-SRX51P(DE)      "
    sys_version  = "01                  "
    bios_version = "R0232U2"

Suspend to RAM by using "s2ram -v -m -f" actually works and the
laptop comes back to life, is accessible by network, etc. kudos
so far.
The only but serious problem is, that the lcd stays off after
resume. No matter what kind of options for s2ram I try, if I disable
framebuffer or suspend from X, the lcd always stays off. Only
a reboot fixes this. Note that the X driver also cannot dis-/enable
the lcd (xset dpms force off). It always stays lit. I also tried
with i810switch, but that also does not affect the lcd.
spicctrl -b42 neither.
Latest kernel I tested is 2.6.20-git11 from today.

So has anyone of you suspend, acpi, sonypi, fb people an idea how to fix
this? I suspect one has to call some magic ACPI method upon resume? What
other kind of information would be needed to debug this? Anything more
to try? Are there some sony people here listening who can fix this?

Thanks very much for any help,

Jan

$ lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 11)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller] (rev 11)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (LPC) (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 03)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 03)
00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'97 Audio (rev 03)
00:1f.6 Modem: Intel Corporation 82801BA/BAM AC'97 Modem (rev 03)
01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
01:02.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
01:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
01:08.0 Ethernet controller: Intel Corporation 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)

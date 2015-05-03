From: Martin Steigerwald <martin@lichtvoll.de>
Subject: [REGRESSION] 4.1-rc1/2 does not resume from hibernation, but boots instead
Date: Sun, 03 May 2015 11:59:55 +0200
Message-ID: <52990593.XOLBz6C9Fx@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:36568 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbECJ76 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2015 05:59:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

Its just as this:

Linux 4.0: It writes hibernation image and resumes (sometimes with that 
black screen doing nothing delay 
https://bugzilla.kernel.org/show_bug.cgi?id=94241).

Linux 4.1 as of 4a152c3913fb46fc2e29081d0251862106c3d55f: It writes 
hibernation image and does not resume. Instead it boots as if no hibernation 
image would have been written, but from what I can see it does write the 
image. I see the 10% progress steps being printed out.




ThinkPad T520:

martin@merkaba:~> phoronix-test-suite system-info

Phoronix Test Suite v5.2.1
System Information

Hardware:
Processor: Intel Core i5-2520M @ 3.20GHz (4 Cores), Motherboard: LENOVO 
42433WG, Chipset: Intel 2nd Generation Core Family DRAM, Memory: 16384MB, 
Disk: 300GB INTEL SSDSA2CW30 + 480GB Crucial_CT480M50, Graphics: Intel HD 
3000 (1300MHz), Audio: Intel 6 /C200, Monitor: P24T-7 LED, Network: Intel 
82579LM Gigabit Connection + Intel Centrino Advanced-N 6205

Software:
OS: Debian unstable, Kernel: 4.0.0-tp520-btrfs-trim+ (x86_64), Desktop: KDE 
4.14.2, Display Server: X Server 1.16.4, Display Driver: intel 2.21.15, 
OpenGL: 3.3 Mesa 10.4.2, Compiler: GCC 4.9.2, File-System: btrfs, Screen 
Resolution: 3840x1080



Attached find xz compressed excerpt of kern.log with last 4.1 cycle as well 
as 4.0 cycle.

It says

PM: Hibernation image not present or could not be loaded.

for the 4.1 case. It says so on the first boot of 4.0 again as well, but then 
it works as you can see later in the log.


Attached also find kernel configuration for 4.0 and 4.1. They are vanilla 
except one (4.0) or two (4.1) BTRFS related patches.


Userspace is Debian Sid

merkaba:~> apt-show-versions | egrep "pm-utils|^systemd:"
pm-utils:all/sid 1.4.1-15 uptodate
systemd:amd64/experimental 219-8 uptodate
systemd:i386 not installed

In kernel hibernation is used (no userspace assisted hibernation):

merkaba:~> cat /etc/pm/config.d/sleepmodule.conf 
SLEEP_MODULE=kernel

merkaba:~> cat /proc/cmdline 
BOOT_IMAGE=/vmlinuz-4.0.0-tp520-btrfs-trim+ root=/dev/mapper/sata-debian ro 
rootflags=subvol=debian resume=/dev/mapper/sata-swap init=/bin/systemd 
no_console_suspend

According to grub.cfg it should be the same with 4.1:

linux   /vmlinuz-4.1.0-rc1-tp520-btrfs-trim-norace+ root=/dev/mapper/sata-
debian ro rootflags=subvol=debian  resume=/dev/mapper/sata-swap 
init=/bin/systemd no_console_suspend


Back to 4.0 as I need this laptop for production next week.

Thanks,
-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

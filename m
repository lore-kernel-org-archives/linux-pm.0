From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 21 Oct 2015 23:00:49 +0000
Message-ID: <bug-103351-137361-rIx2K37SMt@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36805 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbbJUXA4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Oct 2015 19:00:56 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 772492089C
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 23:00:53 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 56650208ED
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 23:00:52 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #90 from matthew.dewitt@gmail.com ---
Hello friends...

This still isn't working for me. Can you point out my mistake?

bash-4.2# cat /usr/src/linux/.config | grep MICRO
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_MICROCODE_INTEL_LIB=y
CONFIG_MICROCODE_INTEL_EARLY=y
CONFIG_MICROCODE_EARLY=y
CONFIG_NFC_MICROREAD=m
CONFIG_PATA_JMICRON=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_HID_MICROSOFT=m
CONFIG_USB_MICROTEK=m
CONFIG_MEMSTICK_JMICRON_38X=m
bash-4.2#


downloaded the 5700hq-ucode.tar.gz file in this thread. This file contains
four .bin files.


bash-4.2# cd
bash-4.2# cd microcode/
bash-4.2# ls -al
total 172
drwxr-xr-x 2 root root 4096 Oct 21 18:53 .
drwx--x--- 23 root root 4096 Oct 21 18:58 ..
-rw-r--r-- 1 1000 1000 21504 Sep 30 01:32 2494656.bin
-rw-r--r-- 1 1000 1000 22528 Sep 30 01:32 2516160.bin
-rw-r--r-- 1 1000 1000 24576 Sep 30 01:32 2538688.bin
-rw-r--r-- 1 1000 1000 10240 Sep 30 01:32 2563264.bin
-rw-r--r-- 1 root root 78384 Oct 21 18:46 5700hq-ucode.tar.gz
bash-4.2# iucode_tool -Sl -K --overwrite
--write-earlyfw=/boot/intel-ucode.img *.bin
iucode_tool: system has processor(s) with signature 0x00040671
selected microcodes:
001: sig 0x00040671, pf mask 0x22, 2015-03-27, rev 0x000d, size 10240
iucode_tool: Writing selected microcodes to: /boot/intel-ucode.img
iucode_tool: Writing microcode firmware file(s) into
/lib/firmware/intel-ucode
bash-4.2#


(I have also tried iucode_tool --scan-system
--write-earlyfw=/boot/ucode.cpio /lib/firmware/ )


bash-4.2# cat /etc/lilo.conf | grep intel
initrd = /boot/intel-ucode.img

bash-4.2# lilo
Warning: LBA32 addressing assumed
Added Linux + *
Added Recovery
One warning was issued.

bash-4.2#


And when I reboot....


bash-4.2# dmesg | grep early
bash-4.2# dmesg | grep micro
[ 0.598123] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x19
[ 0.598315] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x19
[ 0.598501] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x19
[ 0.599050] microcode: Microcode Update Driver: v2.00 <
tigran@aivazian.fsnet.co.uk>, Peter Oruba
bash-4.2# grep microcode /proc/cpuinfo
microcode : 0x19
microcode : 0x19
microcode : 0x19
bash-4.2#

On Wed, Oct 21, 2015 at 4:58 PM, <bugzilla-daemon@bugzilla.kernel.org>
wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=103351
>
> --- Comment #89 from kernel@benjam.info <kernel@benjam.info> ---
> Correction: When I say the microcode update fixes things, I mean the
> microcode
> update on BDW solves it on BDW. The BDW microcode update won't do anything
> on
> SKL. I don't have a copy of the SKL microcode updates, but if someone has a
> UEFI binary and want me to, I could extract them.
>
> --
> You are receiving this mail because:
> You are on the CC list for the bug.
>

-- 
You are receiving this mail because:
You are the assignee for the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 08 Oct 2015 16:36:06 +0000
Message-ID: <bug-103351-137361-VJ6ZerWYhk@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33484 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933103AbbJHQgO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 12:36:14 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 40767205CD
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 16:36:13 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 8ABDC205C2
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 16:36:10 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #48 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Alexey,

I have no idea why it is taking so long for Intel to release a new "linux
microcode update package", and I certainly agree that Intel dragging their feet
on this is hurting end-users.  It is not like motherboard vendors do a proper
job of issuing firmware updates.


Anyway, here's how to deploy early microcode updates, Arch-style.

1. Install iucode_tool.

If your Linux distro already has it, just use the one provided by your distro.

Otherwise, get the source code and compile it with "./configure ; make", and
copy the iucode_tool binary to somewhere in your PATH (e.g. using "make
install" as root).  It only needs glibc, gcc and make to build.

The iucode_tool source code tarball is available from:
https://gitlab.com/iucode-tool/releases/tree/latest


2. Update or create the early-initramfs image with the microcode update:

iucode-tool -Sl --overwrite --write-earlyfw=/boot/intel-ucode.img
/lib/firmware/intel-ucode my-new-microcodes.bin

It will consider any microcodes in /lib/firmware/intel-ucode, as well as any
microcodes in the ".bin" files you give it on the command line (I used
"my-new-microcodes.bin" in the example).  You can list as many files as you
want.


3. Set up grub to load the microcodes as per the *Arch-Linux* recommendation
(i.e. using a separate initramfs image for microcode):

https://wiki.archlinux.org/index.php/Microcode


If your distro uses the "single initramfs" mode of early microcode updates
(Debian, Ubuntu, Fedora), this should *override* the early-initramfs microcode
update provided by the distro:  AFAIK, the kernel uses the first early
microcode update datafile it finds.

For this reason, make sure to regenerate intel-ucode.bin every time you get a
new microcode update package from your distro.  You should probably discontinue
its use and switch back to the distro microcode distribution should it start
shipping recent enough microcode for your processor.

-- 
You are receiving this mail because:
You are the assignee for the bug.

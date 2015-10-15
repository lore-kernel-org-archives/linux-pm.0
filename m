From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 01:05:23 +0000
Message-ID: <bug-103351-137361-VWyQfl6nkW@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60452 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbbJOBF2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 21:05:28 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A0E022073E
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 01:05:27 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B420852
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 01:05:26 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #65 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
General Warning:

Some of the microcodes mentioned in this thread, particularly the revision 0x13
microcode for the Core i5/i7-5xxxHQ and Core i5/i7 5x75C, 5x75R, *have strict
requirements* for safe installation.

These microcodes disable Intel TSX-NI when loaded.  On any system where glibc
was compiled with lock elision enabled, these microcodes *must* be installed
through either a BIOS update, or through the early microcode loader (at least
for the time being).

Do *not* install these microcodes to a standard initramfs.  It can render the
system unbootable should it crash systemd or udev inside the standard
initramfs.  You *must* use an early-initramfs to safely apply such microcode
updates.

For safety, I strongly recommend that they should not be added to
/lib/firmware/intel-ucode with standard names.  Debian and Ubuntu rename such
microcode by appending ".initramfs" to their names, for example: iucode-tool
won't care and will still install them to the early-initramfs, but the kernel
microcode module will not find them, rendering them safe.

If you fail install such microcode correctly in a system with a
lock-elision-enabled glibc, it will instantly crash systemd, udev, and anything
else linked to libpthreads when the microcode update is loaded.

Eventually, Debian, Ubuntu and Fedora are likely to blacklist lock elision for
Broadwell processors in glibc, just like it was done for Haswell.  With that
blacklist in place, glibc won't crash even if the update is applied at an
inappropriate time (after the kernel booted).  But AFAIK nobody has updated the
glibc blacklist to add broadwell processors, yet.

So, please use an early-initramfs for microcode updates, and enjoy a far more
stable system ;-)

-- 
You are receiving this mail because:
You are the assignee for the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 09 Nov 2015 12:39:39 +0000
Message-ID: <bug-103351-137361-wqdOGuvTtk@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56034 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbbKIMjr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 07:39:47 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 273CA2070B
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2015 12:39:46 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 9CC392078A
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2015 12:39:42 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #98 from Carlos Alberto Lopez Perez <clopez@igalia.com> ---
(In reply to okjwukwh from comment #97)
> Using a Broadwell i7-5600U on OpenSuse Leap 42.1 may also provoke the lock
> elision error.
> 
> At the moment I cannot tell how libc is built; from the contents of the rpms
> I would guess that --enable-lock-elision is used.
> 
> Crashes so far only happen, when using a NVIDIA proprietary driver (tried
> version 352* and 349* - same result). So it may be a problem with the
> driver. But as of the [1] it should be ok when using a version < 352* which
> it's not in my case.
> 

I'm inclined to believe this is a bug on the proprietary driver.
You probably can workaround it, by building libc without HLE support.

I reported this to NVIDIA two weeks ago after the discussion at:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=800574#77

No reply from NVIDIA so far.

Question Reference #151027-000203
---------------------------------------------------------------
  Product Level 1: GeForce graphics
     Date Created: 10/27/2015 09:29 AM
     Last Updated: 10/27/2015 09:29 AM
           Status: New
        Choose OS: Linux/Other Unix
     Product Name: NVIDIA Driver Linux x64
   Driver Version: 352.55
             Rank: 1
         Escalate: 
---------------------------------------------------------------
The driver crashed on EGL programs when glibc is built with support for RLE and
a CPU with TSX-NI enabled instructions is used (for example: i7-5775C).

The crash seems to be caused because the driver is trying to unlock an already
unlocked lock. This is undefined behavior and a bug on the driver.
When TSX-NI is enabled on glibc it leads to a crash.

How to reproduce it?
Try to run an EGL program, for example: es2_info from mesa-demos (debian/ubuntu
package: mesa-utils-extra:) on a Linux system (ADM64) with a glibc that enables
the usage of HLE (Hardware Lock Elision) by default for libpthread when the CPU
supports that (for example  i7-5775C).

-- 
You are receiving this mail because:
You are the assignee for the bug.

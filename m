From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 01 Oct 2015 20:09:00 +0000
Message-ID: <bug-103351-137361-xuq17ZbEaF@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56235 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbbJAUJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 16:09:05 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 63534207E1
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 20:09:03 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 81B6E207C5
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 20:09:02 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

--- Comment #34 from Krist=C3=B3f Marussy <kris7topher@gmail.com> ---
This kind of fix should be probably applied before init is ran so that =
if some
cpuinfo flags are changed, they are properly exposed event to early use=
rspace.
I think you should load the .bin with the kernel early microcode loadin=
g
facility: https://www.kernel.org/doc/Documentation/x86/early-microcode.=
txt

Note that multiple initrd files can be passed to the kernel, so there i=
s no
need to concatenate the microcode cpio with the original initrd, see e.=
g.
https://wiki.archlinux.org/index.php/Microcode

--=20
You are receiving this mail because:
You are the assignee for the bug.
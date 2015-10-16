From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 17:17:52 +0000
Message-ID: <bug-103351-137361-NmfLj6qsfi@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50742 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbbJPRR5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 13:17:57 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7F845209E5
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 17:17:56 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 6787C209E7
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 17:17:54 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #79 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
It is nearly impossible for someone not @intel to create malicious microcode.

It is trivial to lie to tools like iucode-tool and even the kernel... so you
could create something that looks like microcode revision "A" but it is really
microcode revision "B", or falsify the microcode date, so that it looks like it
is newer or older.

But that doesn't make any difference to the processor. It doesn't care, in fact
it doesn't even get sent that data by the kernel driver.  The processor
validates by itself the microcode signature and pf mask, and it is all part of
the signed data which only Intel can create.  You cannot force an Intel
processor to install unsuitable microcode.  You *can* cause it to crash if you
do it in a very specific way (that cannot happen by accident), but that's it.

And once a microcode update is accepted, the processor *will* report its real
revision, and that's what /proc/cpuinfo and the log messages will show.

That said, the SHA256 of the relevant microcodes for this thread are (in
iucode_tool "--write-named-to" filename notation).

HASWELL (likely MCE fix):
449641e821abceb4b7321a4374be2e136e3a6c474c8ca2855ee387c889db3201 
s000306C3_m00000032_r0000001D.fw

BROADWELL (likely MCE fix, maybe Intel TSX fix):
fed4431ae91f19bd9346428cc33b9ac6d4364c26b1ef221427738fce53d51525 
s000306D4_m000000C0_r00000021.fw

BROADWELL-H (MCE fix, maybe Intel TSX fix):
b2fa8638b92fd3b99e6f29e485da38c9abc009ae003918c679fcd428ae1b3c64 
s00040671_m00000022_r00000012.fw
e80e12dd77551813253903fc6da068faad32abb78424bf96b9765141a8dab2a1 
s00040671_m00000022_r00000013.fw

SKYLAKE (MCE fix, Intel TSX fix, other fixes):
4784f5feb717aef4d750315f7a4d2d4d6f8fc67562b864c1ec40393a0705ca7a 
s000506E3_m00000036_r00000034.fw
b20822210a31529135106b8822e84973d1446159a7473f6d5f839d6aa5a6d2df 
s000506E3_m00000036_r0000003A.fw

-- 
You are receiving this mail because:
You are the assignee for the bug.

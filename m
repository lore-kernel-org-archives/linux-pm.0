From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sun, 15 Nov 2015 15:35:24 +0000
Message-ID: <bug-103351-137361-LSoyQ0FoSC@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43985 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbKOPfb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 15 Nov 2015 10:35:31 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2D764206AF
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2015 15:35:29 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0FA5720698
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2015 15:35:28 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #101 from sac <sdfjk40sdnmxyl@mailinator.com> ---
(In reply to tcl_de from comment #100)
> (In reply to sac from comment #54)
> > Unfortunately not even the mainboard vendor BIOS changelogs are reliable. My
> > Asrock H97 Performance lists an BIOS update with 2.40 "Update Microcode 19."
> > (0x13h), however if you extract the microcode update with MMTool you get
> > Microcode 16. (0x10h). Exactly the same that was already included in BIOS
> > 2.30.
> 
> Just a quick remark: 19 in Update Microcode 19 is already hexadecimal and
> refers to the Haswell Microcode revision

Thanks, but for 1150 Asrock H97 Performance users it would be great to get an
Microcode update as well (and not to be stuck with 0671/10 from 2015/05/07 that
suffers not only from these MCE but also elision lock crashes).

BTW: thanks to UBU I was able to inject Microcode 0671/13 into the UEFI. MCE
still fixed, but still elision lock crashes (as confirmed earlier in this
thread for this Microcode).

-- 
You are receiving this mail because:
You are the assignee for the bug.

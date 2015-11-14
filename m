From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sat, 14 Nov 2015 13:43:51 +0000
Message-ID: <bug-103351-137361-hmzz8OqeFl@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40883 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbbKNNn5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 14 Nov 2015 08:43:57 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BA5FF2064B
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2015 13:43:56 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id C83AA206A0
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2015 13:43:54 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

tcl_de@gmx.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tcl_de@gmx.net

--- Comment #100 from tcl_de@gmx.net ---
(In reply to sac from comment #54)
> Unfortunately not even the mainboard vendor BIOS changelogs are reliable. My
> Asrock H97 Performance lists an BIOS update with 2.40 "Update Microcode 19."
> (0x13h), however if you extract the microcode update with MMTool you get
> Microcode 16. (0x10h). Exactly the same that was already included in BIOS
> 2.30.

Just a quick remark: 19 in Update Microcode 19 is already hexadecimal and
refers to the Haswell Microcode revision

-- 
You are receiving this mail because:
You are the assignee for the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 09 Oct 2015 08:48:58 +0000
Message-ID: <bug-103351-137361-in04T8gQBJ@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50316 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933491AbbJIItE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 9 Oct 2015 04:49:04 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 596B72081F
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2015 08:49:02 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 09B0920887
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2015 08:49:01 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #54 from sac <sdfjk40sdnmxyl@mailinator.com> ---
Unfortunately not even the mainboard vendor BIOS changelogs are reliable. My
Asrock H97 Performance lists an BIOS update with 2.40 "Update Microcode 19."
(0x13h), however if you extract the microcode update with MMTool you get
Microcode 16. (0x10h). Exactly the same that was already included in BIOS 2.30.

In addition, I've read some guides where someone modded the vendor BIOS to
include the latest Microcode Updates (only Win, because all my Lux is currently
not working because of this old Microcode MCE :()
http://donovan6000.blogspot.de/2013/06/insyde-bios-modding-cpu-microcodes.html

Has anyone tried modding an UEFI AMI BIOS directly, successfully?

-- 
You are receiving this mail because:
You are the assignee for the bug.

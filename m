From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 08 Oct 2015 11:53:35 +0000
Message-ID: <bug-103351-137361-9VZbJ07Wgl@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40638 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbbJHLxl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 07:53:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 75D0620610
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 11:53:40 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 24A25207ED
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 11:53:38 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #47 from Alexey Dyachenko <adotfive@gmail.com> ---
I would gladly do realy updates (as a matter of fact I encountered panics
during boot before microcode update unit got triggered), its just I don't know
how to do that with a bunch of *.bin files hacked from other vendor BIOS, Arch
provides intel-ucode.img with official microcode update.

Intel should release proper microcode update so users that bought their broken
hardware could work.

-- 
You are receiving this mail because:
You are the assignee for the bug.

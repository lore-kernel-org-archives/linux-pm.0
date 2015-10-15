From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 13:19:20 +0000
Message-ID: <bug-103351-137361-Obwwcc74gA@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49303 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbbJONT0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 09:19:26 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id EDE5F20883
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:19:24 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 22FC12087E
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:19:23 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #67 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
(In reply to Fredrik Atmer from comment #64)
> I got it, I think. I moved all files in /lib/firmware/intel-ucode before
> running install.sh and now when I reboot I get the early update, from dmesg
> | grep early
> 
> [    0.000000] CPU0 microcode updated early to revision 0x13, date =
> 2015-08-03

Fredrik, could you post your /proc/cpuinfo with revision 0x13, please?

-- 
You are receiving this mail because:
You are the assignee for the bug.

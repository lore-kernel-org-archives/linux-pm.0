From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 31 Aug 2015 08:15:14 +0000
Message-ID: <bug-103351-137361-xazoTr2Iyb@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41163 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbHaIPT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 04:15:19 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 427B620664
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2015 08:15:15 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 4AE5420660
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2015 08:15:14 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Richard Liu <richliu@techarea.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |richliu@techarea.org

--- Comment #4 from Richard Liu <richliu@techarea.org> ---
I get the same problem on my ASUS Z97-A/USB 3.1.
CPU is Intel Broadwell i7-5775C . 

OS Kubuntu 15.04, Linux kernel 4.2unstable version

If enable and compile a software, it will cause hardware crash. 

But, if disable SpeedStep and Turbo Mode in BIOS, this issue will not happen.

-- 
You are receiving this mail because:
You are the assignee for the bug.

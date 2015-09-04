From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 04 Sep 2015 13:51:53 +0000
Message-ID: <bug-103351-137361-DKabgt1kjm@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57015 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933912AbbIDNvz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 09:51:55 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 026FD208A0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2015 13:51:54 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 509B4207F9
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2015 13:51:53 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #8 from ed <omfdzg@gmail.com> ---
Hi,
having same problem on i7-5775C ASUS ROG MAXIMUS VII HERO GAMING MB
system is not stable when loaded even with "processor.max_cstate=0
intel_idle.max_cstate=0" and disabled SpeedStep and Turbo

Ubuntu 14.04.3 LTS

tried 
3.16.0-46
4.2rc8
4.2rc7

-- 
You are receiving this mail because:
You are the assignee for the bug.

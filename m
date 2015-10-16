From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 17:29:54 +0000
Message-ID: <bug-103351-137361-vhjiuuGTFB@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51485 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148AbbJPRaA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 13:30:00 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4A7B8209CD
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 17:29:59 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 2C3F9209F7
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 17:29:58 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #80 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Well, so far all desktop Broadwell-H (pf=0x2) still have RTM enabled even with
microcode 0x13.  We don't have enough data for mobile Broadwell-H (pf=0x20).

Adrienne, it could be really helpful if you could tell us more about your
system, since it has always had RTM disabled, even with microcode 0xd... could
you tell us what system is it (make, model), and the output of "dmesg | grep
microcode" and /proc/cpuinfo, please?

-- 
You are receiving this mail because:
You are the assignee for the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 10:24:38 +0000
Message-ID: <bug-103351-137361-eKGWTW0Wbx@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40455 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbbJPKYl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 06:24:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D61C220A69
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 10:24:40 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 0652320A63
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 10:24:40 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #73 from Alexey Dyachenko <adotfive@gmail.com> ---
microcode updated early
pf=0x2
cpuinfo http://pastebin.com/92EjQxsM

-- 
You are receiving this mail because:
You are the assignee for the bug.

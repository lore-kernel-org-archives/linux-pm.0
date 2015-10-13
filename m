From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 13 Oct 2015 20:06:14 +0000
Message-ID: <bug-103351-137361-eL5C0uCbpF@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36467 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbbJMUGS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 16:06:18 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 85F32208D3
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 20:06:17 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 960A12082A
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 20:06:16 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #56 from sac <sdfjk40sdnmxyl@mailinator.com> ---
Haven't teste, but in addition someone from VirtualBox suggested to set the
nosmap kernel option (if no updated Microcode is available).
https://forums.virtualbox.org/viewtopic.php?f=6&t=71531&p=342062#p340624

-- 
You are receiving this mail because:
You are the assignee for the bug.

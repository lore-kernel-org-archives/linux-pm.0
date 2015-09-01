From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 01 Sep 2015 02:38:18 +0000
Message-ID: <bug-103351-137361-jtDeIueY68@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41878 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722AbbIACiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:38:21 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BF8902069B
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2015 02:38:20 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0146C2066C
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2015 02:38:19 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #6 from Richard Liu <richliu@techarea.org> ---
Update

disable Speedstep just let system more stable than before, but it cannot solve
crash problem. 
it may need more time to re-procedure this issue. 

You can run several heavy process simultaneously , it might duplicate this
issue .

-- 
You are receiving this mail because:
You are the assignee for the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 12:57:51 +0000
Message-ID: <bug-103351-137361-ITExO9E2Us@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53928 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbbJGM54 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 08:57:56 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5C2072E
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 12:57:55 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A827B20751
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 12:57:53 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #39 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Thank you.

The cpuinfo dump for rev. 0x12 shows HLE and RTM still enabled.  

Can you confirm through the kernel log that the microcode update was applied by
the "early" microcode update driver (check the kernel log for "early" in the
microcode update log entries) ?

Does glibc with lock elision enabled work properly with that microcode?

-- 
You are receiving this mail because:
You are the assignee for the bug.

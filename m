From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 08 Oct 2015 17:22:03 +0000
Message-ID: <bug-103351-137361-R1aZiVNNoH@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36583 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964890AbbJHRWI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 13:22:08 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 66AFF2081E
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 17:22:07 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 6895220816
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 17:22:06 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #49 from saunders.52@wright.edu ---
(In reply to Henrique de Moraes Holschuh from comment #46)
> Alexey,
> 
> Thank you very much for confirming that TSX-NI in Broadwell-H is still
> broken *and active* on microcode 0x12, dated 2015-06-19.
> 

There's also a microcode 0x13 the MSI update installed on my machine installs
that disables TSX-related stuff, according to /proc/cpuinfo:
https://www.dropbox.com/s/dfjs8xbypx20vqm/msi-px60-2qd-microcode13-cpuinfo.txt?dl=0

-- 
You are receiving this mail because:
You are the assignee for the bug.

From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 10 May 2016 04:26:59 +0000
Message-ID: <bug-103351-137361-baB5F1UVyF@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56213 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcEJE1I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 May 2016 00:27:08 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id CB0C820142
	for <linux-pm@vger.kernel.org>; Tue, 10 May 2016 04:27:05 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0B092201DD
	for <linux-pm@vger.kernel.org>; Tue, 10 May 2016 04:27:03 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #108 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to Zhang Rui from comment #107)
> As there is quite a lot of discussion in this thread, and the original bug
> reporter has no response since last Oct, according to the previous commment,
> my questions is "do we still have any other open issues? can we close this
> bug report?"

I think this bug was fixed by the microcode updates, which have now been
officially packaged and released by Intel, and are being picked up by
distributions. There was also some discussion about avoiding the bug with some
glibc patches to avoid the suspected bad CPU instructions.

I don't think this was ever a kernel bug, and I think the problem and it's
solutions are pretty well documented at this point. I believe it's safe to
close this issue.

-- 
You are receiving this mail because:
You are the assignee for the bug.

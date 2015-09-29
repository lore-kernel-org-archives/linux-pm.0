From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 29 Sep 2015 18:27:56 +0000
Message-ID: <bug-103351-137361-79HmIlMHEc@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47870 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935302AbbI2S2A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 14:28:00 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4E0C4206D9
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 18:27:59 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id EE8A3206F3
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 18:27:57 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #20 from saunders.52@wright.edu ---
(In reply to kernel@benjam.info from comment #19)
> (In reply to saunders.52 from comment #18)
> > Is there a way to forward this to Intel? Unfortunately, these are all
> > laptops, so their customer support page says "contact your manufacturer",
> > and my manufacturer doesn't support Linux.
> 
> This bug is confirmed on the 5700HQ, 5675C, and 5775C. The last two of those
> are socketed desktop processors.

Ah. Sorry. I still sent an e-mail to an intel contact address I could find
pointing them to this bug. Probably wasn't the right one (security) but it's
one of the few public facing ones I could find that were tech oriented, and
this does crash the system when running code with the affected instructions in
a VM.

-- 
You are receiving this mail because:
You are the assignee for the bug.

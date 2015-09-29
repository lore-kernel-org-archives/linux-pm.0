From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 29 Sep 2015 18:26:17 +0000
Message-ID: <bug-103351-137361-BrU1aQx7ei@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47732 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964855AbbI2S0V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 14:26:21 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D0206F7
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 18:26:20 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 18FEC206DC
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 18:26:19 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #19 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to saunders.52 from comment #18)
> Is there a way to forward this to Intel? Unfortunately, these are all
> laptops, so their customer support page says "contact your manufacturer",
> and my manufacturer doesn't support Linux.

This bug is confirmed on the 5700HQ, 5675C, and 5775C. The last two of those
are socketed desktop processors.

-- 
You are receiving this mail because:
You are the assignee for the bug.

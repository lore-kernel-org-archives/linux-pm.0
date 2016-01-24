From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111241] one need root credentials to read cpuinfo_cur_freq
 content
Date: Sun, 24 Jan 2016 17:09:14 +0000
Message-ID: <bug-111241-137361-lET3BGTgtP@https.bugzilla.kernel.org/>
References: <bug-111241-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59041 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbcAXRJQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 Jan 2016 12:09:16 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D3A06203A0
	for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 17:09:15 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 168132039D
	for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 17:09:15 +0000 (UTC)
In-Reply-To: <bug-111241-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111241

--- Comment #2 from flux242@gmail.com ---
well, the problem is 12 years people are still confused why it is this way.
Which makes me to believe that something is wrong with the design. Anyway, as
far as I can read from scaling_cur_freq I'm fine.

-- 
You are receiving this mail because:
You are the assignee for the bug.

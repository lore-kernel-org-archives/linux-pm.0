From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 21 Oct 2015 20:56:46 +0000
Message-ID: <bug-103351-137361-jrlFaOrrNN@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56479 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbbJUU4v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Oct 2015 16:56:51 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 303BC2092F
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 20:56:50 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE420923
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 20:56:49 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #88 from kernel@benjam.info <kernel@benjam.info> ---
murilog, Maybe: https://bugzilla.kernel.org/show_bug.cgi?id=103351#c79

That said, the microcode update and the glibc blacklist should solve all of the
known issues.

-- 
You are receiving this mail because:
You are the assignee for the bug.

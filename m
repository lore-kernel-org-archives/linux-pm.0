From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 115261] BISECTED: CPU Frequency scaling jumps and stucks at max
 freq - CPU is AMD Phenom(tm) II X4 905e Processor
Date: Mon, 28 Mar 2016 23:38:03 +0000
Message-ID: <bug-115261-137361-xk3kbpCdex@https.bugzilla.kernel.org/>
References: <bug-115261-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60656 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbcC1XiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Mar 2016 19:38:07 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 719C42020F
	for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 23:38:05 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id CD5312011D
	for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 23:38:03 +0000 (UTC)
In-Reply-To: <bug-115261-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=115261

Len Brown <lenb@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lenb@kernel.org
           Assignee|linux-pm@vger.kernel.org    |yu.c.chen@intel.com
            Summary|CPU Frequency scaling jumps |BISECTED: CPU Frequency
                   |and stucks at max freq      |scaling jumps and stucks at
                   |                            |max freq - CPU is AMD
                   |                            |Phenom(tm) II X4 905e
                   |                            |Processor

-- 
You are receiving this mail because:
You are the assignee for the bug.

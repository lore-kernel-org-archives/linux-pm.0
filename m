From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 30 Sep 2015 05:43:34 +0000
Message-ID: <bug-103351-137361-rFQsKfMq2t@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47552 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbbI3Fnj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 01:43:39 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E8206C3
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 05:43:38 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 3815720719
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 05:43:36 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #25 from kernel@benjam.info <kernel@benjam.info> ---
I wrote a hacky script to extract microcode updates from binary blobs a few
days ago. Here's what I was able to pull out of one of the MSI updates in
question: http://benjam.info/downloads/5700hq-ucode.tar.gz

It obviously doesn't contain any updates for the 5675C or 5775C, but if someone
has the 5700HQ on a non-MSI machine, they should be able to install the updates
from that tarfile using iucode-tool, and hopefully it will work.

Installing microcode updates from arbitrary binaries should be pretty safe,
since they're cryptographically verified by the processor and updates are
reverted upon reboot.

-- 
You are receiving this mail because:
You are the assignee for the bug.

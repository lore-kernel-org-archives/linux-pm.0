From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 22 Oct 2015 20:02:01 +0000
Message-ID: <bug-103351-137361-YYUiBmVu43@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57620 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069AbbJVUCJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Oct 2015 16:02:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F0206AB
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 20:02:07 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 359E82092A
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 20:02:04 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #92 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to matthew.dewitt from comment #90)
> downloaded the 5700hq-ucode.tar.gz file in this thread. This file contains
> four .bin files.

Use 0x13.bin from the GitHub repository. The old tar.gz file may not even
contain a correct microcode update for the Broadwell processors. I've deleted
the tarfile from my server to avoid further confusion in the future. All the
files that were there are in the git history anyways.

-- 
You are receiving this mail because:
You are the assignee for the bug.

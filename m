From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 21 Oct 2015 20:58:33 +0000
Message-ID: <bug-103351-137361-Tqd0dgYNQT@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56833 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755490AbbJUU6h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Oct 2015 16:58:37 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9C360208F9
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 20:58:36 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA220925
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 20:58:35 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #89 from kernel@benjam.info <kernel@benjam.info> ---
Correction: When I say the microcode update fixes things, I mean the microcode
update on BDW solves it on BDW. The BDW microcode update won't do anything on
SKL. I don't have a copy of the SKL microcode updates, but if someone has a
UEFI binary and want me to, I could extract them.

-- 
You are receiving this mail because:
You are the assignee for the bug.

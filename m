From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 16:36:39 +0000
Message-ID: <bug-103351-137361-66tFoTFWJB@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42750 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbbJGQgo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 12:36:44 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4F7432069B
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 16:36:43 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 3E28720747
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 16:36:42 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #40 from kernel@benjam.info <kernel@benjam.info> ---
Created attachment 189651
  --> https://bugzilla.kernel.org/attachment.cgi?id=189651&action=edit
/proc/cpuinfo for i5-5675C with the 0x12 ucode patch applied at early boot.

-- 
You are receiving this mail because:
You are the assignee for the bug.

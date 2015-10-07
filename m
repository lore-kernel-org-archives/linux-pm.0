From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 20:21:06 +0000
Message-ID: <bug-103351-137361-fK2FIxVxlw@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53486 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbJGUVL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 16:21:11 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id CA65C205EE
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 20:21:09 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 6AC6120789
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 20:21:08 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #43 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Jonas Platte: Thanks for the information.  Sorry, I didn't notice you were not
one of the people who also reported glibc issues.

Benjan: Thanks for the information.

Alexey, Matthew: If at all possible, maybe you could repeat the glibc
lock-elision testing with microcode 0x12, using a VM or chroot?

-- 
You are receiving this mail because:
You are the assignee for the bug.

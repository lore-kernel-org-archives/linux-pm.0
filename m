From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 17:43:31 +0000
Message-ID: <bug-103351-137361-qrw88nNyE6@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52393 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbbJPRnh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 13:43:37 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5926320A89
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 17:43:36 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 5646620A81
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 17:43:35 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #81 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Oh, and just in case a certain Skylake oddity might scare someone needlessly:

Skylake may report that the microcode revision running in the processor is one
less than the version displayed by iucode-tool and any other such tool.  It
does so when the new Intel SGX feature is enabled.

That's why that, although Skylake microcode files have even revision numbers,
some (most?) Skylake systems will report that they're running odd microcode
revisions.

-- 
You are receiving this mail because:
You are the assignee for the bug.

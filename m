From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 08 Oct 2015 17:48:04 +0000
Message-ID: <bug-103351-137361-SUHNzcWP7Q@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38277 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbbJHRsJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 13:48:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 094E020841
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 17:48:08 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id F20792083B
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 17:48:06 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #50 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Ah, that's very good news, indeed!

First, because anyone that has Broadwell-H with microcode 0x13 should be able
to run any Linux distro without it crashing either the kernel, or glibc...  At
least as far as the two errata mentioned in this bug report are concerned.

Second, because it means the chance of TSX-NI (RTM) being fixed in Broadwell-H
really should be non-existent as the erratum text says, so blacklisting it
becomes uncontroversial.

-- 
You are receiving this mail because:
You are the assignee for the bug.

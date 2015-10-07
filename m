From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 10:42:41 +0000
Message-ID: <bug-103351-137361-eJqFS7rdED@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42664 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbbJGKmr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 06:42:47 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D938520749
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 10:42:45 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0289B20780
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 10:42:44 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Henrique de Moraes Holschuh <hmh@hmh.eng.br> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hmh@hmh.eng.br

--- Comment #37 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
It would be really helpful to have the output of /proc/cpuinfo on the systems
with the fixed microcode, both Broadwell and Skylake.

Can someone with those processors and using the microcode provided in github
please attach the output of cat /proc/cpuinfo here?

-- 
You are receiving this mail because:
You are the assignee for the bug.

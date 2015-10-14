From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 18:21:18 +0000
Message-ID: <bug-103351-137361-df28kqBxxw@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37673 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbbJNSVZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 14:21:25 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A619E20843
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 18:21:23 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id AECED208C3
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 18:21:21 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #58 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
(In reply to Fredrik Atmer from comment #57)
> I've had my setup i5-5675C on an Asus H97I-Plus motherboard for some time

...

> first, but the day after I was able to do a dist-upgrade of my 14.10 system
> to 15.04 using the 0x12 microcode (I used to have 0xd).

Hmm, libpthreads (glibc POSIX threads support) in Ubuntu 15.04 is supposed to
have lock elision enabled, and it should not be really happy with the i5-5675C
with microcode 0x12 (you'd need microcode 0x13).

Is "rtm" listed in your /proc/cpuinfo "flags" line?

Can you run heavily threaded applications without crashes?

-- 
You are receiving this mail because:
You are the assignee for the bug.

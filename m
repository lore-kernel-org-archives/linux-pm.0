From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 20 Oct 2015 12:11:33 +0000
Message-ID: <bug-103351-137361-OQKXbjCURz@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37817 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbbJTMLj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Oct 2015 08:11:39 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA0208A2
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 12:11:38 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 7B896208A6
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 12:11:35 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #86 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Related information:

Debian will blacklist glibc lock elision (which uses Intel TSX-NI RTM, and does
not use HLE) in Broadwell/Broadwell-H/Broadwell-DE processors.  This could
change, but only if Intel itself decides to own up and publish correct,
consistent information that we feel we can trust.

After all, even the current editions of the Broadwell-* specification updates
are inconsistent with reality.  This makes it impossible to trust Intel TSX-NI
on those processors ATM.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=800574


Most of the SIGSEGVs observed by users in __lll_unlock_elision are software
bugs (and the bug is NOT in glibc, either): code that attempts to unlock an
already unlocked lock will crash when Intel TSX is being used.

(typical example: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=750792)

IMO, we should instrument glibc to complain loudly (or even crash) whenever
anything attempts to unlock and unlocked mutex: it will smoke out applications
and libraries with shoddy locking really fast, and shoddy locking is known to
cause subtle, hard to diagnose problems.

The MCE issues are not fixable by anything other than a microcode update, so it
boils down to distros being able to ship that microcode update.

-- 
You are receiving this mail because:
You are the assignee for the bug.

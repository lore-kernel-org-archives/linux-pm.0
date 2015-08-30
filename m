From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sun, 30 Aug 2015 18:28:50 +0000
Message-ID: <bug-103351-137361-P5SCD56iUS@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47847 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662AbbH3S2w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Aug 2015 14:28:52 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 45468206E6
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2015 18:28:51 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 7DB18206E4
	for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2015 18:28:50 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

Krist=C3=B3f Marussy <kris7topher@gmail.com> changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
     Kernel Version|4.2rc7                      |4.2rc8

--- Comment #2 from Krist=C3=B3f Marussy <kris7topher@gmail.com> ---
Today I tried out compiling 4.7rc8 and systematically commenting out th=
e
C-states in intel_idle.c that are supported by Broadwell, that is, C1, =
C1E, C3
and C6. Unfortunately, I was able to produce an MCE and panic with each=
 of the
kernels I compiled, which leaves me clueless about what could be this b=
ug.

--=20
You are receiving this mail because:
You are the assignee for the bug.
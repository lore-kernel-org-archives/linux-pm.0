From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 24 Aug 2015 12:22:01 +0000
Message-ID: <bug-103351-137361-LXxsDjBxGE@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60182 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754137AbbHXMWF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 08:22:05 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 203582070C
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2015 12:22:03 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5B20701
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2015 12:22:02 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

Krist=C3=B3f Marussy <kris7topher@gmail.com> changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
          Component|cpufreq                     |intel_idle

--- Comment #1 from Krist=C3=B3f Marussy <kris7topher@gmail.com> ---
I managed to get a stable system by booting with the processor.max_csta=
te=3D0
intel_idle.max_cstate=3D0 idle=3Dpoll and SpeedStep enabled. However, i=
f I set
idle=3Dhalt or idle=3Dnomwait instead, the MCEs remain.

In Windows, the Performance monitor displays that the system utilizes C=
-states
that are claimed to be C1, C2 and C3; so it is quite odd that C1 halt i=
n Linux
triggers an MCE...

--=20
You are receiving this mail because:
You are the assignee for the bug.
From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 18:06:36 +0000
Message-ID: <bug-103351-137361-oUqufBO3Zt@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47145 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855AbbJOSGm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 14:06:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 19FB120817
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 18:06:41 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id D031120825
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 18:06:38 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #71 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to Henrique de Moraes Holschuh from comment #66)
> Assuming the microcode was *really* applied by the early microcode loader
> (please double-check):

It's really being applied by the early microcode loader:

---
[    0.000000] microcode: CPU0 microcode updated early to revision 0x13, date =
2015-08-03
[    0.078198] microcode: CPU1 microcode updated early to revision 0x13, date =
2015-08-03
[    0.096059] microcode: CPU2 microcode updated early to revision 0x13, date =
2015-08-03
[    0.113892] microcode: CPU3 microcode updated early to revision 0x13, date =
2015-08-03
[    0.590510] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x13
[    0.590515] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x13
[    0.590519] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x13
[    0.590522] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x13
[    0.590549] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
---

I don't understand it either, and I'm as frustrated as everyone else by the
lack of communication from Intel.

Thanks for the warning about applying the updates after early boot. I still
want to support the normal installation mechanism, because it's easier for some
people, but I'll certainly look into adding more specific disclaimers and
tweaking the way the installation works.

-- 
You are receiving this mail because:
You are the assignee for the bug.

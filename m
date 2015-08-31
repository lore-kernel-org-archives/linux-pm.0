From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 31 Aug 2015 05:55:00 +0000
Message-ID: <bug-103351-137361-VpyBrK2ve9@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35320 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbHaFzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 01:55:04 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8E02920693
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2015 05:55:01 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id C411120691
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2015 05:55:00 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

Ziyue Yang <yzylivezh@hotmail.com> changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
                 CC|                            |yzylivezh@hotmail.com

--- Comment #3 from Ziyue Yang <yzylivezh@hotmail.com> ---
(In reply to Krist=C3=B3f Marussy from comment #1)
> I managed to get a stable system by booting with the processor.max_cs=
tate=3D0
> intel_idle.max_cstate=3D0 idle=3Dpoll and SpeedStep enabled. However,=
 if I set
> idle=3Dhalt or idle=3Dnomwait instead, the MCEs remain.
>=20
> In Windows, the Performance monitor displays that the system utilizes
> C-states that are claimed to be C1, C2 and C3; so it is quite odd tha=
t C1
> halt in Linux triggers an MCE...

Same problem here with MSI GE62 2QE Apache Pro.
I tried both debian8.1 and Ubuntu15.04 on the real machine and received=
 same
kernel panics. Updating kernels to 4.2 doesn't help.
I also tried those two systems in VMware workstation under Windows 10 a=
nd ended
up in BSODs saying "MACHINE_CHECK_EXCEPTIONS".=20
I then tried to use debian in VMware at runlevel=3D3. It seems to be st=
able. I
don't know why.=20

I'm going to try your way to get a stable system. Will reply if anythin=
g new
discovered.

--=20
You are receiving this mail because:
You are the assignee for the bug.
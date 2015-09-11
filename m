From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 11 Sep 2015 10:09:01 +0000
Message-ID: <bug-103351-137361-rUlDAYvDSU@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46875 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbbIKKJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 06:09:06 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 811EE207CE
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 10:09:05 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id D3CD92082A
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2015 10:09:03 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

Ond=C5=99ej Jan=C3=A1s <ondrejanas@gmail.com> changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------=
-----
                 CC|                            |ondrejanas@gmail.com

--- Comment #10 from Ond=C5=99ej Jan=C3=A1s <ondrejanas@gmail.com> ---
Hello,

recently I've got this laptop MSI GS70-2QD-Stealth. I installed ubuntu =
14.04
LTS without any problems and after i disabled Intel Speedstep, secure b=
oot,
fast boot in BIOS i am running the system without problems so far.(no G=
RUB
parameters were added)

--=20
You are receiving this mail because:
You are the assignee for the bug.
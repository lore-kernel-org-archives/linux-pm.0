From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 01 Oct 2015 19:01:33 +0000
Message-ID: <bug-103351-137361-NUhaqsUKET@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53008 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916AbbJATBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 15:01:43 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8B069207A8
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 19:01:37 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A2F94207BB
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 19:01:35 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D103351

--- Comment #33 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to matthew.dewitt from comment #32)
> Well, it still has to be applied at every reboot right?
>=20
> Still, very awesome!

If you use iucode-tool with the -K option, it should be able to copy fi=
les into
the right locations in `/lib/firmware/intel=E2=80=90ucode` to make the =
fix persist. I'm
going to experiment with it a bit later, and perhaps I'll add an option=
 to the
install script to automate it.

--=20
You are receiving this mail because:
You are the assignee for the bug.
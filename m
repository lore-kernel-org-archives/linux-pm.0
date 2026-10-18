Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250C4D0CC4
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358266; cv=none; b=hEVpL9QqnIsZANSwKCzcs2yU8Ue17KY2RnrT4DKOnQNHIcDaGRiTGQBPPW3nDnVmyKinZqSTSlsoUDTdoAzNb+d+opVtVlyOApxwcw4NIDWu1vzOhGfBqPQ2Vm2QlGJM869ItzexwRuLjK+5+3KNAmP2G3z1SO5q4WlY0TxkA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358266; c=relaxed/simple;
	bh=oJEJ/2UvHm34t5TUeLcPO/mcihueJYmt1u78ZSVmhEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5TZJbAppl3m2IPR0mTSCEA52uAKK446p57RxwCahGm9ELcywVASb4hJasZJ5tMvp2U5hJecfyQiTE0fSMn9n78tlFmosNVRaaxM3sASQE6lEttd5O/CK23peEZbLFavdqM+ZNPf8S2PMMrzlvdPbakpUAQl2RnyZwe8ogkH9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnddboBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnddboBt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D75CC2BCC7
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792358266;
	bh=oJEJ/2UvHm34t5TUeLcPO/mcihueJYmt1u78ZSVmhEY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KnddboBteimqPFn83GaafsNQOhKdP0x62gUs75SbN99EI/r8BuV1R2YjblnQbVSkT
	 EJRTgSyEv2d8C5QhWssBGyzPkIRRli3QswXlg7vh31IdIOdyNF23gpdVnk2o63cH02
	 Myyq6cbILO/1cODySgJDUjjijSw14IlDi+USP6FgBm11Mw87gTvNgJI+xC7M/PzNRJ
	 +kKY3uMCV7oJfHQZasS+co4VSYYGTs0uPAvA78DDZF1xPqGizI7N6A7pDN4QTuic27
	 Dl2Ml0jdoBI58Ilzqa+vpobRD7KbStDs8C3849bUezzZgU58lrQEz01Kb/B0kV4k4y
	 P+FKNeCAfn4yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0BE0EC41612; Sun, 18 Oct 2026 21:17:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 222146] 6.18: AMD (Ryzen 5): cannot select existing
 energy_performance_preference
Date: Sun, 18 Oct 2026 21:17:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steffen@sdaoden.eu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222146-137361-kirKnEuC1B@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222146-137361@https.bugzilla.kernel.org/>
References: <bug-222146-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222146

--- Comment #2 from Steffen Nurpmeso (steffen@sdaoden.eu) ---
(for your possible interest)

What do you mean by "kernel not supported"?  I use the latest LTS, just like
AlpineLinux.  And it all worked until a few versions back?

(I mean, it is not something "terrible", i just thought i report the proble=
m,
because it is a "detoriation of state" that lasts for now several kernel
updates.)

lscpu nonetheless and in short is

Vendor ID:                   AuthenticAMD
  Model name:                AMD Ryzen 5 220 w/ Radeon 740M Graphics
    CPU family:              25
    Model:                   124
    Thread(s) per core:      1
    Core(s) per socket:      6
    Socket(s):               1
    Stepping:                0
    Microcode version:       0xa70c00a
    Frequency boost:         enabled
    CPU(s) scaling MHz:      39%
    CPU max MHz:             3201.0000
    CPU min MHz:             406.4770

CPU(s):                      12
  On-line CPU(s) list:       0-10:2
  Off-line CPU(s) list:      1-11:2


# bin/cpupower.sh
CPU 0: freq: 406477-3201000; scaling: 406477-640200; boost:0; gov: powersave
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)
CPU 2: freq: 406477-3201000; scaling: 406477-640200; boost:0; gov: powersave
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)
CPU 4: freq: 406477-3201000; scaling: 406477-640200; boost:0; gov: powersave
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)
CPU 6: freq: 406477-3201000; scaling: 406477-640200; boost:0; gov: powersave
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)
CPU 8: freq: 406477-3201000; scaling: 406477-640200; boost:0; gov: powersave
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)
CPU 10: freq: 406477-3201000; scaling: 406477-640200; boost:0; gov: powersa=
ve
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)
P-


(energy "should" be "power" in this state, and was until a few weeks ago.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

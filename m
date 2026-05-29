Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F63438AE
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047820; cv=none; b=qJbDG1du+JOJx1P0dhmhhvBIpiTDEjjnijYUqLfb8AyF5O3anJvOztxBfPX/s4X0NmL6k9o2e6/NgUIkpUej1WPd4NLJ1er0237NFiscc33GISLtVraZueBSD9SHaB8W1Dha8v4DC17PAjxVNfj0clUr0GVaaO+78yWrSc+nPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047820; c=relaxed/simple;
	bh=UGtrqiRaRt0NbCxA3N0bLRNDXkGXkRq2NzFwZ0PijyY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgq6tTTC7kjAJ6Zk+69NoH+OZ3f18xtdhxYra2pyWIDrXvPijQRRuJK/6+/HEzppOJwjBtJ+MPVOh8x4obd0kyCQUVk8//4PVfMxkp0e9dTcVCeKsJV1OCt9q5vtKnrwYXcD6Pmnwxbh8DwmKbuKViqZZ1ooYkr3MD1sZ8pUv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdso7ADT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdso7ADT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04D58C2BCC6
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780047820;
	bh=UGtrqiRaRt0NbCxA3N0bLRNDXkGXkRq2NzFwZ0PijyY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mdso7ADTh6S32a0vOp03XbAtgiO6Ep8iDE8/D0Y5yn4EYIxHDNULig0vWFgVFJbq7
	 vcZz3MRonSVQVJd7iU0/pDl9hlqs71mIJBPfygcJ+HNoVjV2GR9eN6ddq2eViRQ+dH
	 OTcdCNkz2zgsuYOh6heAGICdDkguu1AIVxCY2r9BH4dMRmwwjb11dcqMiWYcHCsA2I
	 nCq8Q02EQVMe9C4u31Q267XtVuQ6mgblMIh8QUFxSwB6R8lzjxCWjS45fapJzkmFa0
	 3m+X5s4ewGl4RGBQNy2DsTJrAsAhknaVyZEL8X86CA0mXyLIAbjvsachp+j+vGU5Pu
	 ekOdE8aLMAm6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F1342C53BC5; Fri, 29 May 2026 09:43:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 09:43:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-vcFWTs6ryy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221505-137361@https.bugzilla.kernel.org/>
References: <bug-221505-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221505

--- Comment #18 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
This is a resource availability issue (me).=20=20
I haven't had time to make any progress on this, so yes sorry no solution in
sight yet for the performance mode issue right now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD53A2E07
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697876; cv=none; b=GDtYs++L5SCIlgj0UPqppfOOKDVq8Xc9xHV1NYSlSb8Ompk04XtQWpoziQCbju2sy1uoIpEONVH7XJwFioUopIMIKDex+fxEBcg0u41++z9YvekdL2kK1kP5dcyuxECo7LTkxjNiPZB9W+p6jr3IYcl6gtndtoRnzM0v5gL8lns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697876; c=relaxed/simple;
	bh=f4nFtsfI8uezelwfD99eBtZ/Z20FFjnatzkg0oJHaBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r0ZxnrjYm9cDUlP31kU6lTVa/L/KUApgeMRgmTTTRmznAnRtg+16t4URDL+bAjyAxqNfYeRwYmQdb70fkkJSbUDl4EUB0Wki2mcSB6arpIhW7OnmBcCm4j+eEemULVAVOcMwmcp8hiPgtfEh0IyhMr24pPpDTdhprcr1j9jBd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajf8hp5a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajf8hp5a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16FC5C2BCB7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697876;
	bh=f4nFtsfI8uezelwfD99eBtZ/Z20FFjnatzkg0oJHaBY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ajf8hp5akmr97rBWoGvJ9gzYuu+PbKJdywjNcM2Q4Xrl8lv8P0501tLTVXJ1g05Wr
	 V+F0vFxfrAtEG7egr45oO7jJWhPnjv6dr+b7vXU4pxouIa/e1vMBUZd0FqIDp7vIAz
	 bgK/f41xte2D4r62eMeMhNNxO7wJ+6Z5co+1gq9dgVWRifFlyINNUJQRm2qO4wlB37
	 OaQ5+Eyra0elAuS+YVKAqv4TTHhQQDxat5nDvE1g8AutaxycXkDqNm6PUyrp9QVL2A
	 rvvZEOiqImMfuMbsjNN786M3h0wvGt2C1Z3zPt+hoP+FDjmlhUDp4fUiRIbiev+EgN
	 VMIbJP0eOgAQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0447CC41613; Wed, 13 May 2026 18:44:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 18:44:35 +0000
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
Message-ID: <bug-221505-137361-JD7pFhv3Tn@https.bugzilla.kernel.org/>
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

--- Comment #9 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> With amd_dynamic_epp=3Denable:

I'm not sure why this is happening.  What platform profiles does this other
driver support?

> With amd_dynamic_epp=3Ddisable (or no parameter):

So you're still seeing this?

[  299.585428] amd_pstate: EPP cannot be set under performance policy

Can I see the kernel log with dynamic debug for amd-pstate turned on?  And =
also
the output from the amd-pstate triage tool in amd-debug-tools.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

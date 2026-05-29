Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4F33B949
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048940; cv=none; b=mllqgDNhDFrnE5WdVi+qUYWYvnuvApHhINGkwjEkgE+R4KQLwgD/8a5rw6Z1C1b74aL5MQVzmTSLBRlVzQNqIR8fHtDHIu4hJh9mPbnCTxY3Xfn7TrOT5xVsKXiayGUHr3NVlRnYozfRxMeTSdrmkx8dL7ffI2i8cQ7DpwwiSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048940; c=relaxed/simple;
	bh=Q6pkUB6pGlpA64r+UJ0LJKBWg1GYUaBMjkL0IcCr75s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkMtuaiFy42cSh/yIOpWuHwN/jPmHCGV81HDy4BvS051aozIlgwKGgZVSkv0s2rHT6qIlmIw6sE0VJuZ6RwGp46Nlk8TqGdgDjCNp4j9yh53xyFalN2q57q93VIkEwdwgVTiFckA2WfBT4tYyPBqCyu2prslNIT448Zni1bwIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOf8RUFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOf8RUFS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18DFAC2BCF4
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780048940;
	bh=Q6pkUB6pGlpA64r+UJ0LJKBWg1GYUaBMjkL0IcCr75s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kOf8RUFS1Zs+QhDltH85Q8bqWEE2sWVO9F+NnXpBa6F94cR+b0iBiGG3rc4oEqE3z
	 EWj9Ssez418zvcMYKiTssEZnYTsMog+jbvKC+WWZC66TIibHyPb3k5lNW6BNgP5kUq
	 bL0Iz5NIB3rDe7cptswSqsXNApAS4ANSOTWdq4VjIGeEPg/jMVmZ2gSxJGEYugc5Ud
	 iAPzK+qlZ5pkgb+yT7C3a/8o0XKGELah5zsD5JIT7aSZFv0dhYbpuJMIfyjq7+QwgX
	 DXNvTrBtm/52r6LuG77XburxfUzc23goUOkkBnKwNtQn+qCHKP2cqP9WWdpPLWIjMb
	 Pgq6t9abl2Ebg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E5FCC433E1; Fri, 29 May 2026 10:02:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 10:02:19 +0000
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
Message-ID: <bug-221505-137361-1oLJl5trXB@https.bugzilla.kernel.org/>
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

--- Comment #22 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> Understood, that's how it is sometimes. Thing is: 7.1 final is not far aw=
ay
> any more, so allow me to ask (sorry, that's why I'm here for; I really do=
n't
> want to make your life harder):

I know; I really want to get to this.  If I don't; I'll get something for 7=
.2
and we can backport it.  It's certainly still on my radar.

> I assume "revert one or a handful changes now to resolve this for 7.1 [and
> reapply them later in improved form]" is not a option here, right?

If I understood the root cause I would have a better answer for you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

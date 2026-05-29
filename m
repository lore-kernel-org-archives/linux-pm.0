Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C923FF1
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048844; cv=none; b=oUTv+Fpn4F78fOfL3aLdYz6o/iDJ6iK3TqGOIhWfEbUieEgeejfIKs0B4SDGHOXBVauzTl88CZoviWZRhogqBJjHLqepJrzxkX/6bEnpcZ30OHgVzJQMsj/zBmWnYIHBb1+jkUkQVoFrB72H8UxCT611zK8yf+4yrw07yyZBivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048844; c=relaxed/simple;
	bh=bhkHWWPkWbLVsbxpDLiBg2caO0VDV6r1UcsJsGUhJhs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1EIvjOpxLCaaw5ayEYBEvXPy6jyrny0tmumQtFie6Um/VrRiUdhfnbvq6o+4KaIKaqSfGujfq2Lty7tQSxaQYUpekzx06WFCEApP9Jh8vM6tr6HuXPd6RuATO3a9H0KcHPY6BWd9xV9P+5kCE1qyFforige9FBmVR3bJfI6o14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUYsjBnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUYsjBnY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98504C2BCC6
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780048844;
	bh=bhkHWWPkWbLVsbxpDLiBg2caO0VDV6r1UcsJsGUhJhs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XUYsjBnYGgy33bR8ONX649uUgLa+hCMp0vt74O5LC1OiCbNTZ4BWhl0LUCdcOsRzF
	 rF2/XdVkSpg8MAYYuopG/OHzKNNA4SGvJdFz3ecZJrJeh1U1CrjrB8Kf1B7iZJJGSo
	 AGyEALMvmhUTB8XnQqhbxyZmUzp1nMS9wpBZFlUluPyrXn6Iyv+E/eKEr4wu1KKIBC
	 3Wgv4G1XNJmJnRXE3pM9cZdGodOM02qmN+ceEGTx4mQ2az4AY8/cS275eOR3r6cL+K
	 D+92plYJN7aoMzJSSQZ5sleD7RRop9YyH79PywBoLqv5CXQFrFmRK9nuGm4+fqyktf
	 CftKWhd1MsHxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85029C433E1; Fri, 29 May 2026 10:00:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 10:00:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-3YsUoavf7w@https.bugzilla.kernel.org/>
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

--- Comment #21 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Mario Limonciello (AMD) from comment #18)
> This is a resource availability issue (me).=20=20
> I haven't had time to make any progress on this, so yes sorry no solution=
 in
> sight yet for the performance mode issue right now.

Understood, that's how it is sometimes. Thing is: 7.1 final is not far away=
 any
more, so allow me to ask (sorry, that's why I'm here for; I really don't wa=
nt
to make your life harder):

I assume "revert one or a handful changes now to resolve this for 7.1 [and
reapply them later in improved form]" is not a option here, right?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

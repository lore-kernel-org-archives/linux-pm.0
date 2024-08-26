Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD17770F1
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696552; cv=none; b=AuEYf2HHiQS9usnDxV2R2kbiSxgdEil1kotjwHw6UVsF6TtLET6DbpNDG9InPR9NHyMgrq6/1FOhfDoqkAkSQl4q8AZMxyrKgpEb+v+YLbsrPSIm3x4Kjcv0JEC3FfkI1Eqt/JDqf+x9lzVt+1mtKGmBAj5YWvpAedC6OSGdQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696552; c=relaxed/simple;
	bh=Oy3swS4xM8ugMQ63lmxP819SpemvXN+HlfREYtoUgzI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/HTco0pPsj6J+NICHr5Bu3VuBPVORmBbTCvk5MMPk9U1YFOX1I7VthGTez6ikN6RWCtjhMazlMEJOrba6XCD5gTHyaiK2SbWzX2S7ideNU3IDTDU2hzCR85X8sf4Ch+5zKLyk5WACwHwJUQ6s3TI5Lol/Dj1EmRr3qwdWMsF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9aYhyJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9aYhyJX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2BE8C4DE15
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724696551;
	bh=Oy3swS4xM8ugMQ63lmxP819SpemvXN+HlfREYtoUgzI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r9aYhyJXFsYExvBwLu6E7aV/xmqdFaKem5rN+MW6lFLZaCmuvNePoKylKiBR7WWTP
	 FRJCnbPvFoRyZuopefGFaViuBxsNlGZ2OnYaNQ8XsrO7vb/Sy/+EZCsIAPrx2bvYta
	 6r9kbhfxqd4cUXFzPwTpD806HszPotEPOpr8deKvvtMogIsrsNbLFUjdXNVnZa4/Wn
	 bvEaoxEkPTcxdwIqIYYc4NMFsi9/EwfUmfqBBouTXs3HeclYRTZExPY/2L4drFNifX
	 mIe2G91TWPxrOJdLr+tw3laEsXr7tT6KhV4iXYatgYviX2vVkM4q1PasGW4q+FmCcT
	 EjmsSYvmq685A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97289C53BBF; Mon, 26 Aug 2024 18:22:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Mon, 26 Aug 2024 18:22:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219110-137361-x2aM3C5qML@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

--- Comment #11 from Artem S. Tashkinov (aros@gmx.com) ---
After resuming:

for i in `seq 0 4`; do rdmsr "0xc00102b$i"; done

c4912a10c4912a10
1
0
800010c4
0

Looks exactly the same.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

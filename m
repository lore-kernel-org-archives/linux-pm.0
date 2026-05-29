Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210323B6363
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055448; cv=none; b=s7IpvLWLP5pOEYnxhdFqsBBhuEcQ2fF0bGCpJqXjW8tYaPAjDLjSz4WOhoRG7zZywmcm406hzvyIAKNYt2732089Kb4EcDZuwJjZ92GBT1mtB2lSOpZzR3IyY3tZH79MIaKTvkIuMmLGTILz/mOYvz24vj1TcbuBizQit2Xgetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055448; c=relaxed/simple;
	bh=QVjJx5TuZusK8pjxrY6zaVi60Iy5+pc1p3Cc9MSONHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNcy0isAb1i4fmUn3Mmk/mLpH/MQks80VXlb4M4NMFPPA4Ej3KtusIeXML9z8D/JXOMKMFpBoQpmf03o0B+QFlkPkJU55tGxCovLiNmLEUppA1mygL/999+1V9rGWy0mdH662r4y3vNAOXKFR9Zl3q5pWkADHJjYqIIZXPYstvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2hen/fP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2hen/fP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9CC2C2BCC6
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780055447;
	bh=QVjJx5TuZusK8pjxrY6zaVi60Iy5+pc1p3Cc9MSONHM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W2hen/fPhhfER4YL7UsalwmuWfJa80TPOuryYrHLdPtkCdQ6tWKQwkKbuuHWkxEDi
	 21AZsE1T6Qh5/0zr59e/VjuudgASADCe8Icmzii4fdUVuTypOW4hF/UQ/iAU7TJ00I
	 HH/c2b77oRQvk6iRpiVOaRU+8aQfZluWNyVhxtfF1NWViMLW+W9zORWXIMb11H32M+
	 0QD9ydl/yb+u2XkfXj/yDcKKQA4jcjM/51zN4Ce8mXL3R/Ig0EN67Eb9J7LQYLooId
	 7nnSO8toE+/g1tIwKqReDxxRdYgnKAMj/BERzb20N7uNhPDM4PcdjNZUdzhk8cHKNl
	 /5A7+ZK/Dltqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 96461C53BBF; Fri, 29 May 2026 11:50:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 11:50:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexaandru@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-xtWsoP7Sjm@https.bugzilla.kernel.org/>
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

--- Comment #26 from Alex Ungur (alexaandru@gmail.com) ---
If there's any additional information I can provide about my laptop, happy =
to
share, just let me know.

I can also try building and rc4 kernel over the weekend, as I 100% remember=
 it
working. If that indeed works, wouldn't it make the bisection simpler?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

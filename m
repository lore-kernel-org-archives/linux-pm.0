Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9021ABD7
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746977; cv=none; b=MUzJ1YoBOI/EN4XHDz8bfi2xGn54Dr+0npVTPTCIoj/sEUNYJpLLCzB+slDurQl2URnBINTtlOqHIAFn9FH+75IxM3PqTXbzgZOkQTfjdWDg24hi8womoQkwaVCBqRU2fy9mnQQqP3/Cw+fdhgNAUzunspmCYmwLEWeDkrfc1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746977; c=relaxed/simple;
	bh=kpH6Q1vXuSHsdQDZIywiFtGWMXvRYo8dicj5t1biz8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELpVSCgTkoF3SGki2JsjmLLekT5nmdXq3CgGw5BdPzjJ/w2tyQK/il2ChP0rPi+9hDGdrGJd0vvTpPl0bO9jz9goUdP3afHzljw8h022zD/9u8tOOllCO0hTJWaKsLNfswMnN16HZYBZ1OYKsL0ddNQEOA324wFAtVY/4TuQ7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiQbEr18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiQbEr18"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0127C2BCF4
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785746976;
	bh=kpH6Q1vXuSHsdQDZIywiFtGWMXvRYo8dicj5t1biz8E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RiQbEr18yb9Nlw3XCmGXVX0k8s2bCuCsSbHrT+xFieHY7rYHMUKKBD/iZ/kATGxKB
	 Cf/beIoNRC7YdEX2a7B7D7edp/nyXlxKCkSRGbMdnZfSUil97wLlX98ckvSyw5ZyFf
	 0aDj2hszptHAGKVmi7iPSq4+YLjMrQ/SAdhoCM9KRYYk8f75VoSNuYW0gv/cCnT3Pq
	 a9tR/4+z7MHDC2etSR9TK/MCVFUKEgPBBHeElibB5Yo1vDFR/evF1RWa0weyW8WRYx
	 szxUWzeIdt7/W/F+uIV40BLQycGCmdRkIBAQ4qGHWdlfFPZqjM3phQ3VD1jupw0yop
	 C7jPudNBgG/MA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BEAA3C41613; Mon,  3 Aug 2026 08:49:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221795] amd-pstate: max_perf stuck at nominal_perf after boot
 on Ryzen AI 9 HX 370
Date: Mon, 03 Aug 2026 08:49:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REJECTED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221795-137361-4GbBsudCoj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221795-137361@https.bugzilla.kernel.org/>
References: <bug-221795-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221795

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |REJECTED
         Resolution|---                         |INSUFFICIENT_DATA

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

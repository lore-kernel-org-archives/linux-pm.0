Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A33C942B
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048293; cv=none; b=KT05FesBhlJAm23t3aUQg3ZLJ59zUPCf9k99iALnC9Z9YcXD43kCH7l2VZavol3Y65EDvnhyPXowr81j05ELfQZuYnbZxjXUppZSEtXC9QwW8gMi95/flxlZ0TJx3bvV9M0R4s0tJnc/Eo1GuVs9XXxLhj/uNeyoGYP4tdQviRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048293; c=relaxed/simple;
	bh=I33e8HgpYjdy3oW3Wkcd+jolucfiJJHAjk5D37Aqj3E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnfcAWQGHDF6PvagucxB4R7bgabzP23CLxI7vkLVfZL696R41nzYP6XuQxPR/WEq60KfQzN0KkwtBCSIqv0+87jdc4oxkYGY5BeX2XGOaQUN+sH/Q+KsREPdy9nMTA+54VnbHDoRNvJV+qMhafhpq665vYpLPCOH9yNNX/PPx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2zbfBAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2zbfBAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA1DCC2BCC6
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780048292;
	bh=I33e8HgpYjdy3oW3Wkcd+jolucfiJJHAjk5D37Aqj3E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G2zbfBAJMBN83iwT+qwJUGJYVMO8dDmgj9w05cbg9OUTFHNmM9SgM/Ygs0Cax9XRd
	 dDXVB0Pk94AWCEseyxMLJeofivrVLbwwSt1+euulUhcJnk1+DDVdc3lYbgSM1x4A9x
	 kFepv9zpTMFzEaAoQA9Cfvf85yqB4cCzSXXZIgjFI7eXvYijzv/MyW/7eGFbrhtxq9
	 IrC7IBP4JaPIYDd7ACAMZJpwiHpgKxHYcMKiyE5V8UUm/frzV9+CEEGBtXNIovcBaf
	 Umqzmf7TritpEY5qmYFEnQzfS7nKlhmlZEzO3VV5C2Ezs1c8IpyWQJOzaY25e93GPS
	 h1h6id+KVhryg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B1107C53BBF; Fri, 29 May 2026 09:51:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 09:51:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergeyluashkov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-0X0w0aVQ9I@https.bugzilla.kernel.org/>
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

--- Comment #19 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #17)
> Mario, what's the status here? I know, you and your colleagues already di=
d a
> lot of work to improve things that came up here, but it looks like we sti=
ll
> have one important problem left with no solution in sight. Or did I miss
> anything (which is pretty likely from my external point)?
>=20
> > since 7.1-rc2 and still in 7.1-rc5
>=20
> Given that the problems Alex' had to deal with changed over time I wonder
> (a) if you are really seeing the exact same thing (b) if this bug slowly
> gets too confusing and if it might be wise to start new, separate ones.

I don't know if this will help, but I'm having this problem on kernel 7.1-r=
c1.
I tried using git bisect to find the problematic commit, but it's 13 iterat=
ions
long and sometimes the kernel won't start, so I gave up. If you have a list=
 of
suspicious commits, I could search for the problematic one this weekend if =
that
helps.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

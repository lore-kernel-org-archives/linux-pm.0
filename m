Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F931578E
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053517; cv=none; b=rhXL6a2lICeunCgcCoAJw9wg7BhSg51SgkzE5A43saOlw0r26HjzpF9bkVJbrYs2tXiviubS5ESi/uyLYT2gr83WMv+ETXupor573TU5II+YjPw8g9P4M+0v74psQCmDihFT4GCDg0c6Sgr95FGPLPm68tTkxf06CkTi9HUlhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053517; c=relaxed/simple;
	bh=vywPTDyU/vm7tU70uZnsVRNa8z777a8cdijrX0HGcmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnKzmZg/Denmxc3raVU0aT7AUQ8tt+yE1JFM1cnnw2f0z1slNLZRkwpHcQn6rshfc81+s1+76gyY9W6oERPDyWWQRMyqIVSMS5+IbkSdd/i/MnYBWXpKjLRH/A/zRG4KVrBvpDDzCCrf9Jq6A2eT77AkWSWc9oWNmgT132rh0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikB0kR1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikB0kR1v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB0A1C2BCB8
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780053516;
	bh=vywPTDyU/vm7tU70uZnsVRNa8z777a8cdijrX0HGcmM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ikB0kR1vN0vxjvaChMqtwPjSaH71IAhu3kgXjYuNL/C5PNQcTkHQEMx6KQCwOUT36
	 9KCJoeVgQiMtU7WRzbd/w8v075CzgNOuLrZXVqi0371DdJNYSw7W6KvFtByzC2+eTZ
	 ii6WB5/QgZF/pzBCMzWBHWCoWhf6BCcegG2WJofHpTmPEWPlBgeS3opvxOPmRqUqtx
	 krM/pVJUxPJ7jSaO9FNDcJzYzjwWUoEg42fAjigXlMlSsCUFdRo2JhzbX7Ml8BtYpe
	 yh1KSRdEfo2AuEGjAbT3j7K3NRlO26wLAgBJ9mag+c0tLO1Z7jUHh5V2gEmy7GxjtP
	 A/ERDy/hpVEnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6433C53BC5; Fri, 29 May 2026 11:18:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 11:18:36 +0000
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
Message-ID: <bug-221505-137361-vsRsM7hkFe@https.bugzilla.kernel.org/>
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

--- Comment #24 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Mario Limonciello (AMD) from comment #22)
> If I understood the root cause I would have a better answer for you.

One more question then, if I may: does a bisection make sense, or are things
just to messy/complicated due to the other fixes in this area (or if, how to
best approach one given those fixes? apply them at each step without commit=
ting
them?)?

Side note: Alex, Sergey, you both seems to have Asus laptops, wondering if
that's part of the problem here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

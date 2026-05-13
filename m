Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB63101C0
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653074; cv=none; b=Elfj3eDNA8aErwFWHHvhWRMzBjic0MPb1h1cgPBm6TnYHkcZzGnrpGoClbJxAtL9cYkyo9ATzfhL1m3210Q9qk8xm2BmnEJzR/rVVpJH99B+jMzznIgRplDriiQ3XoTzNFV5G44AtLwdE1fclsINBNKfLKFSQJu17xuWNQwGdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653074; c=relaxed/simple;
	bh=wyTU5XyMW/dJRklJO7X1Slkoh9WOWqeDgrruXhsvzZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5DUSo/ua4LYRxSREfQYI7kTfEBDp6yuSu/Ja9vplELBfanhPr0hWBGiMBAnwFfrbEPx0ZUOD7/1N0k94dSyWVk9gW4rFJKgVW1mKmUzPJuGtIISpemOhuuqMwC0DzsjEgN48fqEJ2V69hXnzh0zY1mCtIc19SNM33OLxfHWbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am0yvwCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am0yvwCF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 438E6C2BCB7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778653074;
	bh=wyTU5XyMW/dJRklJO7X1Slkoh9WOWqeDgrruXhsvzZc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Am0yvwCFcwPEkJcHcvhfYSIsdxNntjtYXKxv1FFCnbC6eLPrw2F4g6embnGNHOI8m
	 vp7mbRvV4o+QvI4x29hxAVqdmwqMAjfLEtEM92GL5dOI7uOsUlzfgREe1D9gAxm9+4
	 2rPL30Fa3svJYPmvGnoWAzkPsbZ/h4QdtCdqxSHbspypGorvi6DiZDIvtm75LDQ3D7
	 41vVVsBU8Qy0wzpy2DN/jN4/A8idaYKlSeDdqRSFunYQ+kTzoFcc0N5USJ49DajmGS
	 beJbpt7e5tiPQx4+E2oJNpo78UJPst9/LLXvqEVvG7QE2ZpcNy6p3T3okGjXf29WVa
	 DNgmFGl0LfNUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38F66C41616; Wed, 13 May 2026 06:17:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 06:17:54 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221505-137361-hpErXn0ri4@https.bugzilla.kernel.org/>
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

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com,
                   |                            |regressions@leemhuis.info

--- Comment #2 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Adding Mario =E2=80=93 and also wondering if this is related to
https://lore.kernel.org/linux-pm/14a87c99-785c-4b16-bfce-35ecbf053448@freen=
et.de/
and https://bugzilla.kernel.org/show_bug.cgi?id=3D221473 , but it sounds a =
bit
like this is something different.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

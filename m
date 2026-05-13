Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CF4DA522
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692327; cv=none; b=BkxdcKATYVqdWPndxwbLtHxD6l+RhPpJtvkTD8VxJw06bvGQ0/Kv/7iZqRHLvTjMFFbPkyc1aV3azMTSffB6yfhV/5KV1p4RAQ5B8ocOS3Umsf+NML0L+abbKlO/JY9msPPxKZSZGrppm964SRpy523eTdFdqdh29HQvEKBHqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692327; c=relaxed/simple;
	bh=LZJ4iok/sY17tylilKotJAu467OiPQzUjykFYv2h8ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHS4yGRoTGe6LSTwG3c5Q7Bk57+IBQgSg8vhhAvShXuptH/W3UsLbuMR6H6OJwNETU54vdnGRQxp/M0xAO+XSkdAArCLRyjwclu9HC0rCvq2BNt71TKatd8VC9qAClvUL5IDww0Nq+NyA/2mq4aCwUdFqHzV/ugVlZ9CiKUaLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOPu99/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOPu99/w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10DEEC19425
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692327;
	bh=LZJ4iok/sY17tylilKotJAu467OiPQzUjykFYv2h8ug=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YOPu99/waS6S9B4BgoUyM5j2PahyRxyVWtYT/HjcaUFrps4eb1FKENX2dny/uuqRN
	 /vocuH9fGdBb6vJtwWOFTbwaStusuziNeXu8J7Nw1p4zCsLeV03sYIlLxmOuB6anPp
	 uwGIHI9fvyEM2zEWP+NbiV3T/T4CdWjagTVZiMrPw374I7xI6/Dop99Vk3Ly4anfOR
	 /iclS6rMG+0tX+UNuuLlERulhEGlbG0Pbz2ntBGUMqhrVagrr9uHU9tfoH+6FOb3AP
	 4cyqtOfqhg5EAKFzbAg9WkYHSxImTCmfU7MFihu32O3cTmLfOTUoQqDvy8niYYwE1y
	 8p5AkgyPNUbvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 069C1C41613; Wed, 13 May 2026 17:12:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 17:12:06 +0000
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
Message-ID: <bug-221505-137361-SRn9M9V0wQ@https.bugzilla.kernel.org/>
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

--- Comment #7 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you please pair that patch with the patches on this branch?
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=3D=
amd-pstate-fixes

There are multiple bugs at play here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

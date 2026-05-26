Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D725B09C
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777659; cv=none; b=nPaowwA2K7xBpfbcyKe4RNDpvLMx0eiRpWUorWt69ZTT3w1qXPl+pl8isEhibW5AT8wDofNgwlHw+chkmKCMqgd5wvkFz2Lgsh3o4VA3dfqnhrf4uqCzX60BWFewPRfEQVr4YjDx2kVUjMyMkwICmqZ1GrLZ+B7D6BbJ1bJ3bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777659; c=relaxed/simple;
	bh=wwCng7KgiMwaTs82h2p8o/Z4HHQI4ar/s8+mC2zsImY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYJ7mFc4YArjP7z0LRzpEA0/hLIpes2VEL9GxPfMT4JyaqyoelkQgPr5z44/WCjHWebU0GJovslWS6vQxIPYrRovjMMwfw8LbAO0U2am4GJnUxJYqvpcsjihxu3z7Vp2qEHU4istJ7h8znhpWstulb6/pCzZYt0aIWHBmLm21MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6krVShL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6krVShL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5B8EC2BCC9
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779777658;
	bh=wwCng7KgiMwaTs82h2p8o/Z4HHQI4ar/s8+mC2zsImY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n6krVShLasA7wF+N9TokSRruT3nIuciHKRcfpn8LMK6DCmJGOEqJAvigIOBDdmco6
	 8snudiG3uMaC0QOBZjEhfsaPDnllgW4+R3SQJloYfFWmHtiMQVhD3QyDmZchvyFrQC
	 RBlLhi8fKFz6V2In4Z6iRSEiSeANpj39XlpD0ms184iN9gXpYrqCS6PXc5R4nbQ3i2
	 dgAhIT4FuZPWWImb+AxxN3yoMokttAvXRF/iPk3f/aOuOJKpJuxvL6iIxu6LRcLX3v
	 bhddsGJLIpiXnzDToL1bTOI/SANtRWQPp3D/rlpM7v9boB7OP9fK19skPimnbG66CG
	 kdxobHNVqQ1yA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D01FCC53BBF; Tue, 26 May 2026 06:40:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Tue, 26 May 2026 06:40:58 +0000
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
Message-ID: <bug-221505-137361-pHXR677Xvt@https.bugzilla.kernel.org/>
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
                 CC|                            |regressions@leemhuis.info

--- Comment #12 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
Is this still an issue with 7.1-rc5 after various fixes were mainlined in t=
he
past two weeks?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

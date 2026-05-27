Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173B4508FD
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903716; cv=none; b=k4KXcWKKE0xfaJMLdsuj3NH+jAx5BcWVoe/eadNPXfglC9HHOcphY+QRu5LMwIVrhrd1vhZCYeTLTjNwddkB5fZVMae/bgEk3sNHiqpre+GfOTHFMn4OiJEV1fVwt2VQQOSY66dHqLFEQO/SLuN36OueGJX1ANQlFUTOTuk4CE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903716; c=relaxed/simple;
	bh=wMGYPyEHfaURyzp6NmlLresqtVNZbycu2MEeDb5h4ic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IE10C3ja63csZ+dJ9yY3+WFrYTRvtMenOGejKXZPqiEMozr+GsvsXgciThpcAUFQHTJIP+Cp22SE1RKJHrBX5dz8Dsxd6v3be/sSviQg4+RFxHvI77LlhsOv0UfqWeLPT3KhJm8SCEq+Ran8ZFuYAMtzSVDW7mxLgdUbM03F9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSqMowO9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSqMowO9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFFD0C2BCC6
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779903715;
	bh=wMGYPyEHfaURyzp6NmlLresqtVNZbycu2MEeDb5h4ic=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hSqMowO9ItSJggZbKGG8/FdQhzxxK/nB4Gw4fgkynYYwQ8BSqYJA1HuAzV7ogaM+u
	 Uwdo0+y8o08+hehejTehfF/+vf7yeYYAcJV7cPbvxznrb7SvGk1XaKuxul6jZ4Icf6
	 UfppqkKKIdAB309tLNPmnpzSInWdZhFWR+jXmMh5VXOAR2kzFampazw21hWShthtc0
	 O2U2+Cb8JzhYIb91VLpIlrb573TNUTajI7kvMbE/ZMCs6Ogu0A3Sx/5Ih7Svhykosq
	 nXhNjH/lTN0ALtMPfFrnko3oBY1GpJym9uMPwlgUeC4q7QFosmfHEO8ejVZ5znSGCb
	 /u3FGMh/3Od2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BE28EC53BC5; Wed, 27 May 2026 17:41:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 27 May 2026 17:41:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: axra@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221505-137361-OlIHKbBe9Z@https.bugzilla.kernel.org/>
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

Axel Rank (axra@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |axra@mailbox.org

--- Comment #16 from Axel Rank (axra@mailbox.org) ---
Yes I can confirm this bug since 7.1-rc2 and still in 7.1-rc5
Additional there is a shutdown bug since then. System doesn't power off
completely.
CPU: AMD Ryzen 9 7940HS
GPU: AMD Radeon 780M Graphics
Host: VivoBook_ASUSLaptop M1605XA

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

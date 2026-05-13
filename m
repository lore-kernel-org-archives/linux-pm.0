Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80793357D04
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670203; cv=none; b=ftqUGgv1DDJhpCQW+10lceCi71mEjINXiLUVlAqEq7hHKdIxwqX/UbEdgwubqMNSXgoB8eedWTqBSmNePckafUICI6rLthyOg1V3E8PwmVOREtl9SRd357Nl3PW9sUjkK7t4UkaL8BiDdGYoNv9RCw3Tgtb8CSl6M/INc3sqZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670203; c=relaxed/simple;
	bh=okcgBjusIeMQD61yC2mSDKJqtxZo1srISQYNgMzoKGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mCxw/+ZjPG2fH0bV/vvYAs2ssqNCWF1HPpmJ+VFFI+jMNzmDLkuFaNdXtubtK7O6T8x/xO4Bne9nUvEXwmDHqhNrmJ42+Uuu625HqMLbMsGLjVamBFeoIxhUH0EjWmSZWrkM5/leg23ywOm8VreR/osazsoTDr3Ked+/4QWnPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrcvtNlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrcvtNlz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15EC0C2BCB7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778670203;
	bh=okcgBjusIeMQD61yC2mSDKJqtxZo1srISQYNgMzoKGM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QrcvtNlzBACzSibgP1Mp+azIloF9C+LujBOPRcwBafQLbW0fUbJjCjBCeWDLAmIQF
	 vKR3RUZ6eWVmjQvBzmFQYHyUHLwhoZhZF6BOLDO6y+IGLj9Xev92292JV4BQzMFca3
	 retLDC64ITlEt9cBozuFtUcqWPna3ZvAEXpLjJMRQ9OHEjQ+z85PEj7SzI+p+HUjyN
	 1Hp4d0olaXjdvB50tl0dO6yWWzLHnL8uz9EhI8gyxb8e+33fgB3oQLKYUbfIH0oDMk
	 guvcn5WLt57c9HMOCpBtgzED78wpRISi0Gqcviq8c1kV8G+cBmVEr48pIxxz5RrWaA
	 LnRplAhcPkoNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0B0B9C41612; Wed, 13 May 2026 11:03:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 11:03:22 +0000
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
Message-ID: <bug-221505-137361-VVk0IpHZlj@https.bugzilla.kernel.org/>
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

--- Comment #3 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Did you set CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

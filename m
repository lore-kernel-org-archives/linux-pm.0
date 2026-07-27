Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5941CB3F
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164443; cv=none; b=lc29nobjRZQ6g0n1wv9/jE8OU4aDOcr0EozaOkwfTn0QY6ePp2LyjMd6EDBMip2mA6E/lG4P/kslR8j6y7AXPh2R1lhv6CY/O3A8LHpOu9XHH9/IrvgEeYAGh++tYNpCpISxfQpSjMulGalWGayLBO2m8Zy+zN/sKF3aErfvzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164443; c=relaxed/simple;
	bh=6eBVvCIZKINxwlVGN7A1YXk1Zfw1VUk2CFaTrZgZwfw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tYPfutCxcOwpTLtnygnYYrr9ECypdksRET/xwrgmSt0H0+7UYt6MR62FdWmvLGnqYeqEkxuQt/SZ5w9sYRS0CfzzwwDQ9TNK3xjz1Yp203Wr4lIufbAeAVUze+t+89hWQpD71lA6V8Vcy1YYNtJ5LftI1p3yyV4pC4ePvu70PNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSPaS0Q/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSPaS0Q/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A030C19425
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785164442;
	bh=6eBVvCIZKINxwlVGN7A1YXk1Zfw1VUk2CFaTrZgZwfw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gSPaS0Q/BpoDLod85rFYW5lYNtLypL1aFPkXQeqv0TAh8NzBduJHRPQSIM1n5wfh+
	 cylJQLxdFbwWxf+kIciJ2HFKsz5eq6OUO6HRZXgDLJlnTdYjZxcccWVrvj9hK7NKrC
	 mXIbxJv0uYkP0TwzP4fTtsU1xgdXKTRvKDHAFEnv2PMY2OktCejkpkyyzzMBYVi1qy
	 P2qho3E39g5FNL7K0z+HVKJFctJ4n318PuBN+3fqkmFeuPvDG4Y6tDVEpBWVMCCrVY
	 J2Q0lZVD/RocpZ3uagrZQUZ04NFJ1K7MYJXBmBv46Gjw4ej+L1psWIqke2hjzzD5eS
	 mbrziLAxHvJnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7DF5BC41612; Mon, 27 Jul 2026 15:00:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221795] amd-pstate: max_perf stuck at nominal_perf after boot
 on Ryzen AI 9 HX 370
Date: Mon, 27 Jul 2026 15:00:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-221795-137361-sYSG6dXV5y@https.bugzilla.kernel.org/>
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

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #2 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
CachyOS carries patches (mostly backports).  So, they could have backported
from a bad place potentially.

Can you please reproduce on 7.2-rc5?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

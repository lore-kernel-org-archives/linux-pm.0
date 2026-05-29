Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8393B895B
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047697; cv=none; b=uJ4nwy2uOQbMu1SeEip5WDrKrZx1Fm1NQIiiVg9fOcJJccYBDwSxuNAP2/OBTDZGAnrcOg+dP9xhjhDZTZ0R5sDdiHB/S9ilNEGzmkbVsjGJHTC8paRsRt/grCw3cRz7etcof1f4xjLi+5qCwwenGEO0QrDvRNFwzVz6TZU3bEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047697; c=relaxed/simple;
	bh=7WaHcdPQD9IB81OxrTywZMq011hbR1e/h+XWweLS4NQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPZjVd2+1/GbDUyPXrXvmIIP0rKZ/9CDpqz1gtt5R6FkRPDZx6jeiDVcDis7eRm/a+aWfIA9/N8qVUam87I2CFVfkntnSsD9f6gQeNkhA3eV6u4axMIrR+eV32RcXQjnwwIv/z815CFvrH8BQTcR+Sbf4cWNTLLxuN8EEMM6dJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHzhVMW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHzhVMW0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2B2DC2BCF5
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780047696;
	bh=7WaHcdPQD9IB81OxrTywZMq011hbR1e/h+XWweLS4NQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eHzhVMW0dhXTjJRvTbu/bo7TCeFS+tGvbEW9EwI78EDibQxYpo735CWWMlz8OkjLO
	 WxqTKbm9oxEUnA1KjL5Tq6xbQmoI1nPrVbbNzbCdQg6oUe5nYkWfd5dfw/4Tc9RRt7
	 CerawGaXrB2vPXEOBmdQ7pElgyGjBy34+4mkbNxye7nSo9XoKtAJ+710O05UBxQNVn
	 cWfDP6Js05E/LqpRfPi8Og3Hf1HnRE9DnpYswBf/AjvyMO7+9Cai6ztw5Y4dmrxKXR
	 9soXRo7MyB4a7ecJ6vc3RdRqCkyZOM/PGu1bYQYO4/O5C/q9kQlGOJ9nDEO+WJnAZW
	 XXWsQLq/ywaAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C1049C53BC5; Fri, 29 May 2026 09:41:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 09:41:36 +0000
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
Message-ID: <bug-221505-137361-JeyZGdFwMW@https.bugzilla.kernel.org/>
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

--- Comment #17 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
Mario, what's the status here? I know, you and your colleagues already did a
lot of work to improve things that came up here, but it looks like we still
have one important problem left with no solution in sight. Or did I miss
anything (which is pretty likely from my external point)?

> since 7.1-rc2 and still in 7.1-rc5

Given that the problems Alex' had to deal with changed over time I wonder (=
a)
if you are really seeing the exact same thing (b) if this bug slowly gets t=
oo
confusing and if it might be wise to start new, separate ones.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

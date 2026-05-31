Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266D299923
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236873; cv=none; b=rtNSaf2SBrLkAEohZ581gdgJMqNHFMqlSjPpPwpKy028Wcq07TaWUdzTYTlcmGkLQgMDH5NmK1XimhAyOjv8bLZs2R09U9eqHO1pWXBU3tgFGMC4hmWWZo5xafNQMHkGRQx0paIFMIKb1/S2cNYXhNOF/Sb2VgnV0YsA5egoGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236873; c=relaxed/simple;
	bh=kkTqQwXiFrTq3AeGCB+moa3dPEAuiSo16ng35qv5kIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2L9G9NqO1lABxpQ+K7t6xr25spc43QGVBTjaicM9mrXdMOxjVAt+FjY1LK5giMT/K52/yyrDXDlwy+TH4wAAyAlW8PRFBnmABBSnE92LrOFsDDKMqjRvhLvDo9A/gUlOZxVq6gCw5fcgVYlmyEHq5YfSlGOKE9v7BYjVmPlnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLlWWrzs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLlWWrzs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5F8EC2BCC9
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780236872;
	bh=kkTqQwXiFrTq3AeGCB+moa3dPEAuiSo16ng35qv5kIk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lLlWWrzsLHUP5bSPVizuICNz3FFLQWqhNLLwcstETUGzD7KC1huR9aBbpqzfJA6hM
	 Qj/dl88pRVIa3qme6+rHRO4U0GUNtUDM+5e2csmHoHaAuBOwWhSQxfFoHsZRvneVp/
	 u4zc5ftiLVrE9FdU1Dt+2sgVF5dk9KYK0Up0vKiHAuYTfj/M7T2uooXjrOqgoN+OKq
	 /RjVaOUaYtNRvzhlWi1DGF9RT4HxJGF/J+wPzA2MPylf9SQsCxB1dthxSaFpqU7HPV
	 9/R7WVQaR0e/Ez+JonrEzuLbnIN7U1CrdZnTqIIe1CTG4zU5HS26N4jsuaWkviAxIk
	 0TWY7S2eHZDug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C445AC4160E; Sun, 31 May 2026 14:14:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sun, 31 May 2026 14:14:32 +0000
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
Message-ID: <bug-221505-137361-PFYVvwHcFu@https.bugzilla.kernel.org/>
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

--- Comment #32 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
No problem, and thanks for debugging in parallel! Feel free to leave some t=
ags
for review and test on the submission.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

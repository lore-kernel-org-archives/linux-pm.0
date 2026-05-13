Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4844E051
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686988; cv=none; b=ISh/vqMVnB13D2aPEeXvxjGhdnqN6MpNK8b+CFZFRX83gEovHIEtwKK+4TsEIczD7X/fPV8hzPOdEZ6AhjQDPq7Ar7xzBq1ljwk+zQtvPzwvR4pulzm/dx5e+nNq8pphb8VX9SvHSCbvQbRf7vo5PNHro39DSmJYF2tkWdusDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686988; c=relaxed/simple;
	bh=StbwjspB4BbYesLZ+trsF/hDPPAGwxaCla7z4+PZqkI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qk22RmwlkLhnUnbFRFt+OhBd1Jrx9r76QhN+WyEsYG77ePb7W+I2lmJXF0t3v529zZD0iAgrjFWXp6s3A9/r4zHs9SsvuIKpjN0C7CrSkIpNZdqD5yhPBVsY0yI3E+/2QSn0I69bZ7Zbb34mqLSPlE6CjVs9H8ONnOE0DypcgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c39COy2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c39COy2V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B184AC2BCB7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778686987;
	bh=StbwjspB4BbYesLZ+trsF/hDPPAGwxaCla7z4+PZqkI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c39COy2VwplwyTdk/6PtaA6mqr8UuhtpKca1Ym0LS6SG4hp7MIibrVFobpeoR6NlU
	 woJ9NBmrb0kdPKaKPLX6sejI6+s2zpYW9tCdLnifzhf3isw3/Nwi5vI7OlLKr6d+OP
	 YiDtKf7TBoSOiWQfdbZ0s/6VQht5Gp7rV3/XXeEoDwWlXQ1La+bBckGLm1zyrdavGC
	 4VQ4U4QxjLX6L2v9ykv6B/9afVDpQ6SZeEMSGRmnUNAHnUizdEJeVS3CgaSnzotA4X
	 ftStae0BcXcv3pBmbTdnyANQtYCPTk9on1EJ+LptftKCe8wkGEqE6414E8fKD1iX8S
	 6o+y8g/emJ24Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A23A6C41616; Wed, 13 May 2026 15:43:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 15:43:07 +0000
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
Message-ID: <bug-221505-137361-1V05UwRrYP@https.bugzilla.kernel.org/>
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

--- Comment #5 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Yes - this is expected behavior with the series right now.  I am proposing =
to
drop the kconfig and make the dynamic epp mode opt in at runtiem or kernel
command line.

https://lore.kernel.org/linux-pm/20260512221947.1652988-1-mario.limonciello=
@amd.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

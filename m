Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6923CF699
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787373; cv=none; b=W764ohbFMSyK7uNNaO465af4Iat6lvxdMF5BU/p6kiF/QIR6WlbhLJ8AqyBAc9DCMbR6ev6wzZttnVnfuiPged+4OziZB1X6S8H4zl0MmvN6aRhHXKHC2H/keqB9GkRryhCuM9VWq2DOSLUdjXy2qCl94Upvwjcb1RqyHFTfHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787373; c=relaxed/simple;
	bh=f5Ip5MoNMqo5xCWQ5WJqD/NuvsxW2Ia3YpFnyvgUMUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkOJ1S6kJVHH3INf63qhZ8rsccIEn87U4q3Y4b1W1/0o+pzhU+rmP9zehGN1Dx5LgRhZECyg/UoDQ4aIBmT0BhlZAR76yCRoC0F2w6d8nCajqNwfzhHLf2ZHMAN6JQBkTRyqnicZcMfXiw9l+Zis9GIhsSgbtBkMS/mRq1dTo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjSjd5m9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjSjd5m9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D83AAC2BCF5
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779787372;
	bh=f5Ip5MoNMqo5xCWQ5WJqD/NuvsxW2Ia3YpFnyvgUMUM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qjSjd5m9WjUc2Gg571LUwyKo9fii7VvgserV64QcWCxH07RYsbULqgtfnsFvfQURz
	 WOla4VhZ1dPNTGJ2Mjei6sfqa0Zhq98TS+InlkboIoQtu7TBDijP5x/vTtBpdYWFFA
	 1s0v8ZBofX9Rb5u8CinKBrWmvBej3bCA6x8tuFHNG+jgyMcoUuZ5PBV33+wuJHVSdT
	 u2WT53iV4+LDAnHDN5C/KbOwbOiBaixfFpUPtMOpJzYFdw2wjBV1ZumkZkaFXnN/UW
	 vZXvzcUQWmDC7fepbfDmHaxc3lTiKjjJNb4ANHohtawGr0iJvRcWcMW8zdqu0bZUXL
	 rRbWH1Us3OzHA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C4D3BC41612; Tue, 26 May 2026 09:22:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Tue, 26 May 2026 09:22:52 +0000
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
Message-ID: <bug-221505-137361-YQ4d3hgJ4B@https.bugzilla.kernel.org/>
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

--- Comment #14 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
This is with dynamic epp off you're hitting that on 7.1-rc5?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

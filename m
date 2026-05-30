Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FD3BFE3B
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165144; cv=none; b=CuUb6VsH82oyRcEOmwgzw0sdpcPMhIEu/wgHju5XcBUGO3uVmd/8tjLZ7ilqGCX69C39BR27/vurIgviARLI3miIXcWdb6X4l39AfR8Vw1DatpiVb9fHotMPcWZV4Rb4ToKYwJ0EqVJh0YdEuz1dOGEv9p1wv/DugTDYbOJBEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165144; c=relaxed/simple;
	bh=AYZSqMfvlKug7s8l06K7yE2gbnl4SrPd7TZxm0Syd20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJfKRucvaktQF9YpVj2ZrzvrLzwWqOL8IucnSNMHSGYnPWCFaMA/kmS1qSDshpblD0Zb6cnBktMuVDKikNO/I72n/o3FgaaPWfg9YPnYH3GxBSIqz6ixhhRjimVHXoGN11/NsPIZT+VFTNZVC+Dk/SCQtD6Q566XdYtJfy39s0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCjnkjDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCjnkjDo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4189DC2BCF4
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780165144;
	bh=AYZSqMfvlKug7s8l06K7yE2gbnl4SrPd7TZxm0Syd20=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HCjnkjDoI7YauIHbP5jY5sh8RTQAeqrnGBGoYVNoQRvwcQNFQ/C6n4XGBbBIHHtWl
	 Ph+qXjEgRRApEHP/4EIRAiNeVf98lIbbKWOGdQFiYR3U2p+ozFu9NsAx1rjszK+kSG
	 om2D7ghMffo3MCKX4F8y6gKB1pnoCjw9qQ58vGLUM+Mh8XPzDstA7Dwl8koMfdyKGn
	 un8lbI5yJV37DHGPewRPd/2jDyWwpozTtsUh9/fR4aomCo1sYp+tBvH3d1opaRxuAN
	 JFfw7TWRfJOMUI75hWJMj9W1L2UDrRzPQhox9MeImsiX67o0iMQMl4a2eHDFh2s0G6
	 sSmwTRtakrRkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 30303C53BC7; Sat, 30 May 2026 18:19:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sat, 30 May 2026 18:19:03 +0000
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
Message-ID: <bug-221505-137361-ahfsZeOVk7@https.bugzilla.kernel.org/>
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

--- Comment #30 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Very similar to what I just posted earlier today.

https://lore.kernel.org/linux-pm/20260530154121.1670781-1-superm1@kernel.or=
g/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

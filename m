Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D923806BD
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530558; cv=none; b=nQEtJD6u72JY8+TquMOdMlaWqsV2HmGErrzsCZmVcznxzFamMhekK6FUSNurNiXpaJeuqiTyp489fkiPRHOcGfHB/ghWNqKHE74QEMdSwTmKflx8tXcakkPVim8URfZb+Il4sIzUrb5EeFw7Gv2MOaS8Zchf8UaDWihx3xNdFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530558; c=relaxed/simple;
	bh=wdqvfpMdf8VzelqVOH6izvLnK8hVCp3u5CyeYsYYmu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnTGJkIcFFc++9XjCnzbywOpWFwJBZHJKCgQaTPCobXU1GgZD1a+KEafFVxLcXsFFmGDLYJlAuIwtPrr1Hcd2I8QULLEDF3BLSn6VQKwyBGQpVsdwk2oijUXDE7QhJV7ianqRoZnX2z0S39r94xqpW1KsaUZUSZDOLZmWkcBJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efls7vlF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efls7vlF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCD6BC2BCF6
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 20:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530557;
	bh=wdqvfpMdf8VzelqVOH6izvLnK8hVCp3u5CyeYsYYmu0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=efls7vlF2a1mzOR9bu7/7OfwNK34dOFxwxpKw/PeROcjt90EoLVZtgaaXn+8ZHs1i
	 9a1Po3LZJ0H0v7kMk0PpLDWej5zaHJGZDpXYajjxiIqRa30BATXupzWMbZEq4VSY8H
	 zEVr8p9lM4J78DBjGsywSh/2xnqTYVF4go4jZvuUyHoav2j9UgCLKgb5uAGuNCHfPX
	 R7bSGVyRHiPFKw9L3SXZml1k1lmP7M+5OcWlnnoC4+eLc7ggWn++L1m/DT6k+FHXBF
	 DPudUKFdFTnjtoYMDCOPkmcuXiwRC96RbXpIhSJOyttAX7LNliL0/s0bzAfQwzxc5E
	 XpEpEddsb0Pwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0CD6C4160E; Mon, 11 May 2026 20:15:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221506] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Mon, 11 May 2026 20:15:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221506-137361-LroI9Xdp0N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221506-137361@https.bugzilla.kernel.org/>
References: <bug-221506-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221506

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 221505 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

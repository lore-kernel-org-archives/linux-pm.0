Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC43806C5
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 20:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530558; cv=none; b=hYgNFEYfdhqdsPqkNx+l3nBIDYxmYIc/IoRXcfWMmKC0jMzJnHotxA/GYhIiZ+ioAZwZo0i2Oifyfi0gGfRrnubjtyI81YYME7IWgkg0DTfESChAx1QEs3ffd2GGKey5wVew3zO1uf0yDSF0NkhV7bygGWmTQLhmdu3IfdVsUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530558; c=relaxed/simple;
	bh=hkdkyHolDmtHhxiGZv4y51gBEzkB2LAajOOZHoKRGP0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sYe8ZVlW0oYbHdPfu83IpQYv8ttx6hj1TwsGxiOIACelPXCf/UwQ6DsT6+u2zoSB/mv6XfBtuEJ6YS2ILzOgAm/6rIrQWth04q0rZB1rNWmdhLcV5RO528E0UhZvGtMnUduPPpyBjy89Nd+W1l9t3dDqOPEPnV4Es1aGmj7glE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s++E3VrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s++E3VrE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3480C2BCFB
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 20:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778530557;
	bh=hkdkyHolDmtHhxiGZv4y51gBEzkB2LAajOOZHoKRGP0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s++E3VrEQ3w4HFAE1BN9+Y4bW6mlmxNDnWPXyNZ++xdX17Q/owXughbyoXamNoyaI
	 2zm5frWO8QPAYbDuFgI2rHLC7iuaTpJhIq746AlE8y4Bifff4z5gf4gmRJnFnkMdui
	 3/LrHgWnQgmlXnVEpjyZCPdBYtSgLbAuqa/SDgcN/zeOgx/7iogvpHrHPO+uwAMJpP
	 /Gq647v1K6pqwcjt/6dTvrNlOY/LnTCGiv98wJDuLcnwPnyPr1OZwtuN9T1lAPdV/W
	 Sy6WxRstCGKwIAwCbfuHGL5Fu5uISa1PIfHdgPtuoiIpaGBowaBMUNEr5fw55vhtIZ
	 7lL/UxAt4JVDQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DBFACC41612; Mon, 11 May 2026 20:15:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
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
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-uc1I02MpbM@https.bugzilla.kernel.org/>
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

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 221506 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

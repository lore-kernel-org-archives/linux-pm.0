Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804893A961E
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697696; cv=none; b=Hm2ZEV9zwaG1f6G23F5Th9HxYDZf1ab8m6xOKHSpo7lssSeZ3lXrII01X1N/IuUACw3nEUdjjP4PviqQXdQf1+jK2O9qBK4BoqWAEod7WuYcMeVERYuuwqhYg8ue5jv1JoBfms5U0A2DKZzmfBPLujGSunVaWiTLhSeD35hpQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697696; c=relaxed/simple;
	bh=oIYPe7dGoZNEeceRxMJxjyPBdoxnvOELcZPTwcO9D+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rz5I5U3BYgMv6S+UgMXB+lWd98zxTKmoE2e5VHhulMS8tPu1HsXrfjXU88ot518vjJTWMHWDOPhhrIwoMER9/eqGL8Vo1bgWnfUOdRg0TCLWUNlRxvCTBoPvtM6qjHhrm1JPAbYRYQSq4iUlcvbuUPDJNSv6uTpv3k6dyOyXQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlZlMKej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlZlMKej"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79DC9C19425
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697695;
	bh=oIYPe7dGoZNEeceRxMJxjyPBdoxnvOELcZPTwcO9D+E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WlZlMKejc6Yy7NWeBjKjdqvFuKzS7zK9UXTa0ddlstjUJBOfJjJNwIt/BzzZ8SH2+
	 0DywTE3/RSQVi1l9JiqLqeMFsxXEmYhMTav+C2MX81m+2gAkPiT2/fPlHxAYLi71Wd
	 uf8jz0C1NOwnzm/1geLoXfPpi597k5nTV9JULMw/ApnwfmdCUkjxP2Cz5zVtEyg0er
	 YN2nYnB1oJs0yyor+yV9XPR15A63wwnSj63eVNePvVt0ildjQButaYL0FF9sxjgGsW
	 SQO/zO8PLHTumJwN/UnSjc56CFibNKUqRcMsMWK3VPP1GNZ7odsXCD7vG+71xzAYk5
	 HKivmVe4MydHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6E6FCC41613; Wed, 13 May 2026 18:41:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 18:41:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergeyluashkov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-vK2yX730fY@https.bugzilla.kernel.org/>
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

--- Comment #8 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #7)
> Can you please pair that patch with the patches on this branch?
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=
=3Damd-
> pstate-fixes
>=20
> There are multiple bugs at play here.

I=E2=80=99ve tested the kernel from your amd-pstate-fixes branch (commit f9=
f16835d4dc),
but unfortunately, the issues persist, and I=E2=80=99ve discovered a new co=
nflict with
the ASUS platform driver.

Current observations:

With amd_dynamic_epp=3Ddisable (or no parameter):
The behavior remains identical to the initial report. powerprofilesctl still
fails with the error described in the original report (Description).

With amd_dynamic_epp=3Denable:
It breaks the integration with asus-nb-wmi.
Specifically, the /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
(which controls ASUS thermal profiles) stops switching to value 2
(Silent/Power-save mode).

When I set "Power-saver" via PPD, it only toggles between 0 and 1.

The CPU TDP is not limited to its expected ~55W threshold unless I manually
write 2 to the throttle_thermal_policy file.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

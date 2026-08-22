Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395573AA4ED
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787398537; cv=none; b=HQ8rX9MiWXxp3Fb6OJ+adZK/WFw46WT6suXPlXWKjBT+w3dG2s6Pq7rhaozQdSvPeUbqPwWXxlDC/ln5ps4qF6x8iaaWxjDUAdytBX37HHUFqOvLRNarrUo28N17jGBkMJbf6h38WMTQbDuTpk0F3vclip0FsYwgjeOFUjlPMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787398537; c=relaxed/simple;
	bh=AxPKtlcXlutEUchGDJK3v4lwJyW5EeUZtwfLt629KIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ze7HqulioB/TwDoUHLgDKvNm+cgqA/BZaCJmH6vUZg5MZRDkMuXGpfqOdBsmzWmY/grsPkGGMcC4XkNNDZzdXXHzvF4FVaIBoBltn1YrTGlJm1dh+tgzDAPZxhGPSU5nOYyavx9WcASdIEN0QielFxyUxLj6jp+Wu0jwdEfkAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw3h/6WF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw3h/6WF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89FDAC2BCB3
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787398536;
	bh=AxPKtlcXlutEUchGDJK3v4lwJyW5EeUZtwfLt629KIw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iw3h/6WFW14LfT4/b+75igckLx+WPYODzMJjoEO56BhZnQIR3Nm8NBDCVcrCuXM75
	 0m6umEJjBR/2R89Qwuxm7+e5mCPBDagUZ58vfBvjrDlaP5kQGCCNTudwmtnNYoXsHc
	 Cw7zgx2tnT4cyREN+U5/9Mol7dQMy5QITVKux6odku2mqIeAAoTz8kcroRkNyYIoQl
	 RH3ZgKr3prIzONz4FS3FRZY1vxlKB0bQezxJceg/HhrD7CSvxMRGsIZNCNsZs6KQEj
	 fO8HxJnr0uSWE0ryJG8HQ3e+mMfS9vHo0B/si3wd4DifCq6NqXlynudaE+WpLAX0Dr
	 WYHzoRZeYPFvQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77866C3279F; Sat, 22 Aug 2026 11:35:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221909] amd-pstate: Cezanne (Ryzen 7 5800U) data fabric sync
 flood on DC gated by CPPC max_perf
Date: Sat, 22 Aug 2026 11:35:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: smithd98@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221909-137361-WPrmunaJtJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221909-137361@https.bugzilla.kernel.org/>
References: <bug-221909-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221909

--- Comment #1 from David Smith (smithd98@gmail.com) ---
Created attachment 310715
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310715&action=3Dedit
boot ledger, crash triage, 5ms RAPL/hwmon samples, system inventory

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

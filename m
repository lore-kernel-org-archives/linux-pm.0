Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B1332EA7
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163926; cv=none; b=g6Xnp3vULmChZGCDs+ORG+jCv59PaCa5EtMRXkbYl52PVa9MlV3dfooe17ej5G9PAz9iHZZ3ZQ410uhaUJ0KqMEMXm+cgoFn6yTEUzb8HA2Plsm+bYLpblpr5Jfi7f+6df45WlUWUpuRiPRQejJgkrevDP3mNOmXQz1wAadPHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163926; c=relaxed/simple;
	bh=fNdk9jdEFqqDYyfzGyWd7wyXR1LalDJ/Qa1mqrvxmBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecr/cSmVmOvTvRgiDwBnZtvoYvFtHB0DtSxm8OSxTom2ydtEjaJL77/jiBmhjY9MMKQW1FNV6IhvWQnyN/2zD6prdxc4ck/owAwN2L0+ylWP9db3KQCM524H7rdapoy+d5us3gscpPa1Ci60iVjMsCs0f+KjEmDS0qYqwEuEDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma+5CuMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma+5CuMb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48C86C19425
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780163926;
	bh=fNdk9jdEFqqDYyfzGyWd7wyXR1LalDJ/Qa1mqrvxmBA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ma+5CuMb49JE6oAJEyA4PqVA5/istSZytuYLrZcb0BRLmHdyGdFg2v42kf1YGcyOe
	 uN2OgR6GDu3+IuySm5jj7Be898ySoasImIS11YCy4HKJki0PuTv7IAMgj7eLF2IAES
	 ffm8j1kakEWsPQd/Mytl+e0iZ5HiVHPyw7tnjGVRN+bzxtg17p2ewDCblzdRMyn6nV
	 tkuwH+vJMk8zW6NymwCzlMQagDseaY9s08d8py04PCrUyk/SKoIV99103kdvJrBYdx
	 qkd3Iy/pC/Vlidl3ZNIYo5AFjO0hGizT62k6vw5TPGVNTyE4xT2ezW979fl2Ydb4Is
	 mKjNsh8rqjwqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3810CC53BBF; Sat, 30 May 2026 17:58:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sat, 30 May 2026 17:58:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexaandru@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-4lY7xMU9po@https.bugzilla.kernel.org/>
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

--- Comment #29 from Alex Ungur (alexaandru@gmail.com) ---
That patch works for me on 7.1-rc5 (AMD Ryzen AI 9 HX 370).

```
$ cat /sys/devices/system/cpu/amd_pstate/status
active
$ cat /sys/devices/system/cpu/amd_pstate/dynamic_epp
disabled
$ cat /sys/devices/system/cpu/amd_pstate/prefcore
enabled
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

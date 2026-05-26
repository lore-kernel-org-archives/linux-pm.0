Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B73DD877
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794588; cv=none; b=OVnUb6nIemrm2/hTEBKuW5+JIxlvpJhaf4pu+bOcBY5jYHySTXw6dP6ZIIa0Y4oxfS4tD7iGqDXIIoqWoPj5D7q3C3RKSMEpJz13bdjoC9E1gDRir1Js9JxzT8Y4S4EI6Y+FA0AU4nt6ftIggYTUnZ+KWfBXGix0zOZdKEjmPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794588; c=relaxed/simple;
	bh=9pjGGHSFx5N+6wdxXfKeTUuxRLWYi+DpjSUlSolJsqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfNGNfyZqS/eDImhVSjqQzSV3kYzPcPPfWGviN2yegpBf7o4V5Tx54nucJW8l9u42vHThD8opWE5bHQixRsySiikh+eeVZFQBNcIgW6L/BYNS4wbxkUS8tuKi5QhND3pEmuTIQayZ8aFySIaPct2+UNNrUFOszL4zUE2jpdIVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2iYArWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2iYArWm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0274C2BCC6
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779794587;
	bh=9pjGGHSFx5N+6wdxXfKeTUuxRLWYi+DpjSUlSolJsqI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l2iYArWmHmoUDafsLQzW4e1xiDnQuvthySy8NdvFxqqJSMwlpROOb6hYxBk9EGszh
	 9U7k//T6igTb0Uj/UUxdCFMCboByBJFriTwEgWJGs0oX/G1yzLLnoy5Z6Xh3mWpwq/
	 ejkg6viOgsmP61nAgN9vwizgNg75FBb5gb0wfxjm2oWNrSy+2e53jcYsmYHLUbGM9c
	 ZTdcoule51U5X0MqiGxzlFNtucrWvt9N8aqqxSRjLrafEpMRTW5dobQ3GUpU7i0KFa
	 AEpH1O5PCcq0KirjzqEtMTI2NJSFa/oKr5mKZPWbH4dnX9S3QvcrHyjVUYsry6Ttx2
	 fsJzSVfb8lraw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BA0DEC4160E; Tue, 26 May 2026 11:23:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Tue, 26 May 2026 11:23:07 +0000
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
Message-ID: <bug-221505-137361-Wc8025m5xP@https.bugzilla.kernel.org/>
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

--- Comment #15 from Alex Ungur (alexaandru@gmail.com) ---
I believe it's off:

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

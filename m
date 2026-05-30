Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B363B19BA
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148124; cv=none; b=Vj7x8EHtBFi5Nj7eE+BCPVtRrhVfYZ3Q+ExuGTOI+hUmX80VVwbhAiNyP1KPhRjrAuaPapDSqEJ8jv6+r5ANW5hZpVkmWf3cAWH3uAJOXQvijMMznZcT2cnvNom4N5vgY/UVZSk+ZW2oG5VlAC7/exnz+kUI5tQVf24P9yv/E60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148124; c=relaxed/simple;
	bh=u9AAxWzvkIMsTTvbeLu5J/zWUHD1eIYHLF2oJofU00Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocvzWhVkNZvqJk9OpjXAThsf5kaaUWwxtDmiGd7Mkh9n9Tq1AKuYr/fBuatL+5E7vXK3IixmvQXwBdqi277V7sLQg3EC+cKHpHR7tAy/k4GIkZ5gxBwMQZmYHXMWFI0Ln/N/KBdz+NfUtni7xE4IHeHL6SXit6uyxPaRtiMSKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K91gQ/ES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K91gQ/ES"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DA5FC2BCF4
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780148124;
	bh=u9AAxWzvkIMsTTvbeLu5J/zWUHD1eIYHLF2oJofU00Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K91gQ/ESnAYUMAywxMc97bDocwtIPSLctQOJSMgInZcvnOHBSGg3rac4LkzUtcAc2
	 TBvL8Ni2vwomMHjLPod1r2qH30LbIwGen72yJCT/sc8TPirX0x6dJXOYhOCULDnT/k
	 CX6nnhkm+JWXaCOwOzlRpmJa+av5j7XkHgTfgxHAQ7fM4eKF+BigFqoCZSWFe3xcYt
	 HDtl7dDSQRPM/kF880k6Yc/NLZ0EkGhcj20rdUpCnY5T9QHWJpqLybUUhd5z3+ZZOh
	 Xj1Z//+604YZX4xWs4lWBwPOpK9Iku5/Hpv1l3RQ3E8Ma/F7SSdt4vFvEtyfLNa8eC
	 /rDyqp+1t5r5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EFD54C53BBF; Sat, 30 May 2026 13:35:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sat, 30 May 2026 13:35:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rhys.r.edwards@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221505-137361-GCZmGOU9Z8@https.bugzilla.kernel.org/>
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

Rhys Edwards (rhys.r.edwards@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rhys.r.edwards@gmail.com

--- Comment #27 from Rhys Edwards (rhys.r.edwards@gmail.com) ---
Just updated to 7.1-rc5 as part of usual CachyOS update, can confirm issue =
is
not fixed still exactly the same as before, pretty sure it started at rc1 or
rc2 but unsure. If i swap back to the 7.0 kernel using the kernel manager
performance mode works fine again, if i set my mode to performance in 7.0 a=
nd
then boot back to 7.1-rc i get that same weird half broken frequency limiti=
ng
thing where it won't go past 3.0Ghz until i go back to balanced, but then g=
et
the communication GDBus error trying to go back to performance again.

=E2=9D=AF cat /sys/devices/system/cpu/amd_pstate/status
active
~
=E2=9D=AF cat /sys/devices/system/cpu/amd_pstate/dynamic_epp
disabled
~
=E2=9D=AF cat /sys/devices/system/cpu/amd_pstate/prefcore
enabled

This is a pretty standard desktop computer, no battery involved and nothing
ASUS. Specs were listed in previous message. If there is anything else i can
run to provide details let me know.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

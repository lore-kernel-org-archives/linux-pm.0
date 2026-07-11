Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2203175A98
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783791203; cv=none; b=C+jFWrY50qW9XCYiFkYB1YVJZa/yuoJL6jxRQJVmm82+5AbHn0WOVBR0qTRnn0c/JnJAKbnJV3F7LrzKRlcGSn+3Ez0fGb0rLSI4e5V2O/fUBxJ0Ygq8wkFY7J3Ai5Keb4oAAgDfyq85RcosfgZwHOWeNNu7XR2vXauLpWXKe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783791203; c=relaxed/simple;
	bh=er+b3n1/aiEYDK78HSPXhQ3ohwXf87ggnAo5/cQlSdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mC1iQsUM+T5rmsbN0xEHSyHOBjgZFtalWWJ1Guhwy/VAn2kbzvzv+lvL741x/v5NKrlTg9iuw9f+aoJ7f62tAbAbtmibNZcRQ8Kaip8xFNbbp3cl0Uji63BQaJC7Q2+7XmHwY4TdPTrpSCHc+IhUrx/IXPdHww+7Lr3fN4FZx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0tz4b24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0tz4b24"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 372D5C2BCB3
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783791203;
	bh=er+b3n1/aiEYDK78HSPXhQ3ohwXf87ggnAo5/cQlSdI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U0tz4b24Kp5kgies3GvFgQnOZ2VN3gD7lNUCtWl6kjbURCa6R259Q8Meg+BB3APrr
	 qdRvy/BFu9yX2DfUX/zeJ+u71NzxndIo1BIz51g+nGLwDQZmC5VdD8dezB2EDsEyyv
	 oKQG9WGBAMb5o5YyOENbo/2gq8XyxNors/zmbmGQz9Z3eopvtmqQ3mL5AFTpqWTgIv
	 umD7bGgkAgjNyPJGebma1IjiPcK6lZgpDrnBsDC5Eq3GHlXtLC6SnmANcVi0fnMxu6
	 Oqdv+l+0LJKN1M40EOOdiqKzmyuzDFD3BfY+LN2dvXusn+ZoCQ6H8LeChBnx9VGnUr
	 fur/S19YZdD+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 19F33C41614; Sat, 11 Jul 2026 17:33:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221744] amd_pstate / ACPI: CPU frequency locked at 520MHz when
 AC disconnected with lid closed during s2idle on HP EliteBook 6 G1ah 14
Date: Sat, 11 Jul 2026 17:33:22 +0000
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
Message-ID: <bug-221744-137361-y8q9JBrGMJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221744-137361@https.bugzilla.kernel.org/>
References: <bug-221744-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221744

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Does unplugging it and plugging it back in help?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

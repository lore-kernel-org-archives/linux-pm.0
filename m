Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319333624B3
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338340; cv=none; b=ESgzUvDpS5ID9zScrYaOwo7ZzK75frzRl4g7Pe+SMDFGon0+XSCyfC6aC5bwwR/NgJqhSuY9USGgh3nLgNeUvUzBd6hEXQJFUu3AxLfl0O7mx0utotY89haNtnnM5JRSqmkvIGLOQL/bsZS/BU87FH+YSsLsdRGqhDPYQiPC61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338340; c=relaxed/simple;
	bh=8NNM8ImATdB4T7L8s9J56Yk6mK+Kws8tJOuhn4k4jts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEpxLF9opGXzCDYC/4Ei2b4Uhf7YF0X5CiLiUluCBBaRikLzoaNnzntO9risMrUjjMlhJdmSxjunaCzULA3wi7WdvSuPfEX84C9S81cOVIMvtaU1x4VSjtYc7sG5jx8d81OsTyexQIZl/oRS2bsGmGE4eR7FeBWiztOzJMgItgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4P+N/Lm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4P+N/Lm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C28D6C2BD00
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792338339;
	bh=8NNM8ImATdB4T7L8s9J56Yk6mK+Kws8tJOuhn4k4jts=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V4P+N/Lmg5yeW4krlr9H5NrqsUXkjQkiKXTWN5NlHaNjJUE0Gi1b8X/MySPO/FMa/
	 pLvENXTLyRZ4+ekV5oEXsC+JtTQAMg/63Ip7R/crf+h2UIn50X1EXzo5AyHqewVR8N
	 5ORCVxBd9D5MpHUi5NVWWW037qb0i5MFdY6Zjk/gRleSjJOpE2ozwl2XZKUFx3mayu
	 kravcRcUw+2zMslhYlsAWz+XxaEgftK1NCCM4xz8WdBODQ5S/S7baOg+g221Ld95Zk
	 2mi6Blz55Q5IbEMqxAChs7kExUdRX/guQrDGLtrNcLY6LqAWJabrkFM8538s0kk9aG
	 2YNiNq7iBggZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A6974C53BC7; Sun, 18 Oct 2026 15:45:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 222146] 6.18: AMD (Ryzen 5): cannot select existing
 energy_performance_preference
Date: Sun, 18 Oct 2026 15:45:39 +0000
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
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-222146-137361-hEPuOxiJ5d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222146-137361@https.bugzilla.kernel.org/>
References: <bug-222146-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222146

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This kernel is not supported.

Please try 7.2.11.

If the issue is still reproducible, provide your full CPU identification
string.

Ryzen 5 covers multiple generations of CPUs.

lscpu output will suffice.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9134388A
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878753; cv=none; b=u1ladIV/Pa1na6ymZ1ld8oSrXVpo2a5BnmNXZ9TsDfoQ6fCFE4gXjtwArDz4dN+zi/NnelfCwmPBWUWXuwreDJHeURrZDUsiYkOV2Bp1ZvCUveF4wfnZcPSb/UTYPg5V6tyyJnYiowc+QkMP2tie2AmbBQZO9p+mD+I7AnmZI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878753; c=relaxed/simple;
	bh=1xE0ktLQcMTn+i6N6dVpSv9SOy7AECVhDemVnW+8gVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OL2z53hMqbJpqEx101Xj7ea4oBkJapBIvZQXeJq5TkO+9v/j9nY76xfUw5xH16n9NzNgL7Vh2YkEo9/zE1loixTRhp4Iove8L4VBN8M2TDNfUeVqpmBGyI2X3g4LB1v1TJ+4oSJ2XjwHEo8L0WloBevkhSk6ixZ17Im9yS2Zh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib9ImqVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib9ImqVh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3332C2BCB9
	for <linux-pm@vger.kernel.org>; Sun, 12 Jul 2026 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783878753;
	bh=1xE0ktLQcMTn+i6N6dVpSv9SOy7AECVhDemVnW+8gVg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ib9ImqVhPCnmIBtfE4pKFpEBsXfG+V4tIcZWPOn/g3eFoZE2ugRdtvNDdoCRP8Mms
	 wnjZU+zLVE/Tm+nhnR2An/E1DMemGWKk4eiKKEU6E9WyJXmQoSkhXfFd98WZ68r+n+
	 /QT2Dp88osPg1FUfeHffFTV7eWDivpdaViQmLw8Z5oyM/u4dhjQlKv4xDkc4yNpf2l
	 eKl22aXxj041JSHfu3bCRRqhB4KejhJ5lf/uqhwWEEKuy5t2z0I+uNPpYQ85e9iS38
	 WnZ7PeBaNVnWpvln71hD/EMbC27WX2X7WUipFJEvcU1gYPNbZIEXk+bxrf+2XbWjzG
	 o6tXrCkBJSoxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D4569C41613; Sun, 12 Jul 2026 17:52:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221744] amd_pstate / ACPI: CPU frequency locked at 520MHz when
 AC disconnected with lid closed during s2idle on HP EliteBook 6 G1ah 14
Date: Sun, 12 Jul 2026 17:52:32 +0000
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
Message-ID: <bug-221744-137361-Xd5F2oAzr1@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
That's an HP specific EC bug that weirdly affects only Linux.

Anyway, it's a dupe.

*** This bug has been marked as a duplicate of bug 218305 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

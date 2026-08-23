Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708A1A681C
	for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2026 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503525; cv=none; b=U+oFYwYwoaLzJZE2H2bN9tbqukCGFQ2n/+Bc3TscDsDIVlsvbplUrG+V4E3ixqR9ivMqo8N5ULbrCuSlxCtvmG8EhPxtz4RQU5148BodwYPCtbGwZkZSr1ayUHHSHtW8iPYRVkiF3ZeMMLHoC+HS6/V7MhPJ00P6pvr0z9MtsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503525; c=relaxed/simple;
	bh=2Djwe1QCWiBmJrk/QXcz5mi6Tskcp8XaiFf3qBzhV+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzkV0YD47EusvZcCoVhoHaM/ya6SzNTiIoHsMIe0o41YOqmCJVNEGbmOgdqzUfOQqWXS5H2AGO5f16MwXIy8H3yLWhJKW9d5fe/3sPowI1uR96vo6+jQhKxekJ4dwwKisj8IQlnK8Pq32x3EEw02vgMZbU0/CaCamIBHN8bm6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK3xyaPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK3xyaPm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7BEBC2BCFB
	for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2026 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787503524;
	bh=2Djwe1QCWiBmJrk/QXcz5mi6Tskcp8XaiFf3qBzhV+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uK3xyaPmk3xxqJqn79qMAqGyKOXf3V2O+4VmbpvBj70z28mhIZO+IsRmKf8iuZDg2
	 /4AlrFzPSNySV09cffv1dHYlGlUTflmz4HPUdsxyAtdu6ndauE9T3uiA2/AaVDedxl
	 DmeEoF/+B9Ps37MyWTw2IuVHluek9dQeiLaaHhz5tB1YKyYBebw5FYMLbZwLZU9xi2
	 5QxbobOoaUzU3rUsHeTjompYI/ObhduAaqvXSWtl06dALN5stYMQAAl4IbrSa6eq1w
	 8otcY3JSu9SmL5PQBAvl2+5qnYI5RN93BhZWBp5UcsJhQlgA+IR9zCUB2ZKXkX58V4
	 wSp+R3njcG6og==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9A6D2C4160E; Sun, 23 Aug 2026 16:45:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221909] amd-pstate: Cezanne (Ryzen 7 5800U) data fabric sync
 flood on DC gated by CPPC max_perf
Date: Sun, 23 Aug 2026 16:45:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: l.perneel@luperco.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221909-137361-Ze73lTYH42@https.bugzilla.kernel.org/>
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

--- Comment #3 from luc (l.perneel@luperco.com) ---
I want also to add, that the issue is triggered out of the blue. There is no
need to add some load or anything. An idling system can hit it as well. Als=
o no
traces at all in the kernel before the sudden reboot, it is only the next b=
oot
that the reset cause is printed in the kernel logs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

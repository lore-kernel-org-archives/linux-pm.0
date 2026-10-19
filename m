Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07F4825DF
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391404; cv=none; b=G5l9tu2WfsgkL2LsU9nzJJYoLY6f1dJDd3jkTvMqMey6+luj9eVIoORrxHBicsK6p1Mx1qdCM8a59ePDUEopQbpTj9sdqb/Vd0KMvY9J01vuW826MBbnh4iZypsSiy/xN8MDHYLi2ViDG4qAdItSRE/fdZiREu3gCQzVEhVgJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391404; c=relaxed/simple;
	bh=wOODFzggeyy53dcSd3NkchGhOXQXitOriCkPWmRcpNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZSZi6j0l0j5/0nXFLbNaDHipMoot/u3oqApfCiyBGQo2SOK8zCKEMRb4Lh12toXb4JDD+58IqiEAtgIDNk9NdoCOAPhJht8Ym7T0aSJfFkUvgfzG1v2Bgv6NXmpkQUebe9/YouO8obO4YygdlzB4AcFtT1owbXmtTzpU0uoc3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4O5dS1f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4O5dS1f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C832FC2BD00
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 06:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792391403;
	bh=wOODFzggeyy53dcSd3NkchGhOXQXitOriCkPWmRcpNM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n4O5dS1fSBETCEKacE7Ecs1sY7kDlTSfXWNopX75S6Z3noAi4n0UcsjYxMUpoEJ5H
	 N9yAqn2ne9VXrweZvg2fa7IUq9y8d8sD7rXsTxAMB6SitZ/94t9k2Z5qDB7I0DB9YM
	 bDruS9gQo5H4dXUBwl970TrHaEDEGOG7qLd9a9SzvUetE7Rmt74fiP/Cv3YW9XX5Qd
	 3JboMuLSzmJWO2mv5iHgo9xlBtFqdJbHbm8Y+K8B3wSEvTL7g57l/llhsU6MGaw/Ke
	 qaJ+fWrmBDj8RHn2sQXZwVoyG9pZ7mXHJQrdax82x2BUNcsN7m0SSzqy4dtIvJNe0D
	 KAzE7UB6TukfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A9367C53BC7; Mon, 19 Oct 2026 06:30:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 222146] 6.18: AMD (Ryzen 5): cannot select existing
 energy_performance_preference
Date: Mon, 19 Oct 2026 06:30:03 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222146-137361-rDUy6xPJlY@https.bugzilla.kernel.org/>
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

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Wait, have you tested 7.2.11 or 7.3?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

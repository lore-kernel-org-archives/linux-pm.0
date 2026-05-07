Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B662F8E99
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186202; cv=none; b=Sgj9BOn4gcXDf4A5lhN2lF7CjQqc5WUV9CFkJzw6SuNGamPBwa7zAKcn90E5dGc50INjNWdV1+vqu0jMtFiBwc0DCcZdOeb3BXjAkJftTY+n42IcEY5QgVTpfStrnxkI4vPuceim1AsrInyLHBwSPvip0UNuPSnz87qhl4dicqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186202; c=relaxed/simple;
	bh=n92Ww0Mv0X3BYvNVb+UdA9S0qBkA2Kk0icUVmS1QMHg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8WVK3catk/ZB0ALGKWhUQ0IUBYAoyMB2x4ffmfrAjrigsdkQyWdwMAVQ50nSVWmc1cBpmbCZvBDtxOyKiicWvQOLRKnJ4YBYutIkTGBLpfdAmJ9N03v21PKCAaynE0StOwZScWYXUKV9eXa0LK3DC3oTBQc4KiNR482c4RmQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9aGcpIK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9aGcpIK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1093C2BCB2
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778186201;
	bh=n92Ww0Mv0X3BYvNVb+UdA9S0qBkA2Kk0icUVmS1QMHg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R9aGcpIKKg0N0uk3abM5HxIAt0yQCAL5000PUXVH64puSqjVTC28t80IA07ZnMeG0
	 JLnXf9EczlMGmPx5oYtX9d/gAMppKtA/OElCkaQyoSUJOJx3RiOI+kO+Vmv37x95hk
	 AnykdTIiVhNJYMGEIDtRotwLXQuHlzefIKRO3lVZJiPD5NcvvhnlToLnKljDibUbju
	 tRxq6GDyFhZPfVOqSYTTOtfllx5R5yyQTm+tYyinnZNpEfdkjfR/AsUNVLeIdy/31x
	 f7mInwd/EEJb15yiV1IJoKcTDMLvVmVFGWnck3tlk0BvDDbO9dDLVR8ikmV6YFjmoi
	 yOSIo0nyeDlCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A36E4C41612; Thu,  7 May 2026 20:36:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221473] amd-pstate dynamic EPP regression on Ryzen 5 3600
Date: Thu, 07 May 2026 20:36:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221473-137361-zQlBua4LiY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221473-137361@https.bugzilla.kernel.org/>
References: <bug-221473-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221473

--- Comment #1 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you please share an acpidump as well as the output from the amd-pstate =
tool
at https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.=
git/

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

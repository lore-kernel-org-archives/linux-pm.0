Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DB3403E3
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049423; cv=none; b=sltUeTCJbrDtlhWPmUReBfvEMR0yywVsVMv844bOo0u9RM3szeEGq15ERP+7P+2BhyMWX53Bx4lsODBKD0rBYpcZmchcNh3EziJCkEjT2bjJ7kYST804Ji2d9aZ4AoHofJ+9H/eaTibKKAbVWWH0uAZofCDHlRggKZPpwvvTvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049423; c=relaxed/simple;
	bh=NUl0o/2cucZKMZ4E7xJ0vevr7EQOF5V7ET5Co78NACk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncTHrIDZdGCHRr6/uAyvwERx7y7zCyHqZCbYb/dBls0YnfAmwtbsTh/4t2revrpZ95RZ6BtSdxk+Fw5Dxb2tU+u9dfpVszsCgrPKJmXFHCZPoweRjJxSn6r2nzQGY7lJXq93Va4DcE8u2lbxgGhHzU1qWBwM1oQqw0K08atOfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgpVTqd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgpVTqd0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E4BEC2BCC9
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780049423;
	bh=NUl0o/2cucZKMZ4E7xJ0vevr7EQOF5V7ET5Co78NACk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qgpVTqd0/7dZqfO6+PRC72qPeC70nH5o7LOQr+0QGPU/WTqsh8h766152lR5TIwf8
	 xf1e2Y+3XjfC/tTmzRSpxIV3+CPb135EiCck4QrWCNmVztayjyBoRxLm/wSE/FKCGt
	 0txl+GxzWohMOXdmrZwYizGVSu9X1/MmVr973SjA2f+5FFNHpbcG0+PxMKlf3CeR8p
	 4fu/InAxwF8WyPC1JjpeI94G5mxLR0LhYpKhJPqCOSq6qAViTI3baiE5efCIh/Hoo0
	 GWB7m6ZwwMcqzSv8ZzMyOYBQGWL+Un2a/stAK5ms+iJJPu3jUs/Yfeby0JpkSUVPwA
	 hZqnEkCHfVLUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 57F92C53BBF; Fri, 29 May 2026 10:10:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 10:10:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergeyluashkov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-1ZBLIdE0YA@https.bugzilla.kernel.org/>
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

--- Comment #23 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #20)
> (In reply to Sergey from comment #19)
> > I don't know if this will help, but I'm having this problem on kernel
> > 7.1-rc1.=20
>=20
> Quite a few problems were fixed since then and a bisection likely a waste=
 of
> time. Check if 7.1-rc5 works better and report back please.

The problem on 7.1-rc5 is repeated

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

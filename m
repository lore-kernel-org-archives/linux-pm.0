Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917C2C08AB
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691439; cv=none; b=ru3+k1eTw6+gtb98/z+TF4AIBPic7KU+VtGfRbzhpkUHKPDOsT+XKqqO4JTWwpw2LrU1AW3ToI1iB0TtoqkoO+i+iYY4BdrvU9cXACyLU53Ny8RV8OlQkqPDtBI+GSOLdT7sVypfVyBhDwiEcOoI8zZA3nEPZWg73x6Mr+BE24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691439; c=relaxed/simple;
	bh=Z/460bbf4X9Y2VACc8ZS8QDkBPS4FhvaeP+QjcALXyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG+suQa7m+ui7kg0zpBJQcZKk7wWzAAXid2ebYIK7eMvKb0KKPY1W3FYzK1j+pUGvzRfKVvGXaRINvYfDHX7UQ/0kbeFbycgdZVSSFPd+an2l6Y8Uhge34YpJLldguF+VCPL3yMJBNHdhBbskb68NsURSkIFwFYNmcogZiecMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciCzEKOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciCzEKOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04496C2BCC6
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691439;
	bh=Z/460bbf4X9Y2VACc8ZS8QDkBPS4FhvaeP+QjcALXyU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ciCzEKOJoLoPZi/yybQt+HcpZrfrcukNR9af+q0BJ9ZCU8Zyh41s8G5Lp+CYU+iYb
	 NiZ0muK4HHa7GlM3wGY4iTadeLB7ne3KZix901SK84TmSgl2o63/VMMY8gV4zyUc7S
	 BNV1cUJkYlUtJKizP/FbOkm46eNhDC+JJ9GQolohjjmlkoRsk40lcs++Hj50Rhl2d1
	 b05F/YKd0MrNHqoTMNLrBKMiXEpO+3M6KlSPtk8mytT6ahouzvvqndgI0XdUVW9AeM
	 iWqfJ/Htkr+WbMFUZYSKoXzftDgap04DC8fobfZsFDUU1pHnYuilYnARXa/8VaCLIG
	 HxCfyI3WMrrjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E2AEAC433E1; Wed, 13 May 2026 16:57:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 16:57:18 +0000
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
Message-ID: <bug-221505-137361-AfnZfFJega@https.bugzilla.kernel.org/>
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

--- Comment #6 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #5)
> Yes - this is expected behavior with the series right now.  I am proposing
> to drop the kconfig and make the dynamic epp mode opt in at runtiem or
> kernel command line.
>=20
> https://lore.kernel.org/linux-pm/20260512221947.1652988-1-mario.
> limonciello@amd.com/

I=E2=80=99ve tested the proposed patch on my Ryzen AI Max+ (Strix Halo) sys=
tem (ASUS
FA401EA), and here are the results:

With amd_dynamic_epp=3Denable:
The issue described in the Comment 4.

With amd_dynamic_epp disabled (or no parameter):
The issue described in the Description

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B125B08A
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166667; cv=none; b=npdIt4kC/0t8l0NLdIU1984iz953yt3h9/gL1ZecPrixRFVOyQgrWi0X8ZALpG9ayLbXdvf0NTYBPP4pNdgP1pczFh/gGB96VmaQzqSkQdjl0CnUQaTuRQ6t8EpOXr9is2lmkIiC7Jh/Df1i/CFT73mMX6eAxbwwT7ksQEeBX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166667; c=relaxed/simple;
	bh=zrsTKx6WuZvUpq1xHD32BkPglM5V3+MurM1uBdS9b1E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQ3yBK/WNPLhBJCiLO5E/jmrWUJxwl+CGKLyRt2oM3bWNrE2THMIrBervU6ENS5VEwiyI/+nE/Mn3NV3Gchr2ACicOAj+gzEwv7mpcsQjTF/UZ/narVv0o/0rTSyKXh1HwXmhMYpnI0TtD5N8oXvAe9TTJlZZIAs1Rjip7YNxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEYh8UFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEYh8UFi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D334C2BCF4
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780166667;
	bh=zrsTKx6WuZvUpq1xHD32BkPglM5V3+MurM1uBdS9b1E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TEYh8UFirhuiNsuma5PHAs29E5TmkdO4dkzovwX9FWsfJAQxZSHW9gcixuWLA6tVz
	 xzGgP6YqLyOmIoluUZ0GXO0bqd1Wi2Oy2/I1U9SHQ8eJoc0EcAFt2m85EkBSaCO1sN
	 WdgjsuSjBu6Lk7k9XQ+gOcUrV1y9trv90iBzlWH9Cxz0la5AR8zhtPoMDRbcUty7bG
	 T3jaEKuikmmxbFLViAsSz/PTemudnODKkMtRP6voN3P+q6yts/IE4K24VdqkO16ywS
	 elrH/uAr9xO6PPyr7XXXepTTPuRLH3IUnGrLmrB8/PUYhy7aV3dNZAqTP3jqeMqCZQ
	 tq7jc1TTF4GMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 40079C53BC7; Sat, 30 May 2026 18:44:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sat, 30 May 2026 18:44:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: scardracs@disroot.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-nvwThLz8vU@https.bugzilla.kernel.org/>
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

--- Comment #31 from Marco Scardovi (scardracs@disroot.org) ---
(In reply to Mario Limonciello (AMD) from comment #30)
> Very similar to what I just posted earlier today.
>=20
> https://lore.kernel.org/linux-pm/20260530154121.1670781-1-superm1@kernel.=
org/
> T/#u

Oh sorry, I didn't notice it

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

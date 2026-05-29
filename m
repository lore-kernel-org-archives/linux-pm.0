Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EB3CA4AD
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054308; cv=none; b=axqNFw8YuonR0H5R9Fn9JarMHU99thsj1QnjBUHzLKbX2rFq0GWry05ISdIx2DspscrtXBXfHPMQRvFrVEyNQHDBcWOR492wlsaodGwIPWFcRndIbh7ojrwjXsnAQCj/Wx9T8/fWMlZww0yZPDWozVhTBCE5NZDggYRUtVMJ5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054308; c=relaxed/simple;
	bh=kts4Hx7wCVKuqkxIsRh3p7N+pKju6YYHuZIB9F9mqYc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6l679cjpbZPO1whowzZLFUC1smm3U03xPbDSROAn2G0HUO4iQOz76ol1rbyxTwhXfg5OmumR5ESm2AFhbr2VIzIzlHF+fe0P4kHrzb7oTLuuzyZdIPBevbb+LJ6JWm3R1z1exvzgrQaMvc5rsp5x2wF3Bmm56Axs47JqbTMpLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqLniu8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqLniu8/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 784E2C2BCC9
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780054307;
	bh=kts4Hx7wCVKuqkxIsRh3p7N+pKju6YYHuZIB9F9mqYc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PqLniu8/CBhjCaNHR5HjXqac58rJNIqiGTDo6n1edotePOpiUCv3YbvCu2Fa2K/u4
	 Q3MzwlO8FWR4qpHV5XHJDk32FaK6gP/4LwH4NKrEB0ElRictXo6gMiYN3KkM3FQ9ZT
	 dx4iMFqSyPafdYwv2E43m0jDxPhs6xwMeijMYFlYt8dkdO9N5E96oa6LtcdPVrKjZi
	 a2VAOXft2xJeLew5PZLPtNPqNEIde+idpVy1AnaYfsLTg7poqgFmUyQN2Q7anpqO2Q
	 t5+q3NGmWyJkEXCVMt3kcTWviv+eAqbaXp9zthWV2olf225i/qcFgqzhB8nk1A2J58
	 SG/quemJ0mtyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6529FC4160E; Fri, 29 May 2026 11:31:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 11:31:47 +0000
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
Message-ID: <bug-221505-137361-56oIsgxsi5@https.bugzilla.kernel.org/>
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

--- Comment #25 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #24)
> (In reply to Mario Limonciello (AMD) from comment #22)
> > If I understood the root cause I would have a better answer for you.
>=20
> One more question then, if I may: does a bisection make sense, or are thi=
ngs
> just to messy/complicated due to the other fixes in this area (or if, how=
 to
> best approach one given those fixes? apply them at each step without
> committing them?)?
>=20
> Side note: Alex, Sergey, you both seems to have Asus laptops, wondering if
> that's part of the problem here.

I can't say for sure, but I can test the 7.1-rc5 kernel on a mini PC with an
AMD Ryzen 9 7945HX this weekend and report back here if there are any issue=
s.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

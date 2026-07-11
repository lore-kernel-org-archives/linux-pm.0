Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A933F5A1
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754531; cv=none; b=to4gW9N2HEIcs+Dx1NcqUgICiv+vhZjviKduraEtXjsPmAbveodSg68GGyDMErQr84fLJj+UvdcZM+qgPXNIJuXxkJvYH23xRHQZbrrt6ETDvVaHeWLi4+KgQREv5voEmBH1/uyO1tnMT//n2BwRjrNWxV3vLVN1t8nTQoOBR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754531; c=relaxed/simple;
	bh=zwOGlpuGNtH88Yu6nJfxmwAPPcCMneAvf+omaYqZDpY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s+kPvjl6KTflEpx+RuTZ52e4TSGwpwBFOuchh6M/DzMf64E3LU7Bnydk1ZfJorH3SNwzDMCJ4C8X+8hnwQejn71lEIilzavSuDY8P45yECg8sgotXqTfkFKiFFuvYABURWiPkBmfJ1wxAXEruaXpRQN3kOZaZJHlxHwCG98VI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLkskqUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLkskqUr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C1CCC2BCB9
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783754530;
	bh=zwOGlpuGNtH88Yu6nJfxmwAPPcCMneAvf+omaYqZDpY=;
	h=From:To:Subject:Date:From;
	b=ZLkskqUr+3J/SeelRz889P2NP6+se4Pe4dWQZPXu5NuJKRSt9gmf0JDrJK3NID36N
	 1XbMf2R2o3M1zqk1Deh/RA0tkgjBjyLaaKm8jf7Ku4gD+MQdIRjFod8A4W46tUOYQD
	 IM0JzmVotLzarURn8cE8FVIW3wx3nPfD0RSai2YrjQjPDZwZtgPV8z7NMK1RdcV7j5
	 WQx8hznIhZFMtWVP/j7RslOR8orveoV3Z/IwPzrpY8toxkCgYzi74FnIGxhG+Y8hcF
	 DQ4jAvNrElhILBknBghM9nDNQ5AIO8O6CAeksxMJu05fbvxO2g4u1QjcpU9/jCC6bq
	 CRs9jbjYD3J3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 71CDCC41614; Sat, 11 Jul 2026 07:22:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221744] New: amd_pstate / ACPI: CPU frequency locked at 520MHz
 when AC disconnected with lid closed during s2idle on HP EliteBook 6 G1ah 14
Date: Sat, 11 Jul 2026 07:22:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pepegnu@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221744-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 221744
           Summary: amd_pstate / ACPI: CPU frequency locked at 520MHz when
                    AC disconnected with lid closed during s2idle on HP
                    EliteBook 6 G1ah 14
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: pepegnu@gmail.com
        Regression: No

Here's the affected laptop:
cat /sys/class/dmi/id/product_name /sys/class/dmi/id/product_version
/sys/class/dmi/id/bios_version

HP EliteBook 6 G1ah 14 inch Notebook PC
SBKPFV3
X77 Ver. 01.04.06

After unplugging AC power with lid closed, half of the cores run at 520MHz,=
 the
other half -- on 1.12 GHz. Plug and unplug kicks cores all to 1.12G-2.4GHz.
There's no software way to 'wake' the cores.=20

Setting kernel line 'amd_pstate=3Dpassive' or 'guided' *has no effect*.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

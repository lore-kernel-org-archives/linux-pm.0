Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67453377EAF
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881746; cv=none; b=uko8pmYltnlfeHOVKZNx/altiLtaKOoVI7LLXNfCFxPE80zotggEZec8dgvcAazPcUJhYOuqZkNl3W168yl3MitZqOToms5GRMyXX5HqxVa4MiJ+JYuzPv5FZtLYVVarXAr5qfd+scGJ94mXh/EWl1S+YGHo6jYHOEyYJr/LTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881746; c=relaxed/simple;
	bh=dhu71e3ptlnTcbCA1B7hBC0tQsBHxZZtZXe/us0oWPY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=efDtCrZqmS0MmWpgH/CDLrcx/2fIhe98UXXiLw/WTQ3ZJouUM6nFNPutLC0ZoPMptCFq5F5u5MWWOEoroJd24A0s0EbjZOR4FQjR8/mdQ9MbQurLZFT9FftAOCL7CBHDyzfKAjjcRWOmgLb6rmqEeNwropnnSZV1FwfPPXf+w/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH+m9w8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH+m9w8n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12CE9C2BCB4
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776881746;
	bh=dhu71e3ptlnTcbCA1B7hBC0tQsBHxZZtZXe/us0oWPY=;
	h=From:To:Subject:Date:From;
	b=LH+m9w8noTjgDy3As88v1LUhQhx5342gCLjAKkoCPtsHDDKxQvTd281GdGqxloLNZ
	 /0dNtYghB8kpvDuyfGGjlPZuNibB1GDpXMU1F9Y7og3SrU8wPPDsgmTpd6GbDLx/rw
	 o9SczzHaSfpBuTg/T8E67+k9yIC0DtRXlA9fWxlN40NAFNQAGG9T8+xNpEyNpmJ026
	 MWDaHg+uVV6QO6eaD15z8jr5DQnXiEV9OKHNTTOIBfYWF2ci2mSSAcJu2UQujhq1n8
	 wGDIJiOjyz8VQKkbRMqmgQG1BDhuscT9//AB37C0XdOWHZaSjNm9WokZnxSc6PiEUq
	 Qg2Lifl4KMsqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 056C8C3279F; Wed, 22 Apr 2026 18:15:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221403] New: ThinkPad E14 Gen 7 (Hawk Point) CPU throttles to
 ~544MHz on battery - amd-pmf PMF Smart PC not advertised in BIOS
Date: Wed, 22 Apr 2026 18:15:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fuposremoval@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221403-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221403

            Bug ID: 221403
           Summary: ThinkPad E14 Gen 7 (Hawk Point) CPU throttles to
                    ~544MHz on battery - amd-pmf PMF Smart PC not
                    advertised in BIOS
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: fuposremoval@proton.me
        Regression: No

Created attachment 309929
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309929&action=3Dedit
system-info log and dmesg pmf

Hardware:
  Model:  Lenovo ThinkPad E14 Gen 7 (21T1S29000)
  BIOS:   R2ZET32W 1.21 / EC R2ZHT32W
  CPU:    AMD Ryzen AI 7 250 (family 0x19, model 0x75, stepping 0x2)
  iGPU:   Radeon 780M
  Kernel: 7.0.0-1-cachyos

Symptom:
  CPU frequency drops to ~544MHz on battery and barely bursts
  to 1.1GHz (lowest_nonlinear_freq) under any load. System is
  unusably slow. Plugged in, CPU correctly bursts to 3.2GHz+.

Scaling driver: amd-pstate-epp (active mode)
Scaling max freq: identical plugged and unplugged (5134889)
Boost: enabled (returns 1)
EPP: balance_performance / performance override makes no difference

Tested/confirmed not the cause:
  - amd_pstate=3Dactive / guided / passive =E2=80=94 all throttle same
  - EPP forced to performance =E2=80=94 no effect
  - powerprofilesctl set balanced/performance =E2=80=94 no effect=20=20
  - ryzenadj STAPM/PPT override =E2=80=94 no effect
  - amd_pmf.disable=3D1 =E2=80=94 no effect
  - dytc_lapmode =3D 0 (lap mode not triggered)

Key dmesg evidence:
  amd-pmf AMDI0102:00: PMF Smart PC not advertised in BIOS!:-22
  ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored

Suspicion:
  Firmware is applying a hard STAPM/TDP cap on battery that
  cannot be overridden through any Linux power management
  interface. The amd-pmf driver initializes in degraded mode
  due to Smart PC not being advertised, possibly falling back
  to aggressive power limiting behavior.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668A32F770
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155819; cv=none; b=pOOTbbQMLoliReO++ZpaGZfnRzCbPJRMuR4G5pAhlO5J+XMpT/5r3STr+fT+n9KPBnVObE/7SVCMGVHKMCZjNhmEuY2eGM31K149r1ODl/ccyeXxBTOxKYr2ZQngwXg7pZDcylT6VtFYXDIeTXnVj6Np0uJRp4QTLMCgrm8axmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155819; c=relaxed/simple;
	bh=o9Zi02D73O/VFMmnQb1SDJUuh+DYAwGsV3V/tMDbVSE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rP5JawicQVSdVlaEw5mrqScCA8JymHPGAUliRn77w9dwy1ksCI5dMhate3cpsM1nv6xmVKXOfaFLPuy8ePqsJ5tmOPUB9Ix/2dYS6UNI0HgoJbwp/Cc9OqGt/tOWd4D5J/WSEM7AWVeIL96+6pyHHDo4P1gCsKiiY4QXZFQshLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4JiQuxs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4JiQuxs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A9DBC2BCC4
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780155819;
	bh=o9Zi02D73O/VFMmnQb1SDJUuh+DYAwGsV3V/tMDbVSE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g4JiQuxsm5CnCv0ZFmon2bqdzLisAryTr9WIPzXxl2MQ7HEIFnWe9+vczKloXFymi
	 KogbOqN2H1QC4nC1wd/wwIXEyv82F9F+1uy5fzqwngK907hk0Q1IR5ruvi771XM2ZQ
	 LRSHNCm4EpkcT6mp30M18CuPk1GAj8BJ3siDXx9C0HwcLWRCX/YZeyaymTt716vCwb
	 YFpNwHzkVJSnDGnJamNmPG26gBfMD/QcSRZ7kMs9okPDPDkPYUhS4w+kMJYYZp4dmr
	 hhzUx/FA1E8il/IyMP3SYRLeM6yOCEXICkTM1vnVKPdqv1qqSc+u6Ld9PHHMytCDI6
	 eFbbOnbqwnq7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6FD5EC53BC7; Sat, 30 May 2026 15:43:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sat, 30 May 2026 15:43:39 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221505-137361-E8Sez8ivzD@https.bugzilla.kernel.org/>
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

Marco Scardovi (scardracs@disroot.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |scardracs@disroot.org

--- Comment #28 from Marco Scardovi (scardracs@disroot.org) ---
@Mario I took a look into it and made a quick patch. I hope that it can help
mitigate the problem.

From 379f0641e4bd7b287f398e1798530b1b09c5ad0f Mon Sep 17 00:00:00 2001
From: Marco Scardovi <scardracs@disroot.org>
Date: Sat, 30 May 2026 16:30:50 +0200
Subject: [PATCH 1/2] cpufreq/amd-pstate: Allow EPP=3D0 under performance po=
licy

Under the cpufreq "performance" policy, the amd-pstate driver currently
rejects all EPP writes with -EBUSY. However, writing the EPP value of
AMD_CPPC_EPP_PERFORMANCE (0) is semantically consistent with the
performance policy as EPP=3D0 corresponds to the most performance-oriented
setting. Allowing EPP=3D0 writes under the performance policy prevents
userspace power management utilities like power-profiles-daemon from
receiving -EBUSY and failing when switching profiles.

Only reject non-zero EPP values when the policy is set to performance.

Fixes: 2064543f5ba0 ("cpufreq/amd-pstate: Rework CPPC enabling")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221505
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d55e2be825b..30b4953a93b3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1423,7 +1423,8 @@ ssize_t store_energy_performance_preference(struct
cpufreq_policy *policy,
                        epp =3D cpudata->epp_default_dc;
        }

-       if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
+       if (epp !=3D AMD_CPPC_EPP_PERFORMANCE &&
+           cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
                pr_debug("EPP cannot be set under performance policy\n");
                return -EBUSY;
        }
--=20
2.54.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

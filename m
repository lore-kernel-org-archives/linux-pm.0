Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DC477987
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521545; cv=none; b=o5XBy8+gCCnAP4dDxv2z1sbxrzuGOOMmk5B+7eiE5YGZiNGVJJDJG1gGh6oHvpQeVlDltDTemmGJ0wf3vDCvEO+NFqBg5d3y8k0HY+nqhJrZCY6C0evK80kVS4XLyj9cd70B2eGtO5QAhaWJUeN0UfMjt1HGqn+ctzAkNjsVCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521545; c=relaxed/simple;
	bh=CLGDI6As/KabMN67zDJNT0kBrAjoGem+6Cs/ndlCyQc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lHvhO8FbsyM8qSfPacV3O3uQTEQo6zdferoPHOn4sY3D3aQf30+mUBWeDnS6xB/8HeCKPQ7SISuMkPv7eYZp65Fc+yBgRPlG2KqTwifDxUrY67Y6oWAmH/ZbP8fV4bghfjMWqvTdHy99wxu8jjug6vJVE2vyN4VXXNinGUFvMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz+4ST6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz+4ST6D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E59FAC2BCF5
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521544;
	bh=CLGDI6As/KabMN67zDJNT0kBrAjoGem+6Cs/ndlCyQc=;
	h=From:To:Subject:Date:From;
	b=iz+4ST6DmY77gCxw6CVidUKvG2Pz6099D8yzhGDGZ5ls5sq+VYfrC//dyVkpA5njx
	 XCaev1LxGlg7xPMrcpB1wjav9FCJRCaJfnMaSAVuKKWMn6hb3X87HVXvR+55DVeLhF
	 11YAbWn5VRzDo8eTtyAj2Tj+Vyi6y+0VMoHbLKafdvcYyTPNgJSHY9af8HaG9B4P6S
	 04u/I9E6IcVvZXVf8bRJxOYGQWLmcrtSP5IOjZA5FuAWGCgJ/MwYsaKDvQbTYh24gY
	 n0pONiIha2A8XaShnL/9AdPgwjjUgq9by+FoRCrSA6Xzq/g5+WZj+CjwF+l9YbOhVU
	 f6RBGIgcyvZiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CC8D3C433E1; Mon, 11 May 2026 17:45:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221506] New: REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Mon, 11 May 2026 17:45:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221506-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221506

            Bug ID: 221506
           Summary: REGRESSION][amd_pstate] "EPP cannot be set under
                    performance policy" (EBUSY) when switching to
                    performance profile via PPD on 7.1
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: sergeyluashkov@gmail.com
        Regression: No

Hardware: ASUS TUF Gaming A14 (2026) FA401EA
CPU: AMD Ryzen AI Max+ 932 (Strix Halo platform)
Kernel: 7.1.0-mainline (including patches for Bugzilla #221310)
Power Daemon: power-profiles-daemon 0.30

Description:
On kernel 7.1, power-profiles-daemon fails to activate the "performance"
profile. The D-Bus error returned is Code 26 (Device or resource busy).

After enabling dynamic debug for the amd_pstate module (echo 'module amd_ps=
tate
+p' > /sys/kernel/debug/dynamic_debug/control), I captured the following re=
ason
for the failure in dmesg:

[  299.585428] amd_pstate: EPP cannot be set under performance policy

Steps to Reproduce:

Use a system with amd_pstate in active mode on kernel 7.1.

Attempt to switch profile: powerprofilesctl set performance.

Failed to communicate with power-profiles-daemon: g-io-error-quark:
GDBus.Error:org.gtk.GDBus.UnmappedGError.Quark._g_2dio_2derror_2dquark.Code=
26:
Failed to activate CPU driver 'amd_pstate': Error writing
'/sys/devices/system/cpu/cpufreq/policy11/energy_performance_preference':
Device or resource busy (26)


The command fails, and dmesg logs: amd_pstate: EPP cannot be set under
performance policy.

Expected Result:
The driver should allow setting the EPP value even if the policy is set to
performance, or handle the transition gracefully without returning EBUSY to
user-space daemons.

Additional Context:
This issue was observed on the new Strix Halo (Ryzen AI Max+) platform. The
conflict between PPD's profile orchestration and the driver's internal state
checks makes the "Performance" profile unusable via standard desktop tools
(KDE/GNOME power settings).

I can build and test custom patches on this hardware

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

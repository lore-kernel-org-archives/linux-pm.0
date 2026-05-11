Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA5466B59
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521506; cv=none; b=R/R9XmMgChwE0VKiRv9BtVVvm8wT2dTeODWqIQYT7hVEO2nrZzIkhJLoK1qkOVztHUyBj9D6ZruqFIMVa1PA+s5/0jGz1HfUeskFrYcW4RKTFnWjKA/FBNqccHAendh+bdN8inPc7u07wCGQBYGp5Bzkk4bjEy3prlCWcqiPKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521506; c=relaxed/simple;
	bh=j0xQmkUIfpgWG4NeqGarVjzRbqQTwLyRuCy9jr98dR0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FSTvKdFCuzR0o4yvj7BfvLwqqI44jVhNvJgtQC/H/DuTOtwq2eZt3gEvxy/r4LrHgVnRU8KYRSlNQRO8tB0BwxuzfYwG4gGRzQ8fYM04omKgNO0vpGy3shapcYbjXl42SbotADcUbrRaZ9umRHoiTMLoOR+To6ic9lufiDvtOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgjz+2G6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgjz+2G6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95F23C2BCB0
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521505;
	bh=j0xQmkUIfpgWG4NeqGarVjzRbqQTwLyRuCy9jr98dR0=;
	h=From:To:Subject:Date:From;
	b=Qgjz+2G6eUp43FpueeeSKkwx3MmyUEb86WE6/W89tNhYi6Dhx0yyRkC3lt2LcPPxO
	 U+Cs68KoijTXR4VrXpzK7AiU5lRee8O1BK4w/Qu9nkRYssl0qoDTuobHVbcpkyNwtK
	 eefU4lM/SdwypnQTnk63Li4C60g+8yGRphW00QqiwhPNxWUsJZsaGzZ8GmZoT/MDpW
	 rAUgr3XB1CS/Kdhpsn62rHR4zXeTMHsH9PdEdGSGOv9MMnxwS1GcX7zo2P2tDzB0ux
	 IrvTs2Zj4ahMmSMt4JZeAXrO9kFIS1yur90mqw0paKLudpPJTeHqssDwUnMuOQQ5uh
	 pQYR3GFzB3ftA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5C2C5C41612; Mon, 11 May 2026 17:45:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] New: REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Mon, 11 May 2026 17:45:03 +0000
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
 cf_regression attachments.created
Message-ID: <bug-221505-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 221505
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

Created attachment 310089
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310089&action=3Dedit
dmesg

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

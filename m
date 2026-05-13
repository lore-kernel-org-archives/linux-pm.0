Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD3357CF7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686778; cv=none; b=FdBprmrJPvcLykgEdUACSesEfw9wZWPIG2M412m5/2SoNVBbswC3yEg9Gt4asbN486/K0ui2xNmjC5hHl/oOCYusGEpi5reXPVOZIwXu4jMkH7rZ86kUDd6buemgNLXnF940XpYHmS0mfswPyvEf2cw1I2O0sE+a9FnEIZ05Ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686778; c=relaxed/simple;
	bh=zaWX9knVjHiJMbXOY44LHhUaqAoNwahlhauv6FJwaG8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWoxqC9lkaBZ7KnSFseWxa/JFCr3CD0Pc1K/mbLS28rPHAjvS74+Kf6N+2U25ZpB3hxutiX3xMSb/GU0Eds9ic7zJShh4xYvHeBZlA7nX/gZfvEB5XV0qM3EAEOiVL0Jy5HwAlA+6eX35N7QyS1gI/zPeolij1qfxsSJw+yO3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2wrJMNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2wrJMNg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E12DC2BCC6
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778686778;
	bh=zaWX9knVjHiJMbXOY44LHhUaqAoNwahlhauv6FJwaG8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P2wrJMNgX87wyzPlfMj7ucVBR0RKlpi+rWxfMx1MtRbhstEqiUGiLZmDHGxL5Qkiw
	 wyoBb48DG2LZ9ukmOcmuQ/ehcccV/zkltdkFc+OSdzlJV8b0/6Il2RRABgiK0/KxcL
	 a+Paz4Soc0TqTdQO7A1leuo3PsxV8OzeGyd2AtXgAtpHZ1I/vo6335F3/JV7DMTZiB
	 7fDBGCyleyTU0rKPZsGBjOcycT5voZ8oXagpI65OhVQI26H/m3fB4C3tpLH7a9b8eP
	 fh4TT8N5wuq4nThjJtRce3aMOczZocEi3vlxyErYFZEZmrrWPHFJAS2BNNkiYPhpk4
	 9mFI2XLjo44og==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3A1B1C41616; Wed, 13 May 2026 15:39:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 15:39:38 +0000
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
Message-ID: <bug-221505-137361-uToyyfwXGs@https.bugzilla.kernel.org/>
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

--- Comment #4 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #3)
> Did you set CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP

After enabling CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=3Dy, power-profiles-daemon=
 (PPD)
loses the ability to switch to the power-saver profile. Attempting to set it
via powerprofilesctl set power-saver results in the system defaulting back =
to
balanced.

Technical details:

Governor limitation:
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors ret=
urns
only [performance, powersave].

PPD Failure:
Since only two governors are visible, PPD fails to map the "power-saver"
profile correctly, even though the underlying hardware supports it.

Manual Override:
I discovered that the only way to successfully force the "power-saver" stat=
e is
by writing directly to the platform profile:
echo "quiet" | sudo tee
/sys/devices/platform/asus-nb-wmi/platform-profile/platform-profile-25/prof=
ile
(Note: The path may vary, but the "quiet" hint works where PPD fails).

Steps to Reproduce:

Enable CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=3Dy.

Try to set power-saver: powerprofilesctl set power-saver.

Check status: powerprofilesctl get returns balanced.

Expected Result:
PPD should recognize that in active/dynamic_epp mode, "power-saver" should =
map
to the powersave governor with an EPP hint of power (or quiet at the platfo=
rm
level)

Actual Result:
PPD is stuck between two profiles (balanced/performance)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

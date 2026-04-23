Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0535CB89
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956596; cv=none; b=WTINGCh1EP1o/cUr+XVOGjTZlX/N4aZb+htOjjbfk4lIm+iKTaC1CpAypsuDN5I/TQ7Cc/7qrfNv+G3yfTaY45DI4dpfNW5PtfdwwbYztgxRSAe0m7kxkiEWYLZxYYVoHHOz4QNuoqolCL8h9tfoEnecmAIIS2CZreNvUfEpG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956596; c=relaxed/simple;
	bh=NafMh+kY2RPhFM3AIWqR5oCZ/41KKG6I09A4nkJ4DmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sO0r0wn1kvE36IBNsTE+jLvUC0htAxdXa3r1l7lwki0WZ3cJvWSvKFyfOgLDgrojhK1Ufu6LEDGTFp6CQI8WGmwLkTn1czvbh6lJef9udwm9FiFWe4WoQna6tNDPX9k4GDSTT+vB5V/V5IAa+xD950t+ZoGMtpMuEwfeGKMYNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMZr9Eb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMZr9Eb2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEDEBC2BCB5
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956596;
	bh=NafMh+kY2RPhFM3AIWqR5oCZ/41KKG6I09A4nkJ4DmM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NMZr9Eb25ntBm67VKI5kttQPUHhgTG4eHyXHHh3f7JB8cdnxSEObccQrurmqNmdVi
	 djFdYX/yxjQq+3tacTWqaA60q/Sx9njLDxBYYqoRmfA8ccXBIOsLqSdPdmzWpP0CGo
	 zoVdKu1CK2NPrmev1BJ2T+CszJcbAD4PCdEqOrBFoAKCo6trjOxDwEutVX7PcNSoGr
	 mIsDUcS/NZPI1DQUpGn4VLO2GF1znh76RYi4HTWwv5Mwsn021BIKZHIbjf7/1frCQd
	 a+DeGICZepBjwbz2TkzHEli4oHf4BqEdDEE2cxBjbW0tz1xBtN3F3zZ1xqT0UJ6ily
	 xJ51yg5fcmkYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E88B0C433E1; Thu, 23 Apr 2026 15:03:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221403] ThinkPad E14 Gen 7 (Hawk Point) CPU throttles to
 ~544MHz on battery - amd-pmf PMF Smart PC not advertised in BIOS
Date: Thu, 23 Apr 2026 15:03:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: x86-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: platform_x86_64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component dependson assigned_to product
Message-ID: <bug-221403-137361-NWOccbo2ph@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221403-137361@https.bugzilla.kernel.org/>
References: <bug-221403-137361@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com
          Component|cpufreq                     |x86-64
         Depends on|                            |218305
           Assignee|linux-pm@vger.kernel.org    |platform_x86_64@kernel-bugs
                   |                            |.osdl.org
            Product|Power Management            |Platform Specific/Hardware

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This looks way too similar to
https://bugzilla.kernel.org/show_bug.cgi?id=3D218305

Perhaps it's the same issue.

Please unplug the power cord, then plug it back in and report whether it's
helped.


Referenced Bugs:

https://bugzilla.kernel.org/show_bug.cgi?id=3D218305
[Bug 218305] Ryzen 7 7840HS gets stuck at 544MHz frequency after resuming a=
fter
unplugging the power cord during sleep
--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

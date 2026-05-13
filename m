Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE33AEF47
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699697; cv=none; b=k9NI31rRuNp07TfxACtrAlxDbzEAMFW0j2jQO3kTeBJpR0PV3toxUW2WpHMPZ8mp6WevbCjIAVvdpnJAmHOPbm9mjc3kTsG8P3i2XyfKQsz6D6pzbqCfDgE60nLjp8VcVwfByYnLTM8Fb0rh4cKWH6fv5Dj8aV76VSeS5XmHwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699697; c=relaxed/simple;
	bh=W0aSFub7T4kt6Q2Y7UedezcxCuTYwKBXKH/o8hY1PqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9GhZTVafp8hgHcfxGSWiu8DhFpkkDRn+UuZOdkLSGmwZOV+eFBTS5W3m49tCvYTPp5Z4yK6bTff/nBe8bjKGQ4Pf7AXMm/UouSU4iQ/sLyzlP+MGuMMvWJbpx2j67yoORxq55Dm2Qw2AgMNYRPmuNzRb5c/ZTsqSV4wHq5OR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htwy80pG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htwy80pG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF13DC2BCB7
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699697;
	bh=W0aSFub7T4kt6Q2Y7UedezcxCuTYwKBXKH/o8hY1PqU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=htwy80pGO3M3WpGV+PJ09vbPtUtyV3bERJp5pkn/jNGV3UDutyapnxYWZQK9RocfD
	 MchlkloWY0pG6ltXJPEQGC0qnbdQDLqrJLZuIhH6UyzOb2qY9RWZtdxsr+2npLu/rq
	 cOgsAoDCJat+M1zbMRtyLGOiCk4DDxBefF1ojX1oU5M9AbXWnGO0yvcS9qiP/6+/LR
	 q2xnwzHijIDKD01gqrO0/3duFEStAKZy1lpwo0YC+alWxIpwszHDKqb8mK9uLKQegd
	 097ywtJLT6KIIwyicmP4iZ6hLLuzCtsnA2/fpR9B7iyjZUQzfcZ4QpSh9ognhJ+bRg
	 7wsKIF7ha69Vg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E2116C4160E; Wed, 13 May 2026 19:14:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Wed, 13 May 2026 19:14:56 +0000
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
Message-ID: <bug-221505-137361-FjtMtlkOmP@https.bugzilla.kernel.org/>
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

--- Comment #10 from Sergey (sergeyluashkov@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #9)
> > With amd_dynamic_epp=3Denable:
>=20
> I'm not sure why this is happening.  What platform profiles does this oth=
er
> driver support?
>=20
> > With amd_dynamic_epp=3Ddisable (or no parameter):
>=20
> So you're still seeing this?
>=20
> [  299.585428] amd_pstate: EPP cannot be set under performance policy
>=20
> Can I see the kernel log with dynamic debug for amd-pstate turned on?  And
> also the output from the amd-pstate triage tool in amd-debug-tools.

With amd_dynamic_epp=3Denable:
cat /sys/devices/platform/asus-nb-wmi/platform-profile/platform-profile-25/=
name=20
asus-wmi

cat
/sys/devices/platform/asus-nb-wmi/platform-profile/platform-profile-25/prof=
ile=20=20
balanced

cat
/sys/devices/platform/asus-nb-wmi/platform-profile/platform-profile-25/choi=
ces=20=20
quiet balanced performance

With amd_dynamic_epp=3Ddisable (or no parameter):

[  128.393895] amd_pstate: EPP cannot be set under performance policy


=F0=9F=90=A7 Arch Linux
=F0=9F=90=A7 Kernel:      7.1.0-rc2-1-mainline-gf9f16835d4dc-dirty
=E2=97=8B 'status':     active
=E2=97=8B 'prefcore':   enabled
=F0=9F=90=A7 ITMT:        Y
=F0=9F=92=BB CPU:         AMD RYZEN AI MAX+ 392 w/ Radeon 8060S
=F0=9F=94=8B Per-CPU sysfs files
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
|   CPU # |   CPU Min Freq |   CPU Nonlinear Freq |   CPU Max Freq |   Scal=
ing
Min Freq |   Scaling Max Freq | Energy Performance Preference   |   Prefcor=
e |=20
 Boost |
|---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------|
|       0 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        206=
 |=20=20
    0 |
|       1 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        216=
 |=20=20
    0 |
|       2 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        201=
 |=20=20
    0 |
|       3 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        216=
 |=20=20
    0 |
|       4 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        196=
 |=20=20
    0 |
|       5 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        211=
 |=20=20
    0 |
|       6 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        176=
 |=20=20
    0 |
|       7 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        166=
 |=20=20
    0 |
|       8 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        186=
 |=20=20
    0 |
|       9 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        181=
 |=20=20
    0 |
|      10 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        171=
 |=20=20
    0 |
|      11 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        191=
 |=20=20
    0 |
|      12 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        206=
 |=20=20
    0 |
|      13 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        216=
 |=20=20
    0 |
|      14 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        201=
 |=20=20
    0 |
|      15 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        216=
 |=20=20
    0 |
|      16 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        196=
 |=20=20
    0 |
|      17 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        211=
 |=20=20
    0 |
|      18 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        176=
 |=20=20
    0 |
|      19 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        166=
 |=20=20
    0 |
|      20 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        186=
 |=20=20
    0 |
|      21 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        181=
 |=20=20
    0 |
|      22 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        171=
 |=20=20
    0 |
|      23 |         609334 |              1980334 |        3199000 |=20=20=
=20=20=20=20=20=20=20=20=20
 609334 |            3199000 | power                           |        191=
 |=20=20
    0 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
=F0=9F=94=8B CPPC MSRs
+---------+----------+----------+--------------------+---------+-----------=
-+
|   CPU # |   Enable |   Status | Cap 1              | Cap 2   | Request   =
 |
|---------+----------+----------+--------------------+---------+-----------=
-|
|       0 |        1 |        0 | 0xce694114ce694114 | 0x0     | 0xff001569=
 |
|       1 |        1 |        0 | 0xd8694114d8694114 | 0x0     | 0xff001569=
 |
|       2 |        1 |        0 | 0xc9694114c9694114 | 0x0     | 0xff001569=
 |
|       3 |        1 |        0 | 0xd8694114d8694114 | 0x0     | 0xff001569=
 |
|       4 |        1 |        0 | 0xc4694114c4694114 | 0x0     | 0xff001569=
 |
|       5 |        1 |        0 | 0xd3694114d3694114 | 0x0     | 0xff001569=
 |
|       6 |        1 |        0 | 0xb0694114b0694114 | 0x0     | 0xff001569=
 |
|       7 |        1 |        0 | 0xa6694114a6694114 | 0x0     | 0xff001569=
 |
|       8 |        1 |        0 | 0xba694114ba694114 | 0x0     | 0xff001569=
 |
|       9 |        1 |        0 | 0xb5694114b5694114 | 0x0     | 0xff001569=
 |
|      10 |        1 |        0 | 0xab694114ab694114 | 0x0     | 0xff001569=
 |
|      11 |        1 |        0 | 0xbf694114bf694114 | 0x0     | 0xff001569=
 |
|      12 |        1 |        0 | 0xce694114         | 0x0     | 0xff001569=
 |
|      13 |        1 |        0 | 0xd8694114         | 0x0     | 0xff001569=
 |
|      14 |        1 |        0 | 0xc9694114         | 0x0     | 0xff001569=
 |
|      15 |        1 |        0 | 0xd8694114         | 0x0     | 0xff001569=
 |
|      16 |        1 |        0 | 0xc4694114         | 0x0     | 0xff001569=
 |
|      17 |        1 |        0 | 0xd3694114         | 0x0     | 0xff001569=
 |
|      18 |        1 |        0 | 0xb0694114         | 0x0     | 0xff001569=
 |
|      19 |        1 |        0 | 0xa6694114         | 0x0     | 0xff001569=
 |
|      20 |        1 |        0 | 0xba694114         | 0x0     | 0xff001569=
 |
|      21 |        1 |        0 | 0xb5694114         | 0x0     | 0xff001569=
 |
|      22 |        1 |        0 | 0xab694114         | 0x0     | 0xff001569=
 |
|      23 |        1 |        0 | 0xbf694114         | 0x0     | 0xff001569=
 |
+---------+----------+----------+--------------------+---------+-----------=
-+
=F0=9F=94=8B MSR_AMD_CPPC_CAP1 (decoded)
+---------+---------------+------------------+----------------+------------=
----+
|   CPU # |   Lowest Perf |   Nonlinear Perf |   Nominal Perf |   Highest P=
erf
|
|---------+---------------+------------------+----------------+------------=
----|
|       0 |            20 |               65 |            105 |            =
206
|
|       1 |            20 |               65 |            105 |            =
216
|
|       2 |            20 |               65 |            105 |            =
201
|
|       3 |            20 |               65 |            105 |            =
216
|
|       4 |            20 |               65 |            105 |            =
196
|
|       5 |            20 |               65 |            105 |            =
211
|
|       6 |            20 |               65 |            105 |            =
176
|
|       7 |            20 |               65 |            105 |            =
166
|
|       8 |            20 |               65 |            105 |            =
186
|
|       9 |            20 |               65 |            105 |            =
181
|
|      10 |            20 |               65 |            105 |            =
171
|
|      11 |            20 |               65 |            105 |            =
191
|
|      12 |            20 |               65 |            105 |            =
206
|
|      13 |            20 |               65 |            105 |            =
216
|
|      14 |            20 |               65 |            105 |            =
201
|
|      15 |            20 |               65 |            105 |            =
216
|
|      16 |            20 |               65 |            105 |            =
196
|
|      17 |            20 |               65 |            105 |            =
211
|
|      18 |            20 |               65 |            105 |            =
176
|
|      19 |            20 |               65 |            105 |            =
166
|
|      20 |            20 |               65 |            105 |            =
186
|
|      21 |            20 |               65 |            105 |            =
181
|
|      22 |            20 |               65 |            105 |            =
171
|
|      23 |            20 |               65 |            105 |            =
191
|
+---------+---------------+------------------+----------------+------------=
----+
=F0=9F=94=8B MSR_AMD_CPPC_REQ (decoded)
+---------+------------+------------+----------------+---------------------=
------+
|   CPU # |   Min Perf |   Max Perf |   Desired Perf |   Energy Performance
Perf |
|---------+------------+------------+----------------+---------------------=
------|
|       0 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       1 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       2 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       3 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       4 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       5 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       6 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       7 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       8 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|       9 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      10 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      11 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      12 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      13 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      14 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      15 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      16 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      17 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      18 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      19 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      20 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      21 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      22 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
|      23 |         21 |        105 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
255 |
+---------+------------+------------+----------------+---------------------=
------+

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

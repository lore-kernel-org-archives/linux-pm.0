Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A303C196F
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743828; cv=none; b=HH96sFOY+wl2IsS3nfMB5zDp3c4s+aXZxF1cXNQK1jbHEyUMBIWwdqpHt0Ifk4WUC80H5ejG9NMlTLL2DanXBnb+tnXWPI6MRvbPCVH8PdgeYC1p8wxfjOjIZuFf9QuT0jvqCGcP9c3Luy0oA/xit1pnTxBkaJpICH3eGIhdDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743828; c=relaxed/simple;
	bh=y+8H6g1YZibvHMhChxFmJVrrZEQrDRIDRibsNpFbUrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKXCX0NZQsvYeaFHXCP5YD/8QZPtuTlNAM21FVM/uhsAH9VnTQ/uvonPD8IjQb/UD6+E68xMvxsx8qN0O+YpuaNRtmwWy4iORum/BSYch6gCosgf31Gtt+f7cWVMctNDqd1GpX80AASPYQC4FQwreKWGoU22RHRJOUiIia6O0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buD8UGrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buD8UGrL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DA4BC2BCB7
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778743827;
	bh=y+8H6g1YZibvHMhChxFmJVrrZEQrDRIDRibsNpFbUrA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=buD8UGrL1JJHc//9p9TfvUQumOxLqu5xH8Q9JYukaGGL87N/DhLklvwD/abrs+7+/
	 b8DgXoldAi33CHju8NT9FvVZaNXo98uV8BCrGY3nhCT37vBRAENt99LX5NMani/0Qy
	 7XIe0+PRQ13txK+VvQEYxazB0jhVwGmiumZW9c0rO4+K5NK0JFlhQz/Xe4128tM9D3
	 dB8yEX9ABVccXzTMoQBSOVoAFkUUye1e30paJlBsdmbLBPO7LcirPSKYRmtQ68g0Ii
	 mK++woppU/iqo62ApFKAys2agVFdShPi5UFjpR1A9Xv9DXX02cddxPXZrVuqIaMCzd
	 ODeYAx6z1miOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 45D14C41616; Thu, 14 May 2026 07:30:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Thu, 14 May 2026 07:30:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rhys.r.edwards@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221505-137361-FpgUN2mveA@https.bugzilla.kernel.org/>
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

Rhys Edwards (rhys.r.edwards@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rhys.r.edwards@gmail.com

--- Comment #11 from Rhys Edwards (rhys.r.edwards@gmail.com) ---
Not sure if i'm adding much additional info here not already known but i al=
so
noticed this issue recently and believe it is also linked to the frequency
limiting problem in https://bugzilla.kernel.org/show_bug.cgi?id=3D221473 as=
 i
have/had both issues

I've had cachyos installed using rc kernel on a desktop computer and last w=
eek
or so noticed cpu temps/wattage/frequency was much lower than normal, frequ=
ency
was specifically capping out at exactly 3Ghz regardless of workload.

I don't recall changing any pstate profiles at any point since i installed a
few months ago so i assume it was on performance(?)

CPU: AMD Ryzen 7 5800x
Mobo: MSI x570 Tomahawk
Ram: 32GB DDR4 3600Mhz
GPU: AMD RX570 4GB

It seems mostly fixed when i switched back to balanced using powerprofilesc=
tl,
but now i also can't set back to performance getting the error mentioned he=
re:

Failed to communicate with power-profiles-daemon: g-io-error-quark:
GDBus.Error:org.gtk.GDBus.UnmappedGError.Quark._g_2dio_2derror_2dquark.Code=
26:
Failed to activate CPU driver 'amd_pstate': Error writing
'/sys/devices/system/cpu/cpufreq/policy11/energy_performance_preference':
Device or resource busy (26)


Here is my p-state triage if it's any use...

=F0=9F=90=A7 CachyOS
=F0=9F=90=A7 Kernel:      7.1.0-rc3-1-cachyos-rc
=E2=97=8B 'status':     active
=E2=97=8B 'prefcore':   enabled
=F0=9F=90=A7 ITMT:        Y
=F0=9F=92=BB CPU:         AMD Ryzen 7 5800X 8-Core Processor
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
|       0 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        176=
 |=20=20
    1 |
|       1 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        196=
 |=20=20
    1 |
|       2 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        186=
 |=20=20
    1 |
|       3 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        181=
 |=20=20
    1 |
|       4 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        171=
 |=20=20
    1 |
|       5 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        191=
 |=20=20
    1 |
|       6 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        166=
 |=20=20
    1 |
|       7 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        196=
 |=20=20
    1 |
|       8 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        176=
 |=20=20
    1 |
|       9 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        196=
 |=20=20
    1 |
|      10 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        186=
 |=20=20
    1 |
|      11 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        181=
 |=20=20
    1 |
|      12 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        171=
 |=20=20
    1 |
|      13 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        191=
 |=20=20
    1 |
|      14 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        166=
 |=20=20
    1 |
|      15 |         555531 |              1754308 |        4853585 |=20=20=
=20=20=20=20=20=20=20=20=20
1754308 |            4853585 | balance_performance             |        196=
 |=20=20
    1 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
=F0=9F=94=8B CPPC MSRs
+---------+----------+----------+---------+---------+-----------+
|   CPU # |   Enable |   Status | Cap 1   | Cap 2   | Request   |
|---------+----------+----------+---------+---------+-----------|
|       0 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       1 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       2 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       3 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       4 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       5 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       6 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       7 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       8 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|       9 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|      10 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|      11 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|      12 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|      13 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|      14 |        0 |        0 | 0x0     | 0x0     | 0x0       |
|      15 |        0 |        0 | 0x0     | 0x0     | 0x0       |
+---------+----------+----------+---------+---------+-----------+
=F0=9F=94=8B MSR_AMD_CPPC_CAP1 (decoded)
+---------+---------------+------------------+----------------+------------=
----+
|   CPU # |   Lowest Perf |   Nonlinear Perf |   Nominal Perf |   Highest P=
erf
|
|---------+---------------+------------------+----------------+------------=
----|
|       0 |             0 |                0 |              0 |            =
  0
|
|       1 |             0 |                0 |              0 |            =
  0
|
|       2 |             0 |                0 |              0 |            =
  0
|
|       3 |             0 |                0 |              0 |            =
  0
|
|       4 |             0 |                0 |              0 |            =
  0
|
|       5 |             0 |                0 |              0 |            =
  0
|
|       6 |             0 |                0 |              0 |            =
  0
|
|       7 |             0 |                0 |              0 |            =
  0
|
|       8 |             0 |                0 |              0 |            =
  0
|
|       9 |             0 |                0 |              0 |            =
  0
|
|      10 |             0 |                0 |              0 |            =
  0
|
|      11 |             0 |                0 |              0 |            =
  0
|
|      12 |             0 |                0 |              0 |            =
  0
|
|      13 |             0 |                0 |              0 |            =
  0
|
|      14 |             0 |                0 |              0 |            =
  0
|
|      15 |             0 |                0 |              0 |            =
  0
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
|       0 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       1 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       2 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       3 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       4 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       5 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       6 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       7 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       8 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|       9 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|      10 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|      11 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|      12 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|      13 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|      14 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
|      15 |          0 |          0 |              0 |=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
0 |
+---------+------------+------------+----------------+---------------------=
------+

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

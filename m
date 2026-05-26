Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18493C553C
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787243; cv=none; b=r28Z/9dgqKo4Vj+0T7iZZ8leHGOtbPzCWiIvxg44IhqLB1/LBEH948W1VnMJDi0zJSTVWlXFaKI31T7xUJ0C7aCfpXskGnsqtf7vg3uLUEcsDYNOitQvvibQGhS9r0loqLk+AtsxA0biufI1/D4maFTfxxSMF955ohZLk08LKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787243; c=relaxed/simple;
	bh=vyzgwuiDKczg5+v8KgUfZ48+HjbmnFEHSLWTtGERbE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AHmWMHgVdLMooTNH2Z5IrKr0L7EUg8WKUXlHxyYfmF6AfURIxVnolsTDgot9z9EhEAXEEgRSwSdx055rk4I9VDpyUK8yp5LAA1pQWPRGAs/jdh/Zywdyc+oYk/LfNSgxrwZkSAx0RoRrVk+Rb3lmo1TPhXuITyWtPW5lcQOkvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr1IfdYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr1IfdYz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71AD4C2BCB3
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779787242;
	bh=vyzgwuiDKczg5+v8KgUfZ48+HjbmnFEHSLWTtGERbE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tr1IfdYzKWRxaD9FfFlltoYpF1URRZ6aUq3kbTPMPMqTr3LcXencwoNT4nmdjO82G
	 fzMdl9UHWKBhxjmkqwgrC2jktxRFL7QYDVCaMp+5FijWnfR4PFYYx1G2gi3eMTPCvZ
	 WsDnYXWZNP1GO45LImVG8Wx3o4UHtwGwtCeRg5u9Oh+ChHa8HjOTOeYOq8B/Y55D/Z
	 2UCn6TAexDjkMVPc/HhodXmxJavlS4GsgAJk/XiOMLl3KA21ykm/47bPfjSs7g5SpY
	 jvSJuFE9gXSLKe9z35WKLmtGdU0mN9neg3U5oQgPWTiQ0wSZuxAqDpvovNgazSiz+x
	 h0daAc/nYgdTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 59C8CC3279F; Tue, 26 May 2026 09:20:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Tue, 26 May 2026 09:20:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexaandru@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-QpFZsSNn1I@https.bugzilla.kernel.org/>
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

--- Comment #13 from Alex Ungur (alexaandru@gmail.com) ---
I use 7.1-rc5 and I can switch just fine to balanced or power-saver but not=
 to
performance:

```
$ powerprofilesctl
  performance:
    CpuDriver:  amd_pstate
    PlatformDriver:     platform_profile
    Degraded:   no

* balanced:
    CpuDriver:  amd_pstate
    PlatformDriver:     platform_profile

  power-saver:
    CpuDriver:  amd_pstate
    PlatformDriver:     platform_profile
$ powerprofilesctl set power-saver # ok
$ powerprofilesctl set balanced    # ok
$ powerprofilesctl set performance # not ok
Failed to communicate with power-profiles-daemon: g-io-error-quark:
GDBus.Error:org.gtk.GDBus.UnmappedGError.Quark._g_2dio_2derror_2dquark.Code=
26:
Failed to activate CPU driver 'amd_pstate': Error writing
'/sys/devices/system/cpu/cpufreq/policy11/energy_performance_preference':
Resource busy (26)
```

It worked fine with rc4 though... I could switch to any profile, incl.
performance.

My machine is:
```
$ inxi -CM
Machine:
  Type: Laptop System: ASUSTeK product: ASUS Vivobook S 16 M5606WA_M5606WA
    v: 1.0 serial: <superuser required>
  Mobo: ASUSTeK model: M5606WA v: 1.0 serial: <superuser required>
    UEFI: American Megatrends LLC. v: M5606WA.316 date: 01/05/2026
CPU:
  Info: 12-core model: AMD Ryzen AI 9 HX 370 w/ Radeon 890M bits: 64
    type: MT MCP cache: L2: 12 MiB
  Speed (MHz): avg: 3585 min/max: 605/5158:3289 cores: 1: 3585 2: 3585
    3: 3585 4: 3585 5: 3585 6: 3585 7: 3585 8: 3585 9: 3585 10: 3585 11: 35=
85
    12: 3585 13: 3585 14: 3585 15: 3585 16: 3585 17: 3585 18: 3585 19: 3585
    20: 3585 21: 3585 22: 3585 23: 3585 24: 3585
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

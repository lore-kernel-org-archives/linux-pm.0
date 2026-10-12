Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327B48BD54
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808394; cv=none; b=oSKeC+eQEgzUvteaFl8vajgG5mBUaGoaFwQGGf6VO5ao+Lud3UEB7aET7hmIqAHPtjOnETCx8b2YU9VAdp7JGHjJxwB7gqndPCTy6RDlBNF49yVDRrd0O7L5K0QWG4YkLP+sESwyGykylB7JTLWxcMTGPX/YIk5Da9gEgtfPhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808394; c=relaxed/simple;
	bh=qkvhnXTXBqTb6UY1LULOy37KCSxsy+aVS6tvVkHVIcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1jOlgbZ0NvWqyDlmZwHWttotxrpKcJc6zm11hTLkJ1ahfxbqpmOBrhjrMQjwmiSt29RZGJGKcMRufIpuSOt7sv5R5zdmLbRPwSG1me4GHy+gAf39+u5Iisn6jYefGRCUBGa8VsFLJcVwxacxr4OEGlB+LFFaD7oP9+ixDC92+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDUoxWlT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDUoxWlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEA1F0089B
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791808393;
	bh=k1b7sYHXhJNOGhpTpzlQk9vvGZJIaKrjJneTA1GBxRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TDUoxWlTPe4bjzLiyxUoF6KxyUgF2cQc1OhpXsKRdWpAx+P5UHFoK1iYGXy0+p3Er
	 YkjG3hrel5xP/zcujbg0WvlRqk4wzp6czZEE+SbWYvrxtKDvgGTJH9Xxcn5WJ980QF
	 7KIRhk4X62Cd+O2CUIgBviT08SuJT+N3cO2Vs6zr8A4ukceIgon6j4WMcYMqakr8ra
	 /1XKNSGEnD8u8/RadiqATcR44iCcZl3GdLPXYw+8RyrtNbldAm0ojzUcftH3ljcoEM
	 p2TzeJLmvpvwhiLWR6uh5G4CosI63045FjmDmXOd0LKsnPL4ZUG0KuXT43c4VoJ1Lx
	 KsAWBS0jbxWCA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bced78b3dfso833780e87.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 05:33:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHAx16ACmXWjQxyDmGtt2EcEtnzwiJ+94QXOdtF46qcHC3+zYze9dMEbfNSF6xMtOPdVcN2CqWeQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmvdvVPLdj/A27lHYP3ZOotd4vUWhiIYvV3ETqQ6xGAMY0mThL
	wsk+26Stnri90VI4EYyNbvFcFYzH1AtT7JLie/HsmBAvyGnQ0YVAtQbHhJ22lpxnIdH1fzNbL0X
	FWWfLZ7E8fs1eqEzloUZ/XFn/YvYUmqc=
X-Received: by 2002:a05:6512:6204:b0:5bc:e47d:498c with SMTP id
 2adb3069b0e04-5bcf77a87d1mr549399e87.22.1791808391545; Mon, 12 Oct 2026
 05:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4bc0e16b-f8a8-49a9-aaab-c7161ffdba89@kernel.org>
In-Reply-To: <4bc0e16b-f8a8-49a9-aaab-c7161ffdba89@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 14:31:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5Um-NRcgax2ZRfN5NAj=W3ADSe-PiSiQ_sTda86_73g@mail.gmail.com>
X-Gm-Features: AclHuK8kPIKgbFM4LcrREF5BgNyT--SEnTvyRdvLC3am48F0okeFEy51SFGmcm0
Message-ID: <CAJZ5v0j5Um-NRcgax2ZRfN5NAj=W3ADSe-PiSiQ_sTda86_73g@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate 7.4 content (10/4/26)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 3:10=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> The following changes since commit c8663e0457e6e6c72006478f4b6da99060030e=
c1:
>
>    cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
> (2026-09-10 14:33:59 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.4-2026-10-14
>
> for you to fetch changes up to 6b64d65c83688db2e58fbd9de7c74090f15271b7:
>
>    cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6
> (2026-10-01 13:05:07 -0500)
>
> ----------------------------------------------------------------
> amd-pstate content for 7.4 (10/4/26)
>
> * Fixups for a few bugs identified by Sashiko
> * Initial support for maximum frequency capacity handling on Zen6 / clien=
t
> * Updated EPP tunings for Zen6 / client
>
> ----------------------------------------------------------------
> Mario Limonciello (7):
>        cpufreq/amd-pstate: Fix TOCTOU when changing driver mode via sysfs
>        ACPI: CPPC: Refactor boost ratio handling
>        cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
>        cpufreq/amd-pstate: Get Highest Freq for a CPU
>        cpufreq: amd-pstate: Restore previous mode when changing driver
> mode fails
>        cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode
> change
>        cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6
>
> Vishal Badole (1):
>        cpufreq: amd-pstate: Update Zen6 client EPP tuning values
>
> Wentao Guan (1):
>        cpufreq/amd-pstate: Skip auto_sel write when it already matches
> the mode
>
> Xueqin Luo (1):
>        cpufreq/amd-pstate: Restore previous EPP if profile_name
> allocation fails
>
>   arch/x86/kernel/acpi/cppc.c     | 166
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++-------------------------------------------=
----------
>   drivers/cpufreq/acpi-cpufreq.c  |  17 ++++++++---------
>   drivers/cpufreq/amd-pstate-ut.c |  54
> +++++++++++++++++++++++++++++++++++++---------------
>   drivers/cpufreq/amd-pstate.c    | 116
> +++++++++++++++++++++++++++++++++++++++++++++++++------------------------=
-------------------------------------
>   drivers/cpufreq/amd-pstate.h    |  44
> ++++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h        |  14 ++++++++++++--
>   6 files changed, 264 insertions(+), 147 deletions(-)

Pulled and added to linux-pm.git/linux-next, but please see my
resolution of the conflict with the acpi-cppc branch in

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?id=3D71fb903c3dfe94af1a8c6b5df7705747d6ff7f4e

and let me know if it is correct.

Thanks!

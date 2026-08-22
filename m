Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F11F30A9
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399242; cv=pass; b=EorEOvYEy/U1mLK7qR54le2F6LxZUo4yZmh2R1g8vKsBslDzIzu/jl04gcNg0d2tU87dgbWEfo17d18rCtQm9a+gTp91Gcgzirl0NgXSgkvegn63PuHeojB5MB6dcF8qUjtBuokTXi7TDze6hHQny5tSRLSaHQlQbrLgmouXX04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399242; c=relaxed/simple;
	bh=qHmpEdlmXXOXi6wvb0cIar8CvnEcA5vmGJgJLOF+v68=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PpU+K+Evu8N+nQz2dPpSvmKqlQeqiA7ZI80r8+UVDjwqiu+FWrDRVF/LRgOnsgwhf5ACdHcfvBphCbun/icXER+YJnnQo/xwuti3+xvuBLnivZGoNHBPH0aw4KnS3riLoIXpNk/x+JIl8lK+EOzljWuhuLAkgr2mBCceQPlC36U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAcb3jNk; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAcb3jNk"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso5195737a12.2
        for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 04:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787399239; cv=none;
        d=google.com; s=arc-20260327;
        b=oqPCH2a8xWDS0ShKEt6nSsduo06l/hkXxcmvIaKam0FhVKJwL6cujfQg4HjqRzwJ0x
         AHdrsQup6Xz7+Cw6wpd74o3KQz+V1Tz+iK7hkMle8kPqfFj8ZSR6Vqn6BMs3wtjzSQL2
         7LKma/l+Czco1cVT9Givu4nRm49tAd/kiICAiQzzb4XJ7kSN8nnwZMr7k4ccbJk2jAQE
         wcR1PV88rgwvIB68IbCai+V+WMlpYYDsM+KUMxyfcAaBL3FRgUDj6xJ/m7sEjPVfmNIk
         z1klClipxsFIc76RSeVuRFEQHMGkgIiDqlHqR54yL2en1sxqjmlWYmYxcfafRfpsWEGu
         EKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qHmpEdlmXXOXi6wvb0cIar8CvnEcA5vmGJgJLOF+v68=;
        fh=ceOXfP/wo4HhkBDp7lxdYJY4TKY+jJh35fEBMWIRoPI=;
        b=JiKiXsTeCDi6mLCPpSZSpjnClZRPSm/4hnSZTu7g5hGoGt0D6w6MwzP6zXZNL6pV3U
         LI/j0tIrZ0krRZan2mMbN7Wfk84/JWbEDLNiZF1Fy2wjm3qnb1EwNTWB8qYH3Yw8InP0
         e8kL8GsC4c7fT2J+CLXj8eavgqSvup792ryVsZf8BBMZgv4vwNKxxIirca7XktIVCltK
         vd/eRdraiUOuGLesZq50mC/7jsaJ3uzTxuvfeDRrtorAjUmjfkixkfjgZ+z2EXn5Fmpy
         dWw3+jtjYoW3aL3ftINL/D14WmEG7LtwK14lc8sdguWJ51HyqGsMMqRDZ+AntR0SqxAN
         yhkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787399239; x=1788004039; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHmpEdlmXXOXi6wvb0cIar8CvnEcA5vmGJgJLOF+v68=;
        b=FAcb3jNkHOQm1XRHulYZZLhp5lR8yDWpmqJZLDzWCL1QmBOH/htETckWDvlNp1XEkW
         EstVpW4iX8mgCKnjumpn5Id/tI+ZFdnHre1ajctR4g5pEGI0MMXsEjgDRZ/yhsN6hJNm
         uZNYmdAvVF7039gkhiA6GlzIM97l+xIf3PBl5O8R9VOxUmJ1zrxHadMLAg3jA5EhnCrb
         PbSM+4ygaf7eRYYpDcl2O9zG9flXVVtsADtIBIW4d1fb7I0UzkNBJvlHd5EcGQJ9A/xu
         7TGXa4tlXl7O44oVdTz4GNTymMxSeN1kyDVcEwMLmcGSX7sYHlkfzOf0IpVXI3SJ+kFp
         k8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787399239; x=1788004039;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qHmpEdlmXXOXi6wvb0cIar8CvnEcA5vmGJgJLOF+v68=;
        b=gUnpCD5iBvhJOGxR5SYVUL3RFLauGwVyQkv9Rb0ZOn+6bUi6CoQDl5c53Vn802lAlD
         qpl8f7gCPt9+K2SbtJ2FaL2c7K4v6ZISMv90xH2NPR/q+bpN3gAAehyJ3RmQ3k+oXLYc
         CtVpvTQ4pW5Gy3g69wGpu8niWE79OEV/SgWDXsDIuMYkx9UHxZyXii2ycqHQHRsMWx5e
         U8gYEM2cVE6XYn2h2Zw2wDngR14VGazTZKFn68t0Sbq3dqGc/Fkt/GXiAVCZixoSivrM
         IOplwVxUkumG/U/NXi8zMCQ18qQb/JohgYhSJWHlEN3nxgQxijRp8y6JxD1yuE6K7LSd
         6YFA==
X-Gm-Message-State: AFuF++kSCsCfcJ/mUjkoszCN9Wrn1SEITk52eF26taM07JAqPCfvAqb/
	2MmRBLNGiuL03ZIn8esPaSyp6cb+RpCkakR5q+kTNDlffP7BKtkYvKOKjjDruHmDTGabugSajPJ
	+iwk9dRLG1hxt37rmMWbvKSY286irjMZ2qKo+t3A=
X-Gm-Gg: AR+sD1390yrlsPbsZX3sMCNB5AYZZaJuMUKuUxmVCpVP3ViCtxRwsTEJGUrpZ0NT8dI
	+d8NGJnXNtNg12vAffn8Pp+qY4CYghqddvk5Xi1c5Z+wRoeIAhWE8QEm937p9Kp1QPzvAJt4Op8
	nSluqMX+SYW9TB86F5PXbSda1OCE9A78qDj69xnMaQNfCProccUpSUPvHhVPzQJoEBCE8abCvB2
	5ZagivRBrI39o1JAt5E0jmd94v7DdeJwLV36Pm/rT1FTVJWIpzyIMgoi5BR5OzOXzuJr6AvW1H2
	LGvR+WZSjQ8zvFze8kMlvRewb8sR3w+nOLcDuSdRq78wVQR3KZmG1g==
X-Received: by 2002:a05:6402:505b:b0:69c:811f:8f5 with SMTP id
 4fb4d7f45d1cf-6a42f1b9325mr14652573a12.6.1787399239230; Sat, 22 Aug 2026
 04:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Smith <smithd98@gmail.com>
Date: Sat, 22 Aug 2026 07:46:42 -0400
X-Gm-Features: AcwNN1XUm-HyeO-6u7VzOjlBmYYqLLkCkzvQ4_Vr3pQc-NoAb3JmO8BytsfOWy0
Message-ID: <CAJVKnz-nj2rk33U9pNMaxzKDOvqZNaQBE5otdCc8Znt8m97anw@mail.gmail.com>
Subject: amd-pstate: Cezanne data fabric sync flood on DC gated by CPPC max_perf
To: linux-pm@vger.kernel.org
Cc: ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	kprateek.nayak@amd.com, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a reproducible AMD data fabric sync flood (reset code 0x08000800) on
an HP ProBook 445 G8 (Ryzen 7 5800U, Cezanne, family 25 model 80 stepping 0)
that appears to be gated by the CPPC max_perf value in combination with EPP,
and not by any physical operating point. 13 confirmed hard resets.

Bugzilla, with full data and a 770 KB evidence attachment:
https://www.google.com/url?q=https://bugzilla.kernel.org/show_bug.cgi?id%3D221909&source=gmail&ust=1787484988593000&sa=E

x86/amd: Previous system reset reason [0x08000800]: an uncorrected error
caused a data fabric sync flood event

Summary of the controlling experiment. All rows are on battery, same pack,
same charge range, same workload (llama.cpp 128-token prefill, ~6.7GB model,
CPU only, held warm). Peaks are from amdgpu hwmon plus RAPL:

EPP / governor smax_freq max_perf fmax vddgfx tctl steps deaths
balance_performance / powersave 4508086 166 3617 1175mV 63.8C 12 4
balance_performance / powersave 4500000 165 - - - 1 1
balance_performance / powersave 4100000 ~151 4017 - 84.9C 8 0
balance_performance / powersave 3800000 140 3748 1275mV 71.5C 33 0
performance / performance 4508086 166 4374 1462mV 85.8C 8 0
balance_power / powersave (AC) 4508086 166 4117 1431mV 84.0C 8 0

Rows 1 and 5 are the interesting pair: identical scaling_max_freq, identical
power source, identical workload, differing only in EPP and governor. Row 5
runs 757 MHz faster, 287 mV higher and 22 C hotter than row 1 and survives
8/8, while row 1 dies about 14 seconds into a step.

So: pinning perf high is safe, clamping the range low is safe, and lethal is
the wide range with autonomous SMU ramping - balance_performance + powersave
across max_perf 166 on DC. This looks to me like autonomous perf-state
transition handling on DC rather than any operating point the part reaches.
Consistent with that, scaling_max_freq=3800000 prevents it even though the
workload never exceeds ~2.9 GHz uncapped; the cap narrows the range rather
than lowering the ceiling.

Never reproduced on AC. Reproduced on 7.1.8 and 6.18.44-lts, and on BIOS
01.21.00 and 01.22.00. amd-pstate-epp, status active, prefcore enabled.
Microcode 0xa500014, verified loaded.

Ruled out: memtest86+ 7.20 five passes clean; HP preboot diagnostics all
pass; thermal (dies at 63.8C, survives at 85.8C); NVMe HMB (AER is OS-owned
and clean, ASPM disabled by FADT); OOM. Also the battery pack, which is worn
(~430 mOhm, sags to 9.48V under load) and was my leading hypothesis until the
row-1-vs-row-5 control above rejected it - no battery model fails at
3617 MHz / 1175 mV and succeeds at 4374 MHz / 1462 mV on the same charge.

Note this is a single machine. I have not been able to confirm it on another
445 G8 or another 5800U, so I cannot rule out that it is specific to this
unit.

Questions:

1. Is there a known Cezanne erratum covering data fabric sync floods
triggered by autonomous CPPC perf-state transitions on DC?

2. Is the DC vs AC asymmetry expected - does the SMU run a materially
different perf-state transition policy on DC that could expose this?

3. Would a DMI-matched amd_pstate quirk clamping max_perf on DC be
acceptable upstream for affected platforms, or is this strictly an
AGESA/PMFW fix to route through the OEM? I am happy to write and test
the patch if you tell me the shape you would accept - I did not want to
send one cold given amd_pstate has no AC/DC awareness today.

4. Is there any way to get a fabric-side error record on a platform with no
APEI tables (no BERT/HEST/ERST here), to identify which agent flooded?

Current workaround, if useful to anyone hitting this: cap scaling_max_freq
to 3800000 on DC only. 33 ladder steps plus a 35 minute mixed-load soak at
load average 29-34 with zero resets, against 5 deaths in 13 uncapped steps.

Happy to run further tests on this machine - it reproduces in under a minute
and I have it instrumented at 5 ms resolution. I have the full boot ledger of
all 13 resets, per-crash triage, and the 5 ms RAPL/hwmon sample sets for every
row above; the bugzilla attachment has all of it.

Thanks,
Dave Smith

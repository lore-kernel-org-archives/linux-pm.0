Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DD3E44E7
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547085; cv=none; b=ZqiWYYxwHO6mGnpfR+QgNx7yGxotWezb4luXt8dho6O6gUQJv30cUVv+tVlLpVi2sJx4NaZbKnUtQa6R1a5lwOpHQLz2aTh7l70VcAw3h4bNtI9izjF5RaPiL8i0GRYBjSTchTSLpnhhbc2oZsjX4qzfongKgujUyQZgO7TvpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547085; c=relaxed/simple;
	bh=0xcUBAw7Xkn4hMHQX/IAjUsl8P1FFlogGYQCQvRaJXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJDyB6Rx23z17bCIxzRkT/kClgCM7goSyjtDq1582bvVaULRpzq+dZLRkGp8oMPNXKB+hptBTfs6UpgwInV86fG8xefmUhh4xSogVj8v1vynL7yCkRpnLMYKgDbHuf5dpAUTRgn6FDHp9gfc2CZrMOJV0I8Gtn5qI53Xyoh9cxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyc7Dppb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyc7Dppb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB621F00A3D
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 21:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547083;
	bh=wrOPGY5PAtJevz9co/cj3hDyc1hXQKRSR2bjLsOlxWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iyc7DppbM6t0rk5jVCljFrpt+ZSbPCFLIfkxPWNcgfWGTvxX8BFtvwbBujoSIMJrJ
	 gaR3gVc8hei9ICnx6/wd00LWWIVBZvIbBOT+38Dp2+qz8KG01EaZkw98PUM8w0l2Xc
	 w5Xs9rblgmenT5xwvBXyDQQP/abd52b6xcw3oGXp/woDhyeJGfP0UyeDcEks1rNMgG
	 mAquVs02fWxXWFREvOC3DREr2L/+fpmCRrW2aemOHQaZbZwDUXtkKyFpOLb86RLOnb
	 WPZpvUVBqTEucvIe1GRLvGPveKiOle6PKO2iXa3v5KcsykfD7bdkBy1cBZZTKJlsOe
	 xP28I3jaecilw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso1298871a12.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 14:44:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoMEzD5tEZozsH45oxH3MjNUM2m4kyJWpx93vG17c73VDFrj03Gl2/kk49dAt/lHxrqh/ejGoYSsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMWulhvbqunKUfQkNxvqDsWE3mGkNRZvsDsbtmjIbEBBcEVec
	HWb8r/Gs2mnn0378Psl4CSojfUWwoFfMbH/D7R/2FGL+TGpsUJ/yW70yHpwIRUzWdrPFuXpVAfV
	iAomrhq45Zaq2M5c7fQNt1aRPCjCkf8U=
X-Received: by 2002:a05:6402:274c:b0:697:c052:a990 with SMTP id
 4fb4d7f45d1cf-69ab4499259mr1800530a12.19.1783547082635; Wed, 08 Jul 2026
 14:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6O1QHT.QP6URTCEWLSV1@0iq.dev>
In-Reply-To: <6O1QHT.QP6URTCEWLSV1@0iq.dev>
From: Len Brown <lenb@kernel.org>
Date: Wed, 8 Jul 2026 17:44:31 -0400
X-Gmail-Original-Message-ID: <CAJvTdK=XuhxrZ+ULuXyV=cMsSS9caqDBACXUnj+R6UYesMXABA@mail.gmail.com>
X-Gm-Features: AVVi8Cfhs0jYYpu6REpyUXCZOT_SanzXQ0hFOhH1f9hFXuXRjhzD-4E-qMmUt4c
Message-ID: <CAJvTdK=XuhxrZ+ULuXyV=cMsSS9caqDBACXUnj+R6UYesMXABA@mail.gmail.com>
Subject: Re: Lunar Lake: silent fatal platform resets caused by idle-exit core hang
To: Polina Vishneva <poli@0iq.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"mpearson@lenovo.com" <mpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think the chances of this being related to the Linux kernel are very smal=
l.
(We've run Linux on this model and it has been fine.)

It would be interesting if booting with "idle=3Dhalt" makes the issue go aw=
ay.

My guess is that you've got a flakey DIMM.
Does it pass an overnight memory test?

Unfortunately, I believe the DIMMs on this one are soldered onto the
motherboard...

cc: Mark, who may have some insight....

cheers,
-Len

On Sun, Jul 5, 2026 at 5:43=E2=80=AFPM Polina Vishneva <poli@0iq.dev> wrote=
:
>
> Hello.
>
> So, I've got frustrated enough with my system cold-resetting every few
> days to try to debug the issue, with some success.
>
> TL;DR: cold reset on the cpuidle exit path.
>
> It's *probably* not actually a kernel bug, but I don't know any better
> place to submit it (hoping that the Intel folks will take a look).
>
> System:
> - Lenovo ThinkPad X1 Carbon Gen 13 (21NS001ACD), BIOS N4BET75W (1.45).
> - Intel Core Ultra 7 258V (Lunar Lake), microcode 0x126.
> - Kernel 7.1.1, intel_idle in ACPI _CST mode.
> - Reproduces even with intel_idle.max_cstate=3D2, so the enabled
>   states are only POLL, C1_ACPI and C2_ACPI.
>
> On boot after each crash, the kernel logs:
>
>   BERT: [Hardware Error]: Skipped 1 error records
>
> I pulled /sys/firmware/acpi/tables/data/BERT by hand and decoded it with
> https://github.com/intel/crashlog.
>
> The region contains a full PMC crashlog (MCA, Punit, UNCORE, PCORE,
> PMC, PMC_RST, PMC_TRACE records). iclg summarizes the failure as:
>
>   CORE_TIMEOUT.SINGLE_STUCK_TRANSACTION.C898FH
>   MCA.BANK3.INTERNAL_TIMER_ERROR.MSCOD_E184H
>   CRASHLOG_REASON.PMC.10H
>   CRASHLOG_REASON.PUNIT.20004H
>   RESET_CAUSE.FIRMWARE_GLOBAL_RESET.FW_GBLRST_SCRATCH16
>   RESET_CAUSE.GLOBAL_RESET.PMC_FW
>
> The important registers (one P-core has captured state):
>
>   mca.bank3.status =3D 0xbe000000e1840400
>       VAL|UC|EN|MISCV|ADDRV|PCC, MCACOD 0x0400 (internal timer /
>       retirement watchdog, "three-strike"), MSCOD 0xE184
>   mca.bank3.addr =3D mca.bank3.misc =3D arch_state.lip
>                  =3D 0xffffffff9471bb3c        (kernel text)
>   super queue: exactly one stuck transaction (cacheline 0xC898F)
>   pmc_rst: gblrst_cause_0.pmc_fw=3D1, fw_gblrst_cause_0.scratch16=3D1,
>       gblrst_req_0 =3D pmc_fw|syspwr_flr|pchpwr_flr
>
> The LIP: given that KASLR slide is 2MB-aligned, (lip mod 2M) is an
> invariant. Solving over System.map text symbols gives 14 candidates, of
> which only one can be related:
>
>   cpuidle_enter_state+0xbc
>
> Disassembly:
>
>   +0x73  call __x86_indirect_thunk_rax   ; target_state->enter()
>    ...   sched_clock_idle_wakeup_event / local_clock_noinstr /
>          sched_idle_set_state
>   +0xb6  call *pv_ops...irq_enable       ; patched to STI at boot
>   +0xbc  test %r14d,%r14d                ; <- LIP
>
> So (my best guess) the core had already returned from MWAIT, executed
> STI on the idle-exit path, and then stopped retiring instructions. The
> retirement watchdog then fires, Punit reports CORE_TIMEOUT, and PMC
> firmware pulls a global platform reset.
>
> The question is whether it is something known or rather something
> platform-specific that should be reported to Lenovo instead.
>
> I can provide the raw BERT dump, and also I'd be happy to debug/test if
> requested.
>
> Best regards,
> Polina.
>
>


--=20
Len Brown, Intel Open Source Technology Center

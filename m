Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116634;
	b=ZsX0ijSviuXCQpSMaqXFk+Fn9x3TKQMWbOKB/v5Rrb3HMUjmYihmY/eI22vPvmbu1QTt
	 5jZ8MzpVEJBEaJTDrmlgOCq1EA0Fvmq8iQ6h+MUV2xHJSEUTQlf0FMAxbrKlBoY2kXxBj
	 Y08G5fIVX0BR/559jaPF7BoHvvLpPpplbsdDFeYPj/E5QVYP1MB+fqXKPYpcbEQebCZUy
	 ZYHTy8xsSQSGXM+qwN3FAzXbLjeHjSYx/7oRyG/pbPQqfxdCZSO91tQ/H00sDvNYKfMGc
	 gVlO6ezuM5lF+Um4v5ltypYwsxBAM2Y7AED70+cTA9ZA6TGlzqTwmG0N6L7R71BUGCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116634;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mcKoKp7A5cxaM2egpk+d6t6yNfGFN2mdne0D5jZ05Ik=;
	b=j4JIMGFZ8HmPDCWEtjB+Z5gaMKd5A65VfiuA2WUeNlUjk/vmpdfj/0mOzFlo172wtotf
	 a7qh3Go8coeJFEBIg+2LwqO6KqeHac9ZKEs9JFZXWWZStja+/TcnUav/8hLYwzS7+epEy
	 TJAdLd5aEYK1YbcSQ/qzeuMD2wvtAM9O8x5EAushRHjspN67RSOveN9zGYxzKP7ZAixb6
	 UqYIddMjDvW+13sPfts7QoTLSEWmddWa7CFSuZhGJc6aaYzFXYoprlnJ/MmTuYqYCW83Q
	 by8L4BsYTuQQBsDEpUrwmzyB34CJfh3Gbcj4mpbQoHS9z59WvPLNJTgVY34mxV55aiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=my9FVlbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D5606A31E
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=my9FVlbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B23A1F031E2
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116633;
	bh=mcKoKp7A5cxaM2egpk+d6t6yNfGFN2mdne0D5jZ05Ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=my9FVlbOFdwX+wQjbjHFphosZKQFMkS4UVZM589l0DfU6yQxqhhYs/2bUj0ndt2jm
	 CWxrrcP+kAtnBSXOAB0IfZRKFMU+IohkxNbbqAK+gT/h5M42qvZjWzyexCGqC29vlY
	 DGWIdbKa9xYH65lkqJOIC9S7PXEDleHlUP7W4YkP+1CqmyTDrsHkagdPoIyRgtRfnS
	 PCXkpthmXy4Ook83+K2JkR23Ro9BRKn9V4sTgWHJyGm+nya5HKouiOZljecnnzRQEX
	 Teu7ne2ziYHXubjfG8YqQJG0Xa+YGw2H/hEpdzqBQoxdl5NfhYMnW4emQiO1mpbmSA
	 u94SnPvQNtEcw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bccecba199so94889e87.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 08:57:13 -0700 (PDT)
X-Gm-Message-State: AFq9FYJSMMoxCx0x2HVr/x2oN9bjSoIzRiHsk3KZULxR7pBQ8x8xe4zm
	qXQ5SNcHZSAoNdiwWn3jgwNUuyhTVy2eT7+07f8g14FC0DEdhjo2gINoUVwUvPT8sZmpxV6mPwj
	RCT0dtxIGtSZvfpoOdgekiOm4jwTqJlI=
X-Received: by 2002:a05:6512:6891:20b0:5bf:b7d1:dbac with SMTP id
 2adb3069b0e04-5bfb7d1dd18mr2303899e87.25.1793116631879; Tue, 27 Oct 2026
 08:57:11 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
In-Reply-To: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 16:56:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwv2xYp8dSEi2nkz303ZpF00NinyHyiOkCe50YbW2gfg@mail.gmail.com>
X-Gm-Features: AclHuK_Elp1PXV96vce-N4ZbilmgMmq6Iu8M5FDRTO3Yitc5xINYpYVJe3MyoVw
Message-ID: <CAJZ5v0jwv2xYp8dSEi2nkz303ZpF00NinyHyiOkCe50YbW2gfg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume
 without HWP
To: Zak <zakbrightonknight@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:39=E2=80=AFPM Zak <zakbrightonknight@gmail.com> w=
rote:
>
> From: Zak Brighton Knight <zakbrightonknight@gmail.com>
>
> On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
> the CPUs stop using turbo after every suspend to RAM when intel_pstate
> is in passive mode with the performance governor: they stay at the
> 2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
> policy limits change or the system is rebooted.
>
> During resume, the firmware sets each CPU's P-state request register,
> MSR_IA32_PERF_CTL, to the base ratio (28), and the kernel never writes
> the requested turbo ratio (38) again.  Without hardware-managed
> P-states (HWP), intel_pstate caches the last P-state it wrote and
> skips writes that would not change it.  In passive mode the cpufreq
> core also skips requests for the frequency it believes is already set
> (policy->cur), because intel_cpufreq sets CPUFREQ_NEED_UPDATE_LIMITS
> only with HWP.  Neither cached value is updated across suspend and
> resume, so as long as the governor keeps requesting the same P-state,
> as the performance governor always does, the register is never
> rewritten.  Governors that change the request often, such as
> schedutil, mostly hide the problem.
>
> Fix this by writing the cached P-state back to the register in
> intel_pstate_resume() when HWP is not used, as is already done for
> the HWP request when it is.
>
> The problem was found and root-caused, and this patch was drafted, with
> the help of an AI coding assistant (Claude, by Anthropic) during a
> performance review of the machine described above.
>
> Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> ---
> Tested on the T520 (i7-3840QM, no HWP, coreboot 24.08 with SeaBIOS)
> with v7.3 plus this patch and a temporary module parameter, not part
> of this patch, to turn the fix off.  intel_pstate.c is the same in
> v7.3 and in the base commit below.
>
> Each row is one suspend to RAM and resume (rtcwake -m mem -s 25).
> "Request" is the P-state read back from PERF_CTL on all eight CPUs
> 5 and 17 seconds after resume; "clock" is the measured speed of a
> single-threaded busy loop.  Before every suspend, all CPUs requested
> 38 and the clock was about 3.8 GHz.
>
>   mode     governor     fix  request after resume  clock
>   passive  performance  on   38 on all CPUs        3.8 GHz
>   passive  performance  off  28 on all CPUs        2.8 GHz
>   active   performance  off  38 on all CPUs        3.8 GHz
>   active   performance  on   38 on all CPUs        3.8 GHz
>
> The passive-mode failure was also reproduced twice on Fedora's 7.2.11
> kernel.  In active mode the request was back at 38 after resume even
> without the fix, so on this machine the fix only makes a difference in
> passive mode, the default without HWP.
>
> Not tested: systems with HWP (their code path is unchanged, only
> restructured), other machines and firmware, and suspend-to-idle.  The
> patch adds no warnings with W=3D1; sparse was not run.  The tests were
> scripted and run by the same AI assistant.
>
>  drivers/cpufreq/intel_pstate.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 17158cb..53db91a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1371,6 +1371,7 @@ static void set_power_ctl_ee_state(bool input)
>  }
>
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata);
> +static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate);
>
>  static void intel_pstate_hwp_reenable(struct cpudata *cpu)
>  {
> @@ -1404,11 +1405,20 @@ static int intel_pstate_resume(struct cpufreq_pol=
icy *policy)
>         else if (power_ctl_ee_state =3D=3D POWER_CTL_EE_DISABLE)
>                 set_power_ctl_ee_state(false);
>
> -       if (cpu->suspended && hwp_active) {
> +       if (cpu->suspended) {
>                 mutex_lock(&intel_pstate_limits_lock);
>
> -               /* Re-enable HWP, because "online" has not done that. */
> -               intel_pstate_hwp_reenable(cpu);
> +               if (hwp_active) {
> +                       /* Re-enable HWP, because "online" has not done t=
hat. */
> +                       intel_pstate_hwp_reenable(cpu);
> +               } else {
> +                       /*
> +                        * PERF_CTL may have been changed by the platform
> +                        * firmware, but it is only written when the requ=
ested
> +                        * P-state changes, so restore it explicitly.
> +                        */
> +                       intel_pstate_set_pstate(cpu, cpu->pstate.current_=
pstate);

According to Sashiko, this introduces a possible race condition with
concurrent P-state updates on cpu->cpu:

https://sashiko.dev/#/patchset/20261027143725.3763827-1-zakbrightonknight%4=
0gmail.com

It would take some more work to avoid this race AFAICS.

> +               }
>
>                 mutex_unlock(&intel_pstate_limits_lock);
>         }
>
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> --
> 2.56.0
>

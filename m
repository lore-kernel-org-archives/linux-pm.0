Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726013B58A
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218854; cv=none; b=I0SI/Gw5GfXz6/HsFp20KA8+NkuMAJwxKP0l5x2R76Y7r3+Q4TW6RRkUEjHeM7ivmcg31x7CvA+jglDUsSJ/f/0DlmM3pUrN4g/cTyiInvreLKbK3z0PHIfLOcFAkj2FcWexA83vb2bnHY0D8HTVeCCFh90WHoGiLSxdhSgm5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218854; c=relaxed/simple;
	bh=dg5f87rmTQM95hiGhWVW1sTVgi919jsXV2TkXwfrd5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7fsXctLkz4gOtVFHrWinPpLRnuKjd+1z1ZVb4NQv343hJqw9LkmGwjwaNUK7SC0dCdxXI8TwvKOOvsJToG4u0jiNC7adgcoQqw5zCU/klWwKtnLNEvkOrMhwVkvHr50zlj+7P9qosMdICAagjh7LU+6M6bcWbGct/oxt/nYEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO6mIJNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6mIJNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2001F00ACA
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218853;
	bh=yFLzyKPTxQe4fi84CuIV+oqv2Vbu7dQzIy/ANn2PRmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NO6mIJNoxmcAA0qWJadl8uAOu/wqK/LITZq7tOEWzRNGFign1wqHFpdWSK++pVvL0
	 dK7Nn33z+8/YtrBpNq/Lc8RikwYBocUW4qMBURRPRc8mLyE0h9HQWf3K3SLeuVldA7
	 r7Y8w5s2CajvcLFPTFEOoC3Ib+iZAuf+dTtejmbnwlQHxqDL2oYLkR4Q5csAqitMmG
	 di1tO2+W1yBHU+dELgUXc7ueJgDazIaQRFCtpNfUeOJLRe8Zp3tFi8VhbeUf46NNXx
	 Ga0U4Lvrme2/W2S3wVt1MGL5wC3ZjQcGZsV/C4GCG7PZeCPjvlnPJzhFV2AK3NGDjn
	 21apyJg66A0vg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so5996401e87.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 05:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+0t3rRRextxrLjJBHlimnrrN0q5WPObJbRh2n88kx8rX6upq5hN5d5+TSVVFMKMiL01vktg64lwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf54qV2dgq+iWH3Lv6FOXYXWgV10zkLEm/rOLAfc5dzRX962L
	jbRYhKQuivFcyAY6EITU+44vlu9o+wx5XxWWysOMkTa9affVa8cKrT5E3kQA2K75Prwsw26rIwM
	LNoz46wo1MBO8nmFBjjuiutj/m3xxWoU=
X-Received: by 2002:a05:6512:3356:b0:5ad:5774:d18e with SMTP id
 2adb3069b0e04-5ae350ff6b7mr755394e87.4.1782218851484; Tue, 23 Jun 2026
 05:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com> <20260618224527.1506419-4-jmattson@google.com>
In-Reply-To: <20260618224527.1506419-4-jmattson@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 14:47:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
X-Gm-Features: AVVi8CfgFOKi01c2PtEUe0pGuP0yzER50CYzd874S5ukAMDjHZ_PErUKCINj5_4
Message-ID: <CAJZ5v0jeJCN3Zu4uWoOYTYcu9o4BpkWLitNToGbPdwm8Tub=hg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in cpufreq_boost_down_prep()
To: Jim Mattson <jmattson@google.com>
Cc: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:45=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> During driver exit or CPU hotplug, acpi_cpufreq_cpu_exit() calls
> cpufreq_boost_down_prep() to re-enable boost on the target CPU.  However,
> cpufreq_boost_down_prep() ignores the target CPU parameter and calls
> boost_set_msr(1) locally. Since this runs in an unbound process context, =
it
> updates the local CPU's MSR while leaving the target CPU's boost state
> unchanged.
>
> On Intel platforms, the open-coded read-modify-write of
> MSR_IA32_MISC_ENABLE in boost_set_msr() is vulnerable to preemption and
> thread migration if executed in process context.
>
> Fix both issues by routing the MSR update through
> smp_call_function_single() to execute boost_set_msr() synchronously on th=
e
> target CPU. This ensures the correct CPU is updated and that the RMW
> sequence on Intel executes safely in IPI context with interrupts disabled=
.
>
> Fixes: a3605c46e0c0 ("cpufreq: acpi-cpufreq: drop rdmsr_on_cpus() usage")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260612215729.1532175-1-jmattson%=
40google.com
> Assisted-by: Gemini:gemini-3.5-pro
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 21639d9ac753..48d678812fd6 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -528,10 +528,11 @@ static void free_acpi_perf_data(void)
>  static int cpufreq_boost_down_prep(unsigned int cpu)
>  {
>         /*
> -        * Clear the boost-disable bit on the CPU_DOWN path so that
> -        * this cpu cannot block the remaining ones from boosting.
> +        * Clear the boost-disable bit on the target CPU so that
> +        * it cannot block the remaining ones from boosting.
>          */
> -       return boost_set_msr(1);
> +       return smp_call_function_single(cpu, boost_set_msr_each,
> +                                       (void *)1L, 1);

While I have not investigated the history of this code, I'm wondering
why cpufreq_boost_down_prep()  is a separate function and why it takes
the CPU number argument.

The only caller of it is acpi_cpufreq_cpu_exit() which could just do

set_boost(policy, 1);

instead of calling it (and might check if boost was supported at all
for that matter).

>  }
>
>  /*
> --

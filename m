Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA12C326F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792119; cv=none; b=IxPmKSVq5ynB0qCf/4Npti3VZ4pc45Dfqz0/ebMwiNECo4cBRaeFUnzVBxrns0JBLw1eLKUBvBJKOQZXp3IDdHdozkWrnTBG1/lE7imgEFNjGz2BrE2zO2zzTPSWxC9JrkqYYP/YvJj8+M7L160NZmXgMAML7hT2tn5jqMXTlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792119; c=relaxed/simple;
	bh=rDceOjGjgQl9+7q1SrA+Ynjab4e03oJJAY2a2S6h4wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWQ7oMnUxbFfL0jAGhGsXlOHOZ74CdTtV2VP5mTNGMmcAQWEaLDte7dnGndvPGwTOAtyn18xE/pnEMw/FLR/9TSBZhtdETOSVxRyBTGr8IxKeqgFuaaVl32YSgEdNwjyGiag5+isuINJcMz3NMWcXKXZvjljQqLjuzDexfbTKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyZQB1ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyZQB1ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189DF1F00A3D
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779792118;
	bh=zjjLxx+pZj8/NukuPwtvqV4863zJrcwWiE6Y2vyZlPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jyZQB1ru9BhA/B2uxtnt6tXAWncEjInMvmmI9qFLf8NFZADjWRKFoVwEmxRcr4u67
	 DLDDvtghmdhLKk5raqPk3bOzcOSBH19LCAqosW3LIq2qKrLb6h6aZcKqtnK6OhrJxQ
	 8TQd5CtBe9XTdfOumYr/2FYR8d/PmmOvxD25H2D169SpIN0blKmCrx1bKkyE204ia0
	 P+Hk6eFMC+reaDvkXCuosMfPWDtvAv9dp2vKYb1VkTSM50RGi9W04v9/JsG4vqz+K/
	 xQQw3qKUhwuE8QBOUWKma1MV4SS3dDFWaM4K4qkf3LZdka5K2ua3gli8gvHQ8skyd8
	 S7gx0SY9r4I5g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a87782588cso3643013e87.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 03:41:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iNqqmGbcpmzq7KwcfpPMs8u+G142d2rYriKgteWstqyct+U+tqU5iHtrdxaH/wwOSO9JtjAIkzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0G5SrGcEsPBT+PMnlhXgQBwrgLx7wq04OiRNopznNXOLpTd8
	AuMWKkopQJ6ohCW2K9oKO/bazHyC6wJX04f3T22uHbi/94ZInINaWtrLU+Py/+aikKQZZc1uo4M
	7BQSP6d3uPEG+xZh84lIqLXpFRm31RCs=
X-Received: by 2002:a05:6512:65:b0:5a4:17a6:9780 with SMTP id
 2adb3069b0e04-5aa3234c7c5mr3724604e87.14.1779792116375; Tue, 26 May 2026
 03:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523055503.7651-1-kprateek.nayak@amd.com>
In-Reply-To: <20260523055503.7651-1-kprateek.nayak@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 12:41:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZf3aBbu5c4m9vxeuJLKtiyi5sUba14yPcbJB7NCj-nQ@mail.gmail.com>
X-Gm-Features: AVHnY4JFcCTRa93n4XLLSrTpm53MJJjrS7jmjcUFVCvzv6bq6PHSWyBvXtProyc
Message-ID: <CAJZ5v0gZf3aBbu5c4m9vxeuJLKtiyi5sUba14yPcbJB7NCj-nQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate-ut: Disable dynamic_epp after the mode switch
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kalpana Shetty <kalpana.shetty@amd.com>, 
	Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 7:55=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Dan reported a possible NULL pointer dereference in amd-pstate-ut.c from
> static analysis and sure enough, running amd-pstate-ut in active mode
> with amd_dynamic_epp=3Denable results in a crash as a reult of the policy
> reference being set to NULL early, before disabling dynamic EPP.
>
> Kalpana also reported seeing amd-pstate-ut error out with -EBUSY for
> "amd_pstate_ut_epp" test when starting from the passive mode and
> amd_dynamic_epp=3Denable in the command line. The reason for the failure
> is that the command line enables dynamic_epp by default after the mode
> switch and the modifications to EPP values are blocked when running in
> dynamic EPP mode.
>
> Solution to both problems is to toggle off dynamic_epp *after* the mode
> switch when the driver grabs the policy reference again since the unit
> test is in full control of the policy after that point.
>
> The final restoration step will reset the dynamic_epp state via mode
> switch based on the initial conditions of the system.
>
> Reported-by: Kalpana Shetty <kalpana.shetty@amd.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/ahEq0CvdBX0T7_cO@stanley.mountai=
n/
> Fixes: f9f16835d4dc ("cpufreq/amd-pstate-ut: Drop policy reference before=
 driver switch")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Patches are based on:
>
>   git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fi=
xes
>
> Sorry for the oversight on f9f16835d4dc. I've tested the fix
> exhaustively this time around on a Zen4 system with all combinations of
> driver modes and amd_dynamic_epp state and the unit test runs
> successfully under all combinations without any errors.
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate=
-ut.c
> index 13a23dac477d..735b29f76438 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -302,12 +302,6 @@ static int amd_pstate_ut_epp(u32 index)
>         cpufreq_cpu_put(policy);
>         policy =3D NULL;
>
> -       /* disable dynamic EPP before running test */
> -       if (cpudata->dynamic_epp) {
> -               pr_debug("Dynamic EPP is enabled, disabling it\n");
> -               amd_pstate_clear_dynamic_epp(policy);
> -       }
> -
>         buf =3D (char *)__get_free_page(GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
> @@ -327,6 +321,16 @@ static int amd_pstate_ut_epp(u32 index)
>         orig_policy =3D cpudata->policy;
>         cpudata->policy =3D CPUFREQ_POLICY_POWERSAVE;
>
> +       /*
> +        * Disable dynamic EPP before running test. If "orig_dynamic_epp"=
 is
> +        * true, the  driver will do a redundant switch at the end and th=
ere
> +        * is no need for enabling it again at the end of the test.
> +        */
> +       if (cpudata->dynamic_epp) {
> +               pr_debug("Dynamic EPP is enabled, disabling it\n");
> +               amd_pstate_clear_dynamic_epp(policy);
> +       }
> +
>         for (epp =3D 0; epp <=3D U8_MAX; epp++) {
>                 u8 val;
>
>

Applied as 7.1-rc material, thanks!

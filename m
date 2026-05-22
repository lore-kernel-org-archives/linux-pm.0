Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5546AF39
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468400; cv=none; b=o7/nn9V8DvZqITVtMvnWUuha9WywRWFw9GlAwydbaCaBmP94/Rraruqtp+gMi1Q+5el4hst8824AK+/SsJSYiDlxtUzbW2wBTYBVnEAjB1uugJvP9PleP8VyH5r2uZJ0AF55rb5yk7i9APrijFPqnm45hJgCdhn1SIuxcVxq6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468400; c=relaxed/simple;
	bh=HLMJgxUWYOOSTRsXAZt28lgkSIczeVfoBqHks/T+ntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr+RVJoLHiDvHVpHvWrbVx30IlbpZAeti6L8CtNnQRZ/qd8G/BA3u7rYpNz9ajZDZeUWhqsIcSeV/mOLBi7K2c1Gbt2tj9ve/XWLtnqSx85hknujjIiAfGwOqK7ZcwQOHwwZFBpvzp2FcbLx878U4rnMVXKNN4zG4iRxTJ3ZEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8XxvdHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8XxvdHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B174B1F0155C
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468399;
	bh=tF8ASdjE2HPczN9pR2VCdsZp7GUY9mxxrNN4R5d5/+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W8XxvdHLfTM7u7Z5YYSt+Se3WvyQq1W+qGJzUJD4UXq1Juy+YjinIXUsyAMRaPE3y
	 MtdpGoWg6QzXOVl60adOMvQYAmu9XIDwUdXowNkfvPLEnoWGYroq8KLdOnoWw67s3l
	 yQrbNhtgVR6e6UMJXYTaFNcR70Uy3EYvnjngn2miF0LPUbDGjOCinOGTansykDVaUy
	 cORyOwBVC7mIqEVcRCw6n4itBZomNngufp1mQLMmSw38qiSjLMZg7bVC7GtzSsa+Vb
	 3gwe/m88mHTz9QvfIF/ZY3PBv2FOGXk0b83mo4KUoWsghOOP1Bz3WKTHs6xAp1Eaq8
	 yQEszDKHkAxLA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so8117226e87.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:46:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8poogqvOF7R/wdtFgEdJqzaKR/hSZ36oVeFHFFBR/R9mnNd5xM6BwO4fDBNmVJqN04sUGi/1rnWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAoTM12Jz3WcJH9ukAZo/X2gLqlglJMqSAgxo5SUF3STPAne24
	Xw1n1lVuX9g8f3rHzC4f2WbCjDDuDpcA7eXNLQSVS4AWBykSUxvI6AQGfEjDwDecW1KIPUePO+R
	oTuR/nmI8/96OF2y3qS9PbKo4EZAaMos=
X-Received: by 2002:a05:6512:a91:b0:5a9:163a:9ebc with SMTP id
 2adb3069b0e04-5aa32328f6emr1516676e87.19.1779468398137; Fri, 22 May 2026
 09:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87f69971a9bf89fb4b51f128e8ae519cbaf5894e.1779406085.git.yohei.kojima@sony.com>
In-Reply-To: <87f69971a9bf89fb4b51f128e8ae519cbaf5894e.1779406085.git.yohei.kojima@sony.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 18:46:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h70i3+Undx7X2OmQAkXbwoS+T6SWUGf_BxtRhKL8=j2w@mail.gmail.com>
X-Gm-Features: AVHnY4Lgf7wnXcuaph0IEmkzXuvQNPL3d0lpNpiuRSrxoHmrXm8gYgCkfRFf0dw
Message-ID: <CAJZ5v0h70i3+Undx7X2OmQAkXbwoS+T6SWUGf_BxtRhKL8=j2w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Improve warning message on
 HWP-disabled hybrid CPUs
To: Yohei Kojima <yohei.kojima@sony.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Daniel Palmer <daniel.palmer@sony.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:14=E2=80=AFAM Yohei Kojima <yohei.kojima@sony.com=
> wrote:
>
> Improve warning message on HWP-disabled hybrid processors to state that
> intel_pstate requires HWP to be enabled on such processors [1].
> Previously it warned that "intel_pstate: CPU model not supported", but
> it was misleading.
>
> [1]: https://docs.kernel.org/admin-guide/pm/intel_pstate.html
>
> Signed-off-by: Yohei Kojima <yohei.kojima@sony.com>
> ---
> I tested this patch on my PC equipped with i7-14700. Please note that
> you need hybrid processors (i.e. Alder Lake and later) to test this.
>
> After this patch, you will see the improved warning message if you
> disable hardware P-state in your BIOS,
>
> $ sudo dmesg -k | grep intel_pstate
> [    0.478616] intel_pstate: HWP-disabled hybrid CPU is not supported
>
> whereas this driver works as before if HWP is enabled.
>
> $ sudo dmesg -k | grep intel_pstate
> [    0.471387] intel_pstate: HWP enabled by BIOS
> [    0.471388] intel_pstate: Intel P-state driver initializing
> [    0.472593] intel_pstate: HWP enabled
> ---
>  drivers/cpufreq/intel_pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 11c58af41900..99cac95537b5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3823,6 +3823,12 @@ static int __init intel_pstate_init(void)
>                 if (no_load)
>                         return -ENODEV;
>
> +               id =3D x86_match_cpu(intel_hybrid_scaling_factor);
> +               if (id) {
> +                       pr_info("HWP-disabled hybrid CPU is not supported=
\n");
> +                       return -ENODEV;
> +               }
> +
>                 id =3D x86_match_cpu(intel_pstate_cpu_ids);
>                 if (!id) {
>                         pr_info("CPU model not supported\n");
> --

Applied as 7.2 material, thanks!

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4117A2EA
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762026; cv=none; b=Oki1lNGdV1KoBJldxuCQ9uKkjJAkgBxX8jWnRyAHbxRYvLt83wtVKP+ALEAD5I3Yu65xCJ2Rp7QY73JK2ZFlDK5Nd8HmR+8laTqNp+FVTGRxleTwtLVXxaVyjMxeClUIqpgqHxJz8OPVDZgW+kaH1hm8cotxOjLAwROJ0GZqBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762026; c=relaxed/simple;
	bh=/Vhnn2LNMkjX60aTUB2EW1JgGCm9DK9wvlsz5XsXhpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyS4yNhg+CqL7mmYM2HxFlrpV+lwrGUsTdCbYITV562kDBdwM0OaZT11Phi002bkRJGfSjTxRDidZ1kwaUcsFeY9ygpzkemKi+FOZO0UmzTV2pUk08Up/F2VJ7ueTs/V7TpbM5JP3/K4meSR4XLyL8LsUb8YaS/dBBMovvsxwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZnRpT3Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZnRpT3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11122C4CEF7
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775762026;
	bh=/Vhnn2LNMkjX60aTUB2EW1JgGCm9DK9wvlsz5XsXhpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rZnRpT3Z4TG2Cur6A1OBSm2j3WCSFdsIvRpRc5OulaI3sXlcm3wJsb0aRxyssQjWW
	 sXGkHgaOD/Us+JvpCj0VllVTnNdX5DhaOEeqDVi3gt/nLeG0VndqRjE3ptvlrVz2gy
	 QO3ukrRpOdifmokBuOTpPDO0egEHEy0lzEIkIqD/CuSrYdF2rpTHx/BJAVspXowwzP
	 aJeiYHNbeBLMd1Nu1540dmNjtCW+3nZH/9NuRcb9ycKlhaB+Ayvr/7FZIsz2uJd+KW
	 FpYopHEyLY+us2EKcGbeC2k/0WUMV9Rz/s0WZ+V0xt1DV2Fi0psyKzw1SYwY8Pq5Fp
	 TMGMS2FgVJz7w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b936331786dso154926366b.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 12:13:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YyzFKXd1dxxFr2kOWP/J+RoDUR8KRDk66GHRu/Uw18VE+xfDfJ+
	PHmZXXeKu1CeyX7qyk2zMZQ4cGu7ks/FfqmZ7Cvwm2W63FP4oAsz9GGGVSEfGPJzqovdYmJUFpr
	Ov0m6857LnqN9Z7BZDOw6vSYZBTkDC8Y=
X-Received: by 2002:a17:907:d109:b0:b98:8365:be with SMTP id
 a640c23a62f3a-b9d7279aa4amr21788666b.25.1775762024912; Thu, 09 Apr 2026
 12:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319140307.441950-1-darcari@redhat.com>
In-Reply-To: <20260319140307.441950-1-darcari@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 9 Apr 2026 15:13:32 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
X-Gm-Features: AQROBzCs2n_OW23-sBgLymPSvkaIpxoDNoGNQsSJcR7rzvWRde_rYj_g9B2eCe0
Message-ID: <CAJvTdKmLA=n07hkkXLbwMex-_Byji9EOy7wkkFHrcPCj8tzMqw@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Allow execution to continue after
 perf_l2_init() failure
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm, the check of perf_model_support covers unknown CPUs.
(and this code runs fine on my Alderlake)

So the failure you see must be from the kernel perf support failing?
What is the kernel config?

thanks,
-Len

On Thu, Mar 19, 2026 at 10:04=E2=80=AFAM David Arcari <darcari@redhat.com> =
wrote:
>
> Currently, if perf_l2_init() fails turbostat exits after issuing the
> following error (which was encountered on AlderLake):
>
> turbostat: perf_l2_init(cpu0, 0x0, 0xff24) REFS: Invalid argument
>
> This occurs because perf_l2_init() calls err(). However, the code has bee=
n
> written in such a manner that it is able to perform cleanup and continue.
> Therefore, this issue can be addressed by changing the appropriate calls
> to err() to warnx().
>
> Additionally, correct the PMU type arguments passed to the warning string=
s
> in the ecore and lcore blocks so the logs accurately reflect the failing
> counter type.
>
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 1a2671c28209..f1b8059a4eec 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -9403,13 +9403,13 @@ void perf_l2_init(void)
>                 if (!is_hybrid) {
>                         fd_l2_percpu[cpu] =3D open_perf_counter(cpu, perf=
_pmu_types.uniform, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
>                         if (fd_l2_percpu[cpu] =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", _=
_func__, cpu, perf_pmu_types.uniform, perf_model_support->first.refs);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __f=
unc__, cpu, perf_pmu_types.uniform, perf_model_support->first.refs);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
>                         retval =3D open_perf_counter(cpu, perf_pmu_types.=
uniform, perf_model_support->first.hits, fd_l2_percpu[cpu], PERF_FORMAT_GRO=
UP);
>                         if (retval =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", _=
_func__, cpu, perf_pmu_types.uniform, perf_model_support->first.hits);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __f=
unc__, cpu, perf_pmu_types.uniform, perf_model_support->first.hits);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
> @@ -9418,39 +9418,39 @@ void perf_l2_init(void)
>                 if (perf_pcore_set && CPU_ISSET_S(cpu, cpu_possible_setsi=
ze, perf_pcore_set)) {
>                         fd_l2_percpu[cpu] =3D open_perf_counter(cpu, perf=
_pmu_types.pcore, perf_model_support->first.refs, -1, PERF_FORMAT_GROUP);
>                         if (fd_l2_percpu[cpu] =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", _=
_func__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __f=
unc__, cpu, perf_pmu_types.pcore, perf_model_support->first.refs);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
>                         retval =3D open_perf_counter(cpu, perf_pmu_types.=
pcore, perf_model_support->first.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP=
);
>                         if (retval =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", _=
_func__, cpu, perf_pmu_types.pcore, perf_model_support->first.hits);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __f=
unc__, cpu, perf_pmu_types.pcore, perf_model_support->first.hits);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
>                 } else if (perf_ecore_set && CPU_ISSET_S(cpu, cpu_possibl=
e_setsize, perf_ecore_set)) {
>                         fd_l2_percpu[cpu] =3D open_perf_counter(cpu, perf=
_pmu_types.ecore, perf_model_support->second.refs, -1, PERF_FORMAT_GROUP);
>                         if (fd_l2_percpu[cpu] =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", _=
_func__, cpu, perf_pmu_types.pcore, perf_model_support->second.refs);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __f=
unc__, cpu, perf_pmu_types.ecore, perf_model_support->second.refs);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
>                         retval =3D open_perf_counter(cpu, perf_pmu_types.=
ecore, perf_model_support->second.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROU=
P);
>                         if (retval =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", _=
_func__, cpu, perf_pmu_types.pcore, perf_model_support->second.hits);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __f=
unc__, cpu, perf_pmu_types.ecore, perf_model_support->second.hits);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
>                 } else if (perf_lcore_set && CPU_ISSET_S(cpu, cpu_possibl=
e_setsize, perf_lcore_set)) {
>                         fd_l2_percpu[cpu] =3D open_perf_counter(cpu, perf=
_pmu_types.lcore, perf_model_support->third.refs, -1, PERF_FORMAT_GROUP);
>                         if (fd_l2_percpu[cpu] =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) REFS", _=
_func__, cpu, perf_pmu_types.pcore, perf_model_support->third.refs);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) REFS", __f=
unc__, cpu, perf_pmu_types.lcore, perf_model_support->third.refs);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
>                         retval =3D open_perf_counter(cpu, perf_pmu_types.=
lcore, perf_model_support->third.hits, fd_l2_percpu[cpu], PERF_FORMAT_GROUP=
);
>                         if (retval =3D=3D -1) {
> -                               err(-1, "%s(cpu%d, 0x%x, 0x%llx) HITS", _=
_func__, cpu, perf_pmu_types.pcore, perf_model_support->third.hits);
> +                               warnx("%s(cpu%d, 0x%x, 0x%llx) HITS", __f=
unc__, cpu, perf_pmu_types.lcore, perf_model_support->third.hits);
>                                 free_fd_l2_percpu();
>                                 return;
>                         }
> --
> 2.53.0
>
>


--=20
Len Brown, Intel Open Source Technology Center

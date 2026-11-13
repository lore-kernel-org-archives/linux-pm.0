Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582090;
	b=s3ZjifG3VPIyAe/s6y8EI/KsNAMyEcDpPJgoicdxH5MCFjjAUzFpes/5av49iPX8ydBR
	 Vha6HQcFHDRCf+P0JpxF9nvwJ34BTjge/+stAcrpCT65z3zziZCbg1ZPLCrseaFHS87Uy
	 thpG75x/HqMLDgh9cYXcai1B+5OoJKSNhpQqYn1rFDblIG7MnfVFvmXs02cEGhW9mHEnw
	 Hbj+P4jyHwiedN3WOwj8rsRj9ckRHXpJi8antRmXsYoJzpqZ7rv9eHG0L9upZf0Hcdy8q
	 YJv1JyN+RhLLh79r7y6DUoHgznVDAA1T8Sg92CeIyvBp59zPfmEhBSoFZmdIZF0JT9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582090;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=24YgV+N6N4CZNr324VuvF4oU2y/lazB/2kWMPXelW2Q=;
	b=DT/95pOs7K69Xrhu9UFvGaDR3bFKEbxz8OnLOFY9REa0ZZhHMeEVRI8smB0LPjFv/aMD
	 d1e54jMdqFNi5eD7fA02BhLdPmnjH5doCAnq7L5XpLv1WvZH6a7K7Vfqd1ScjBd2Ru8Cy
	 +89+3lnz9xyqYeagkzbowZ+2/0UXDnswHfG3NFAp2bVtjNKZe1Eipp6KaHjhnwj9u5BAF
	 qhDAk0HUg9lLFDYdnj7Oe2C5PVkxd26Ho6XlVHYDyVXeXeW6r5hy7doxFB9HaVts6lF1/
	 HZYmdu6LB1irDm5D4K7ksEQNkGPyD+kKNgZ0zr7NFhQcWuRd4IKZYjn7sqTE6OTZE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaKTktsK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975F606A327
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaKTktsK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8607D1F000C5
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582090;
	bh=24YgV+N6N4CZNr324VuvF4oU2y/lazB/2kWMPXelW2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CaKTktsKDIYG3rLCqCQDFRyAuIUri77XrUNaP2HH23Jc5FLM7W+kOgEHkfHC/1TDK
	 aNgOZNYmRmBFOax/M+BC6Fk6BVM0446Pmyp0yAMpueQoXLU5+qMEmXfDmfAikg1Utj
	 Ztk0OUqHEqnU0qrxyusjQZnpCMGcxPg+3HipFiy8EDiCStCxneyNoszZwj9VFpn/4f
	 Di+3QCoHzLAZWIcEN2V7y+wN8UJQIZSQIAGICntdo0OF3zcSABp7ratVRJU+fTUoxU
	 medH+vdqKyEBhnIHetj6ZLCI2N1q005QJ5pjMcP+E+/ByVgJiZJm4B/eRnDS0jqUmu
	 vN/K8CXRNXH7Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c14f3dab09so1162419e87.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:01:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEuPqMVGwD3JDleHS7/USpz1RPt88QttQvrx7qEQ0kr/J5z6mptaQPgg7LSWDe9+Reqei87BL2K2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+b5ys4LJ+zqXLRNJi44cz7BdPtGBl58ui7PrsdPAeqnQfLLNE
	10EgvsdONCEbCrFrcbZ+xZFLgcCOrD8fd+jgIAvftqevzLw53CNilB6ZlGqFb5CNUvtgas0dvgV
	aNhXdh45Z74T9HpO7WXWU8FG1GmOYChE=
X-Received: by 2002:a05:6512:2342:b0:5bf:e241:cd5e with SMTP id
 2adb3069b0e04-5c170a09794mr1054996e87.40.1794582088937; Fri, 13 Nov 2026
 07:01:28 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112113204.778904-1-christian.loehle@arm.com>
In-Reply-To: <20261112113204.778904-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 16:01:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jRPvciWEncW3qUdrDf_9MZe8DJgpSKQjAsx-NAbA0cfg@mail.gmail.com>
X-Gm-Features: AclHuK_dZzYH_eFFWMIW5ulIEF-1NQ6hQxCpWaYLAxoPUq9elLynNjGvi7k6XLI
Message-ID: <CAJZ5v0jRPvciWEncW3qUdrDf_9MZe8DJgpSKQjAsx-NAbA0cfg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Program policy limits during initialization
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumitg@nvidia.com, zhanjie9@hisilicon.com, 
	zhangpengjie2@huawei.com, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:32=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> cppc_cpufreq_cpu_init() keeps valid firmware MIN/MAX limits and relies on
> the governor to update them. If its first target equals policy->cur, the
> core can skip the driver callback, allowing autonomous selection below
> scaling_min_freq.
>
> Program MIN from Lowest Nonlinear and MAX from Nominal or Highest accordi=
ng
> to the boost state before starting the governor. Set Desired to MAX and
> publish policy->cur only after the write succeeds. Leave policy->max unse=
t
> so the initial maximum QoS request does not restrict later boost use.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg@nvid=
ia.com
> Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target c=
allbacks")
> Link: https://lore.kernel.org/all/CAJZ5v0jQVRQhJzLoAy3btKovHGYkqGKJAP_5Vf=
ENM_WAREQnyQ@mail.gmail.com/
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index a62589c0674f..92a5bb28571c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1018,29 +1018,20 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_p=
olicy *policy)
>                 policy->boost_supported =3D true;
>
>         /*
> -        * The request starts from the live limits, which may be unusable=
.
> -        * Firmware may leave them zeroed. An interrupted earlier update =
may
> -        * have left MIN above MAX. cppc_set_perf() would reject either, =
so
> -        * request the full range instead.
> -        */
> -       if (!cpu_data->perf_ctrls.max_perf ||
> -           cpu_data->perf_ctrls.min_perf > cpu_data->perf_ctrls.max_perf=
) {
> -               cpu_data->perf_ctrls.min_perf =3D caps->lowest_perf;
> -               cpu_data->perf_ctrls.min_perf_valid =3D true;
> -               cpu_data->perf_ctrls.max_perf =3D caps->highest_perf;
> -       }
> -
> -       /*
> -        * Keep the initial request within controls left by an earlier dr=
iver
> -        * instance or firmware. The governor will update the full tuple =
later.
> +        * Program the initial policy bounds before starting the governor=
. Its
> +        * first target request may be skipped if it already matches poli=
cy->cur.
> +        * cppc_set_perf() orders the writes against the live firmware li=
mits.
> +        *
> +        * New policies start with boost disabled, so this matches the in=
itial
> +        * cpuinfo.max_freq. The core applies global boost after governor=
 startup
> +        * and handles any resulting limit change through QoS.
>          */
> -       desired_perf =3D caps->highest_perf;
> -       if (cpu_data->perf_ctrls.max_perf)
> -               desired_perf =3D min(desired_perf, cpu_data->perf_ctrls.m=
ax_perf);
> -       if (cpu_data->perf_ctrls.min_perf_valid)
> -               desired_perf =3D max(desired_perf, cpu_data->perf_ctrls.m=
in_perf);
> +       cpu_data->perf_ctrls.min_perf =3D caps->lowest_nonlinear_perf;
> +       cpu_data->perf_ctrls.min_perf_valid =3D true;
> +       cpu_data->perf_ctrls.max_perf =3D policy->boost_enabled ?
> +                                       caps->highest_perf : caps->nomina=
l_perf;
>
> -       policy->cur =3D cppc_perf_to_khz(caps, desired_perf);
> +       desired_perf =3D cpu_data->perf_ctrls.max_perf;
>         cpu_data->perf_ctrls.desired_perf =3D desired_perf;
>
>         cppc_cpufreq_policy_state(policy)->suspend_regs_handled =3D false=
;
> @@ -1057,6 +1048,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
>                 goto out;
>         }
>         cpu_data->perf_limits_valid =3D true;
> +       policy->cur =3D cppc_perf_to_khz(caps, desired_perf);
>
>         cppc_cpufreq_cpu_fie_init(policy);
>         return 0;
> --

Applied as 7.5 material, thanks!

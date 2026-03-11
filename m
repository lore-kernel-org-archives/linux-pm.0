Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAC3D2FE0
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230147; cv=none; b=h5wkB3ehVxzJpWoxUTjyfyhDqh8H6DemrF9zFcvEhr11MoLL+CeO2n2qLFhi4Am0TMdoRfv82A22WStx2jBj2vQ6TijohsUbyUE+bgBPwwLzskYc59IENje3jodMFECQBzMEeWJziNpZ87PUaSSWrafH2puBLwvCjxz5YXXbnlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230147; c=relaxed/simple;
	bh=rFc7/PufrqVMIl7fpn46NnUuRbYojYuNgylZ4fkLAak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT5Hc73Ak6Pz3kuI/HXCLUX+qWcjlSsNtNux+0QHqabuvjLfHArXk19sZopYFC15tAbb3Kpz27d9jjjgA5sjkXpMD3smgYRlZNlPeoRVvlw4heBoPrD9fYJuSRnmvNfLvhubAByIhkfW59ggyCDh1V0qay24BmLAVLN+gJTZyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdLBAlqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdLBAlqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70437C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773230147;
	bh=rFc7/PufrqVMIl7fpn46NnUuRbYojYuNgylZ4fkLAak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hdLBAlqZuM0s6+/gaG3i6VZhsSb6msx0hmK9POntt/bp+gZxWU3m2XfNi2kK3gpME
	 kWN8qXQfQL9WtJXwVJeUP/b5qSMAGqpkDQtFkE9+H715eOq6NunfQXgqI1k1mG8z9b
	 g1BEpepDv/X7ldV3r1xhYl5oIHJ0ADbPA8UhK18jKba70nMO2+mPK9Dp1ah6j1PzcI
	 pqiC2Wfe6I1tydw4fdMxoP1ok0wx5DrR2T+ZRvVxKNO1OnRqOGsJQ8uY5YOAUT4OBa
	 W5T0bhZCWVarF57g6pFeWu2MFn1uIPEHI0jPbnRbXcZvXx0hpE7lloL0sMx59LWK8q
	 u8Evb0Re0+gfg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-673ee2a98b1so8586752eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:55:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcMHIXhNROu/rfUBXQFTwtZkKm3HF1VUDT/eg2uHrT25rWepk2dLKUkW/6JiLSsIZCJJoQR+zfyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNqHS523g4nF0GjScAt9ovm2lXuyeDp04xWA6emNymNDGtLRG
	Kl1/DVKRUp5Wd45qIKnlcaDw1q/hpIDtbnvMArPDwxvCvBsqTAd66dzfKf9FSEV91GPVVYUIyfL
	Z6g56JgIqNVfy+BgkOhC61cv6ujEqP28=
X-Received: by 2002:a05:6820:4b98:b0:67b:c122:d29d with SMTP id
 006d021491bc7-67bc8a25d3cmr1557251eaf.60.1773230146597; Wed, 11 Mar 2026
 04:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309083818.79588-1-dedekind1@gmail.com>
In-Reply-To: <20260309083818.79588-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 12:55:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i+T-GV=BcwWyBU5aTq1RiHVRqbx0F7SN5t7Bpj19_S7g@mail.gmail.com>
X-Gm-Features: AaiRm52ZxzWZnfyNxI09e6z8THXjScj6tmBUL-W_arBlSSVNJ-GFCVJyC6Uv2FI
Message-ID: <CAJZ5v0i+T-GV=BcwWyBU5aTq1RiHVRqbx0F7SN5t7Bpj19_S7g@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Panther Lake C-states table
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:38=E2=80=AFAM Artem Bityutskiy <dedekind1@gmail.co=
m> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Panther Lake supports the following requestable C-states: C1, C1E, C6S, C=
10.
> Add a custom table for them.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 42 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> Based on latency analysis using the 'wult' tool, and power break even
> analysis using the 'pbe' tool.
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 167eb72105baf..36f5766381172 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -994,6 +994,43 @@ static struct cpuidle_state mtl_l_cstates[] __initda=
ta =3D {
>                 .enter =3D NULL }
>  };
>
> +static struct cpuidle_state ptl_cstates[] __initdata =3D {
> +       {
> +               .name =3D "C1",
> +               .desc =3D "MWAIT 0x00",
> +               .flags =3D MWAIT2flg(0x00),
> +               .exit_latency =3D 1,
> +               .target_residency =3D 1,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C1E",
> +               .desc =3D "MWAIT 0x01",
> +               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
> +               .exit_latency =3D 10,
> +               .target_residency =3D 10,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C6S",
> +               .desc =3D "MWAIT 0x21",
> +               .flags =3D MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency =3D 300,
> +               .target_residency =3D 300,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .name =3D "C10",
> +               .desc =3D "MWAIT 0x60",
> +               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency =3D 370,
> +               .target_residency =3D 2500,
> +               .enter =3D &intel_idle,
> +               .enter_s2idle =3D intel_idle_s2idle, },
> +       {
> +               .enter =3D NULL }
> +};
> +
>  static struct cpuidle_state gmt_cstates[] __initdata =3D {
>         {
>                 .name =3D "C1",
> @@ -1623,6 +1660,10 @@ static const struct idle_cpu idle_cpu_mtl_l __init=
const =3D {
>         .state_table =3D mtl_l_cstates,
>  };
>
> +static const struct idle_cpu idle_cpu_ptl __initconst =3D {
> +       .state_table =3D ptl_cstates,
> +};
> +
>  static const struct idle_cpu idle_cpu_gmt __initconst =3D {
>         .state_table =3D gmt_cstates,
>  };
> @@ -1737,6 +1778,7 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>         X86_MATCH_VFM(INTEL_ALDERLAKE,          &idle_cpu_adl),
>         X86_MATCH_VFM(INTEL_ALDERLAKE_L,        &idle_cpu_adl_l),
>         X86_MATCH_VFM(INTEL_METEORLAKE_L,       &idle_cpu_mtl_l),
> +       X86_MATCH_VFM(INTEL_PANTHERLAKE_L,      &idle_cpu_ptl),
>         X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,     &idle_cpu_gmt),
>         X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,   &idle_cpu_spr),
>         X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,    &idle_cpu_spr),
> --

Applied as 7.1 material, but I've added some motivation explanation to
the changelog, see:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/patch/?=
id=3Dd51de21b4c3a34a2cc592319df63864e14b18b29

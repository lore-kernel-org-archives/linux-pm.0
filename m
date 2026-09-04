Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD53859EF
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532472; cv=none; b=A/N1ZDCYvodRI2M5VQrtwqnnaaVXS64mx+MwKGWZzWLffyjRwD6u1Cdg7R2EaC389YI1fFfbnSNwrAsJGaqvyoSQKwiOxducRnje/cKr6726WPe+BLGu0GkrfpvUFzb/ZsFKEzv5H1xkPxM735gVQwq9I0kkTkdkfLqczxsLIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532472; c=relaxed/simple;
	bh=Lu/ZbFQR8YsB0RojeQRe14FK9q1Bse2/VuOriIcwpu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EE1qZo3zGulfEaP5A1CuiAfyPiPhiMQ5uZeBrO67+Kl4/0yGFpa3g4LHnrvK/DdX9C+UT/Atl4JBCeM8ty1kJSrJ5i/7JSsJkvvi/lUavv7Q0vONAlYwx8qcd3U9Qq3gHxuKiNsERPjteYEC+WwQelPKig3i/mOhT8x1Y+y4wyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGmtDWDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGmtDWDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575911F00A3F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532471;
	bh=9OaydGP9xdIbN8GYTuPmveI5wh8brRuL4Gew5fDc4mQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XGmtDWDIYg+/2iYGY71haJDwmG1d4p+yYKb+c7xvk9+nGk//B9R7XmSlt1koJcHUS
	 ON/R6KcBKVW74/4u2zMwPjzru/T/YHRk9mt4Y2YkRRAWvg0MO10wXCX8Olb9p5nheB
	 mTObehVAKyoD97JHjn/veaRT85g6Q6/O/Qc3RlInTbvsJzxzTitfFFRI9oO/ygWaCz
	 lKUsBFGYBdX9lCWuVQ1Y/5cxur7/CzieWXTu+8s+53HjiZzYnSNFe3HMen4yiyEmuQ
	 xkf5MycabAVwcYO3L9n5xJxtKLHOFaa0idkmMYospji3KNA2k3vbZQwLvfGAHkBb7c
	 3hUZfjvIjQIIw==
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso543533e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:34:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0XraCqg7ZfHC9WzQTZM6/T4iFti5yYp71l6p4KpVGC7nOINKFm8TteyWsq76Z9JgUotyVkqUlnA==@vger.kernel.org
X-Gm-Message-State: AFuF++ntlfiD8lzNY9Sn7zt+Yh+Av1wgwLHcbbw2URuNtiEPQfbTv/zS
	XBNzFdAbIaKhDnFL2g66o3ljjwxmpKxJaBArjEYRi/lg6mxwpAbc3AGfdrKVlVAip5b3z6UBDna
	2GMGGFb+c4LOW7oFLZDzcnFbYYfIs4nY=
X-Received: by 2002:a05:6122:1306:b0:5c6:5daf:52ea with SMTP id
 71dfb90a1353d-5c7ed3ed7bdmr2902940e0c.6.1788532470566; Fri, 04 Sep 2026
 07:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819174020.1184329-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260819174020.1184329-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:33:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gipmERFJTDYYR0M2geK6B5aUz_7O7X9jBSfuOTjNQdvQ@mail.gmail.com>
X-Gm-Features: AcwNN1X9yqqT8-6jct4nBXFu8D7mFBst4d2UlF-O1r1syPYPum7YIsH6i1Du3wo
Message-ID: <CAJZ5v0gipmERFJTDYYR0M2geK6B5aUz_7O7X9jBSfuOTjNQdvQ@mail.gmail.com>
Subject: Re: [PATCH v1] powercap: intel_rapl: Add rugged Panther Lake support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:40=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Add RAPL support for rugged Panther Lake.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index a34543e66446..2c1b799d3c54 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -456,6 +456,7 @@ static const struct x86_cpu_id rapl_ids[]  =3D {
>         X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,            &rapl_defaults_sp=
r_server),
>         X86_MATCH_VFM(INTEL_LUNARLAKE_M,                &rapl_defaults_co=
re),
>         X86_MATCH_VFM(INTEL_PANTHERLAKE_L,              &rapl_defaults_co=
re_pl4_pmu),
> +       X86_MATCH_VFM(INTEL_PANTHERLAKE_R,              &rapl_defaults_co=
re_pl4_pmu),
>         X86_MATCH_VFM(INTEL_WILDCATLAKE_L,              &rapl_defaults_co=
re_pl4_pmu),
>         X86_MATCH_VFM(INTEL_NOVALAKE,                   &rapl_defaults_co=
re_pl4),
>         X86_MATCH_VFM(INTEL_NOVALAKE_L,                 &rapl_defaults_co=
re_pl4),
> --

Applied as 7.4 material, thanks!

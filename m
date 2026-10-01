Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5951AFC3
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866171; cv=none; b=uGDiq2nNvR3/F8zfJzxSYhsrDr7433+RAGoIR8uEVWSKTqAvkaEXGudHTr88TzWPltV6i0s5dMHwT1Rj9286hwFkFVFajYqTyYAZ7Kte6t7Kvd8VHGc+Z9pHv+uZSJEq0XY0TXM0mhqZgq8hFtQN+DXyrrr9dvQh+qkBCJVwgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866171; c=relaxed/simple;
	bh=V7u46sNVWKL4z36H5sU99U9pul16ah+/hvWwKR1Y50E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojz8qH3DZLMMOW4G5mBBWdb5eUi4S9u+NFgFQYEsI+azM6YEtCAjJPSVv0GD/6VgW3Iqr6e7l+vzgeFKrqzVQwW+WKJ2Pqp+g/fi+uJL1jDMs5cau/AbQ4RsrVk3ri/SuUFwz60HMNuAOnC54pdMkygVuQgBz0Fen9slXAeMcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFj0ZHgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFj0ZHgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC1A1F00898
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790866169;
	bh=Tgr7p0VhahlwKCMKcLQrM7qHhQG52smQ+uxsQJQ7xWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oFj0ZHgoy1G1c9lqXMSPI5mi/utJpF+WagGrhmOSvLXn/qbbiebWErVpzNVjf8kNb
	 OiDqA7EHe56VTDCw0N2pTiQ86XFnnp0cNaRmDIOuY4XWhXzzcv8r2KJY9jtXnFdyDZ
	 N/GrWjAnsmX9AKWeEsqMDCeHPa2B4EyGPhAjxVUuSptPJ4DlDeL7HEySgmPVt5SQri
	 WyhKk9jK1wBN9EBEKUpY5cnMaa8no/rVALaZiiS5C1AvjZZ4/lY1YyQt9Zh2Shk5eQ
	 DvHpSYpqIl5T1kA+EPCfgJ4Dro6fBguQnRxevX5cLoxnoLR8M71o79Umkxk+5tJc6k
	 +QPgD0jo9UA6A==
Received: by mail-qv2-f40.google.com with SMTP id 6a1803df08f44-917a345a6a5so13400896d6.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 07:49:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwfoPcEGGVcShlPQEPVOJXOyrEvlEzu5c0KTsq7ATJ3pji7J6Wuzs2/xSo4t0GrrME9qs1asuiH5w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKsZuXLnzVCOqz4B0LsgiIn+CdxQAAqhI5rLvaGXxIS450I7juL
	GxSNs58RoWePpN85oBNaFVzFi1mBcA9AJlldFz/XWYyBwbJXOGzU43pRq2sVZB3pKGcMi792UJn
	GXccXBi8Oe/qwKDKKb1FFUjpI5M4ELRM=
X-Received: by 2002:a05:6214:6291:20b0:917:a21f:d12f with SMTP id
 6a1803df08f44-917a21fd1b6mr69555646d6.28.1790866168848; Thu, 01 Oct 2026
 07:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819174154.1184393-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260819174154.1184393-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 1 Oct 2026 10:49:14 -0400
X-Gmail-Original-Message-ID: <CAJvTdKm5g2-rLjSXNPkGqUU3BD-PUbSbNJecBn2-CA29O3WJvQ@mail.gmail.com>
X-Gm-Features: AclHuK_qDOS55FG_-O0iK1pV9MC8gYHKkOHHOsAHdYwkbCKjTABNoLl4UY6wh7Q
Message-ID: <CAJvTdKm5g2-rLjSXNPkGqUU3BD-PUbSbNJecBn2-CA29O3WJvQ@mail.gmail.com>
Subject: Re: [PATCH v1] tools/power turbostat: Add rugged Panther Lake support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

perf_model_support() also should be updated.

thanks,
-Len

On Wed, Aug 19, 2026 at 1:41=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Add CPU model for rugged Panther Lake.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 920694c3c1ec..f5b3afa050bf 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1229,6 +1229,7 @@ static const struct platform_data turbostat_pdata[]=
 =3D {
>         { INTEL_ARROWLAKE, &adl_features },
>         { INTEL_LUNARLAKE_M, &lnl_features },
>         { INTEL_PANTHERLAKE_L, &lnl_features },
> +       { INTEL_PANTHERLAKE_R, &lnl_features },
>         { INTEL_NOVALAKE, &lnl_features },
>         { INTEL_NOVALAKE_L, &lnl_features },
>         { INTEL_WILDCATLAKE_L, &lnl_features },
> --
> 2.43.0
>


--=20
Len Brown, Intel Open Source Technology Center

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AE34BA5A
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733159; cv=none; b=oMU2QcVJ8SapWcDlIGsvqxBIoL/eTCj+VNBGg93vKMH3K4iJqkgFcU4aCCgQ9cqfmrmi4kBU1y27MAsfNGCzhdRokRCmm0Isdhl9ocCF6ILH3K4gB9cFfCbbch19R/8NXToiWYQ3rU03FminHPMjthDBoRzscYLo6Tg606iSU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733159; c=relaxed/simple;
	bh=5GazzGz0ESxhzl0dst0EQ81Ep2FS/ZEjC6YT2OpqLjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiPwH9nANLZdwDT5AHpYmfQuijG4qsg/SYQ8xC8tUAY7zpUGjcSlTikxOKxy6c3qFkTJAmFlb3hYB5BO0T+kAi1IlClmcWga7yLP+jRPuyi1frX684SN/iBjcjzx/xB/HZny3Z/7Yid8iVvcW0YweS+51//MAq1oqcgmre8YUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RafwKzgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RafwKzgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D1C1F00A3F
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733158;
	bh=cVzngUL8W0QUKzbinODupcjTLOSGnkN1PW9lCVId9AU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RafwKzgb6/qUyQP8E5u0rL7LNLISR0/DTXwsO2a1BqateMSXql2BS8XG/J1FxhWE5
	 g0VGEK5WmKjC/FVy21GVLz9+QdejnAlpmAurM9TBQgdKV+9WEVIpZbwAcc5BZxfezk
	 p9Rhyd0UkA9q/LpEj0IEQcv0eR6Q0pFpt2MhnqOO/mboXKV5p/h3bPKj6nT953je6t
	 sgw6ruOUj7VRf1rwnMYoV4SGcgEsExbjAReLenY2Tf9lPoMVgxOsM5E/rzgeW00scf
	 1Wi1Do8tk4uSusjZV+oE+2lQCMNDzUCm9EkmOXAviyLRnZH/QOazCPbGj4F17lVSLv
	 adi6daHrAHKUw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeba09900bso6892619e87.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 08:12:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RolM3qo4kzPyEPSEQqSCkfBmS9fxhEk+cIGMiECvKXcfoEm4G11unA4W0CjcUN6Vf/CEONt+kyQQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhCIt9ogL4S8sWqcfP3Jl4zjguHpt1TTLr99Pair7kqg4dReZ
	5LqrDynFC22ALDuDEVOp5EbXzA09k/ggP2xGp4nUTcb76rd/2I5zx7FviZbkNCkBCYHwfIi89ZM
	BFdHyNC//Vd4C327HZx6A+ozQtmpfpRo=
X-Received: by 2002:a05:6512:3409:b0:5ae:b7ca:33ec with SMTP id
 2adb3069b0e04-5b28f8550admr4944592e87.9.1784733156543; Wed, 22 Jul 2026
 08:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615191832.75923-1-ronanmarchal29@gmail.com>
In-Reply-To: <20260615191832.75923-1-ronanmarchal29@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 17:12:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTY70wtLVEF1fbBDOj8kU64higZPA4wA4eh8W2c_QhNA@mail.gmail.com>
X-Gm-Features: AUfX_mxfmAysiNbCXAVh2HVBxdeR_4-GeQ_0RWTqpIPyZnj-iGiFIRbu-Ltud1k
Message-ID: <CAJZ5v0hTY70wtLVEF1fbBDOj8kU64higZPA4wA4eh8W2c_QhNA@mail.gmail.com>
Subject: Re: [PATCH] kernel/power/swap: Use %pe to print PTR_ERR()
To: Ronan Marchal <ronanmarchal29@gmail.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:18=E2=80=AFPM Ronan Marchal <ronanmarchal29@gmail=
.com> wrote:
>
> Use %pe format specifier instead of %ld with PTR_ERR() to print
> error pointers as a symbolic error name (e.g. -ENOMEM) instead
> of a raw integer value.
>
> Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>
> ---
>  kernel/power/swap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 2e64869bb5a0..d86a343dbdb5 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -746,7 +746,7 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>
>                 data[thr].cc =3D crypto_alloc_acomp(hib_comp_algo, 0, CRY=
PTO_ALG_ASYNC);
>                 if (IS_ERR_OR_NULL(data[thr].cc)) {
> -                       pr_err("Could not allocate comp stream %ld\n", PT=
R_ERR(data[thr].cc));
> +                       pr_err("Could not allocate comp stream %pe\n", da=
ta[thr].cc);
>                         ret =3D -EFAULT;
>                         goto out_clean;
>                 }
> @@ -1250,7 +1250,7 @@ static int load_compressed_image(struct swap_map_ha=
ndle *handle,
>
>                 data[thr].cc =3D crypto_alloc_acomp(hib_comp_algo, 0, CRY=
PTO_ALG_ASYNC);
>                 if (IS_ERR_OR_NULL(data[thr].cc)) {
> -                       pr_err("Could not allocate comp stream %ld\n", PT=
R_ERR(data[thr].cc));
> +                       pr_err("Could not allocate comp stream %pe\n", da=
ta[thr].cc);
>                         ret =3D -EFAULT;
>                         goto out_clean;
>                 }
> --

Applied as 7.3 material (with a modified subject), thanks!

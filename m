Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56A218592
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220432; cv=none; b=cVDKefFemeGbOnxTduZSx+nliPrZAQrYU4MDmwo/egUaQbPTVjNMhhmAKyAVCiJnMZCrtXUg9awdoV9uX8uFKFsAB6TjU0XkkiY6OFiPtKrTVku8zGbTo5e16K//7SLdKkzQJ3lOYDDrewdXBd9B3NGWqhA+UNd3RbyCczOtvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220432; c=relaxed/simple;
	bh=6kgQq1JR5YkDGHrK0Pb31Ys1zMbTatf4QlMOgLZjK0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkXvulkeSdsv/8Sk4ODFghC16HuHR2Hnb1ISpiiFfmv51Bt/Szun53/+YbgCrOxkSsf8J8UGifeohatDsQb20Yh0ki5GF5s1ahkMOYifMDI/moV/Ml26qX82ZNCKtkhQ7r+2pSobk7ue/xMZ0TKxyC0kSgwuCdOHO5lJV/I7QPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuzwK7tZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuzwK7tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891FB1F00A3A
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782220431;
	bh=TghcwwMUvRBGyLlb29HLs1KGhiol/I5UcGjKQIeVCJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BuzwK7tZM+S3Xk9p8eiBvEoazhqH793uLkhhVDUjPIK9+iUYad3/HQCIrTEZdMBlD
	 Xc+7JfgDnWk8bzEO06k7zzsNCjHt+3kSjFwCQra75LGLtL7st/Cd0XOpnrbK0gZZIc
	 DQoYwbYGpA9k+ODTH2ZZECSXe4vtBWppUsvVO8aoRYm1z3FFz02Xe+H+ly2CCDATjU
	 1yf8kcTuc3VBs9yqxbquFqmqbH6FPxHsBGpQgKJ0C96BRe+shYhK4Teia5SFKdbrzh
	 M6Uhes3txIbg0jZRkAtv1t/2VfZJ/shqz8tvhZZs4og+kqzqzpTeiwOEVa/W6+5tgK
	 yWAF5mZL33lmA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad54546171so3524439e87.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 06:13:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9xjf4FBx7VV8KtwGAEtIkEgF3KQl+NqlDCfXzSSB/Y+9f8ErjAf18IDbVNDRuS04N1P7mSwdPNtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAzhaDbg8F1ZghV64GeauRKynxixqZvXl0GkGnJ6RE4097yxJ
	gm39TL39RE4e2tzUWgYe1GesKtkJA73jyohVeRoqkBq6ffQ2QTUFHe4RfpmiTaBsQUKRyoF3Jgx
	IAFYAkROPFGRXzNx6AYdlhcaLS02Drq4=
X-Received: by 2002:a05:6512:6085:b0:5ab:bf4a:3637 with SMTP id
 2adb3069b0e04-5ae3510c6d5mr673632e87.31.1782220429975; Tue, 23 Jun 2026
 06:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12116e07-040c-4536-958a-d55d04d163c8@oss.qualcomm.com> <20260613171559.43079-1-skunkolee@gmail.com>
In-Reply-To: <20260613171559.43079-1-skunkolee@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 15:13:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJynCmDM-uq3=UpQza1rUn_9uq30XGiy-RoVCetOspVQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfj2FqrXPaEU4G_INduNmR99cxrCVJAvmWsE33jCSgjEeZeAyMY_wBaOow
Message-ID: <CAJZ5v0iJynCmDM-uq3=UpQza1rUn_9uq30XGiy-RoVCetOspVQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernow-k6: replace symbolic permissions with octal
To: Jack Lee <skunkolee@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 7:16=E2=80=AFPM Jack Lee <skunkolee@gmail.com> wrot=
e:
>
> Symbolic permissions S_IRUGO are not preferred. Replace with octal
> permissions 0444 as recommended by checkpatch.
>
> Signed-off-by: Jack Lee <skunkolee@gmail.com>

I don't see a good enough reason for making this change, sorry.

First, checkpatch.pl messages regarding the existing code are irrelevant.

Second, this particular driver is in a deep maintenance mode and the
particular update in question is not significant enough for touching
it IMV.

> ---
>  drivers/cpufreq/powernow-k6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.=
c
> index 99d2244e03b0..764907b04c04 100644
> --- a/drivers/cpufreq/powernow-k6.c
> +++ b/drivers/cpufreq/powernow-k6.c
> @@ -29,10 +29,10 @@ static unsigned int                     max_multiplie=
r;
>  static unsigned int                    param_busfreq =3D 0;
>  static unsigned int                    param_max_multiplier =3D 0;
>
> -module_param_named(max_multiplier, param_max_multiplier, uint, S_IRUGO);
> +module_param_named(max_multiplier, param_max_multiplier, uint, 0444);
>  MODULE_PARM_DESC(max_multiplier, "Maximum multiplier (allowed values: 20=
 30 35 40 45 50 55 60)");
>
> -module_param_named(bus_frequency, param_busfreq, uint, S_IRUGO);
> +module_param_named(bus_frequency, param_busfreq, uint, 0444);
>  MODULE_PARM_DESC(bus_frequency, "Bus frequency in kHz");
>
>  /* Clock ratio multiplied by 10 - see table 27 in AMD#23446 */
> --
> 2.54.0
>

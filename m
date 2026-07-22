Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22A35677C
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732929; cv=none; b=iFnyjlWpScJFp1beQhPWPm2t4JzndjiQ4O4tqPisG/BR6ffxoBZGydcq1DqBJpmc8LqZ2BTscV0E3xxD2gc0DtK+cpwSZlNz0FQoF8kVrxUoClG8X+4omMNm4VzAfmeFcwNZrxYkq8d0EuvsMsIROIjGBTCJzuHzjdpXFEPta0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732929; c=relaxed/simple;
	bh=86rGyCjXKG0RhjV8/BFhPliNvkr5OxZWv/2N2+NlhLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ3Cp1w63ZTr/CJdCsl013ZCnUsvX3d/Va0tQNu8xDbHWJc7DwVioNhr+7UuGpL+yGWvIRy9kiBtgF6eqhGy5XWSvK1LsMmJvL9r21qcoPGH1VM8yu4tz4UQP5/GqscxDEjxT/1BIY/9aR4UZvRLLG3W6yKGSn67sf5OTFwiJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu20ZTbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu20ZTbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1621F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732925;
	bh=RjurmjS5XBSWOlutZ+7C7YuQ4yhTj8tT4xCwPNN8iI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qu20ZTbrCymU53aJunVvk7SsRdyqo03dpe8yJM1pIrRA5wxmPNxjkXIKMaYhzawSm
	 yRUT6pjFXmFQJxDEvv9wxuAnfcrE5HXfkiOkko9eYqoLjLb+DfdTGjkAQ6B3/fLfj1
	 pIuTP44JEBMvwS6uSV6LHE724xWA15kALqKorUAYzLnDekviLQoRb+zDkmgqRJUOkw
	 wgDohdpPoyc/T02Y1zYNzc6PF2Knh/fmARhqaEIkjugyTHJhlA1soGVaFzqHy749UO
	 I8sHzNeJHFUOiEl+JaE++wZLgDXokObgNrhpH7ad+XvnIF68FnmCtQBUFGCAI1kf8y
	 i34rzBnynw8og==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aec6360133so10571713e87.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 08:08:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrBVgIfkytXB6++DdGEbD7gT7xZetBPlKceS6OJAfW3D15mQUv5bPsBRQqtrbWp3JOO6LCs3sv6cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEQFeLMFEX7ZHlGYTn4JhVkhWuiKLroXsTwl69c5k5XY5YMFV
	NNllXS2UVBI/n0u2dzWmcrTi1+3sqojV8lFAFaKzVj9MRUtpzYtSDaLl62uN4QBn+j4SmnmkFa9
	s9f59x7UEGqsQCEnPmaDAAugACg0Rnno=
X-Received: by 2002:a05:6512:a8c:b0:5b1:5d07:13bc with SMTP id
 2adb3069b0e04-5b28fabd161mr6104620e87.61.1784732924151; Wed, 22 Jul 2026
 08:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702160240.2929965-1-dmantipov@yandex.ru>
In-Reply-To: <20260702160240.2929965-1-dmantipov@yandex.ru>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 17:08:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCKCPaj61DtQu9vve2h8R672T1u0Lrmy-yyBchvA_3OA@mail.gmail.com>
X-Gm-Features: AUfX_mzSHYKov-6rSoyBcyeaXXq_o-5oShCJFj6eYZb_9E--sj_i-qpPsr4y2HA
Message-ID: <CAJZ5v0hCKCPaj61DtQu9vve2h8R672T1u0Lrmy-yyBchvA_3OA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: simplify ptc_temperature_write()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 6:08=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> Simplify 'ptc_temperature_write()' by using the convenient
> 'kstrtou32_from_user()'.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  .../int340x_thermal/platform_temperature_control.c  | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_c=
ontrol.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_contr=
ol.c
> index d92a6f84a778..43cb809c5dcc 100644
> --- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.=
c
> @@ -227,17 +227,12 @@ static ssize_t ptc_temperature_write(struct file *f=
ile, const char __user *data,
>  {
>         struct ptc_data *ptc_instance =3D file->private_data;
>         struct pci_dev *pdev =3D ptc_instance->pdev;
> -       char buf[32];
> -       ssize_t len;
>         u32 value;
> +       int ret;
>
> -       len =3D min(count, sizeof(buf) - 1);
> -       if (copy_from_user(buf, data, len))
> -               return -EFAULT;
> -
> -       buf[len] =3D '\0';
> -       if (kstrtouint(buf, 0, &value))
> -               return -EINVAL;
> +       ret =3D kstrtou32_from_user(data, count, 0, &value);
> +       if (unlikely(ret))
> +               return ret;
>
>         if (ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units)
>                 value /=3D ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units;
> --

Applied as 7.3 material, thanks!

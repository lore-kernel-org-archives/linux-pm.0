Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C35481DD
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769950947; cv=none; b=kHVXwnp/z363nZN13Yo49azuXMvGSRlLjr658Yt8SuSwUX5vUVvUOY3uwkNr2LsJjzm0yzNllgcgUdM7mvpw3ifaf2Y03m0StIILAmOoDdEZ5IuYLLZ4byEAzPZTZRq588eGoC++3TSKnG21v1aAfNOVOSyq3txzsKC19gOi4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769950947; c=relaxed/simple;
	bh=LHAnUGBO4TZLE4h7mj0mYdeiW0XaLxfBOYQH7KCdEH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0EeM3/G5gR6slMYvO8MYXqQgvhN6x5jkep/YQeitW48mz0ePjKWFYoFSkDmeGTVjk8Ng1cfOXaWvJqGcms5h8SZHHNprScrf4dDo2em3ly7I2HIxolkAhpeyV6WpEB3nBAFp0gr11ydVoGM8j+cWPMmL8yMJ3nggEFtxS3p8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/+sJTOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/+sJTOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6034C116D0
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769950946;
	bh=LHAnUGBO4TZLE4h7mj0mYdeiW0XaLxfBOYQH7KCdEH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/+sJTOzfqH+k+GVdyt81et34RjqraGhaD/sOqbl3o/gSbI3JIrKRAZCNEv+ICkhm
	 dt9GkXSKcoOpocDWVyJDQuYO5H1GHp0xxielugYVwDAMRP3UkShAn8TfqlHR0LE/00
	 wMA5DQmibnh6dnABlgKd2v9J5JmVsSQfzcGepD1IkVM/dTotZHG2EDwDnEdaHgzFet
	 eizFBsI2KlSbnKJrBlhiSiClu4jdmLkzjsnWS0GkndiguALvs07habXwVCc6K5kpWA
	 E03dTgi88dcVOFEo5dZAB19GTDtMEjUBl2JoYEVFB5k5ntFHgN9e4kGQkTNkjwRNCI
	 GPSUf5j5dp7SA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6630d0685abso1786190eaf.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 05:02:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYfYHJwmA1G14nJBjl5dItGimahEc9I07U4X2GIiXkr1XaWP5s3PMx5ezoW5scQmo8nPvoNHYrXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmJz2obnq8A/oyT6X2Yo0sDNRlp2RbqExezqJsBGl0YdqrSYR
	QzOsdnQWg/17BQbrNGZegIwkDGc+p9+0pWTGT84kT224rumf3wkmLx3zzWkriUT6yORTJ0u4BQs
	EzrmQhaKiKo3AMw8e3zXIdNUxgprsCU0=
X-Received: by 2002:a05:6820:f02d:b0:662:f39e:efa5 with SMTP id
 006d021491bc7-6630f3b1ecbmr3811069eaf.79.1769950945827; Sun, 01 Feb 2026
 05:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131151615.6230-1-sumeet4linux@gmail.com>
In-Reply-To: <20260131151615.6230-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 1 Feb 2026 14:02:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i=w5fgJ9r0or1gi-akz7s-6dU4uLZZ7kAcwetVpA1CHQ@mail.gmail.com>
X-Gm-Features: AZwV_QgivRAnbkVc5WrtiaSdjI6bzJPUKzxXfSjva1qTpjKaDo-aZX-Ck9J6Jm8
Message-ID: <CAJZ5v0i=w5fgJ9r0or1gi-akz7s-6dU4uLZZ7kAcwetVpA1CHQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: intel: tcc_cooling: remove unused variable
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 4:16=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Remove the unused variable 'ret' in tcc_cooling_init() and simplify the
> error handling path. The variable 'ret' was declared but only used to
> store the return value of PTR_ERR(tcc_cdev) before immediately returning
> it, which is redundant.
>
> Remove the duplicate variable declaration where both 'ret' and 'err' were
> declared, but only 'err' was actually needed.
> Also, simplify the error path by directly returning PTR_ERR(tcc_cdev)
> instead of storing it in an intermediate variable.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/thermal/intel/intel_tcc_cooling.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/=
intel/intel_tcc_cooling.c
> index f352ecafbedf..a5b31b25225e 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -72,12 +72,10 @@ MODULE_DEVICE_TABLE(x86cpu, tcc_ids);
>
>  static int __init tcc_cooling_init(void)
>  {
> -       int ret;
> +       int err;
>         u64 val;
>         const struct x86_cpu_id *id;
>
> -       int err;
> -
>         id =3D x86_match_cpu(tcc_ids);
>         if (!id)
>                 return -ENODEV;
> @@ -103,10 +101,9 @@ static int __init tcc_cooling_init(void)
>         tcc_cdev =3D
>             thermal_cooling_device_register("TCC Offset", NULL,
>                                             &tcc_cooling_ops);
> -       if (IS_ERR(tcc_cdev)) {
> -               ret =3D PTR_ERR(tcc_cdev);
> -               return ret;
> -       }
> +       if (IS_ERR(tcc_cdev))
> +               return PTR_ERR(tcc_cdev);
> +
>         return 0;
>  }
>
> --

Applied as 6.20/7.0 material with some adjustments, thanks!

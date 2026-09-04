Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7DC3806D0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532276; cv=none; b=o4W3KkiVlfRs33S4PhgUYghgeLOOwJO3SgvPaqOtXJPoI/6BOqJWjLpLLBh/cyZP4+qxDMFUmquuarFylY13Z0jlxV3h7KTYmjMh3rRM/2AR4gDqjPWsSB+Sk1ztQgjzsB9EafWsws2oM4lUm02RePDj7fZA6cKv+7jmdsQbaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532276; c=relaxed/simple;
	bh=98yf6ldz6t1YlrkmJTWOhJhENupp7cCnJ3WvpT+bHss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et9vMvG1oalECOHYUkg8hLChp3mxjIAcCAvCLb8fWJBV5KP7ozdqzPRR7pA2JF9/bS/mvu6KJZ1RxcrBObxolF589whz4mifYgCs+cKNaYMqjdug4V4kVjF1rV1clLnWxJSXrdCkJpVlz9M7OAeS5IclxjPXpRlPvYSythysJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QizAYMuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QizAYMuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9C51F00ADE
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532274;
	bh=yNQ8sjJ0sOuntry2syhaAzX8NW9+/S8Ti0as82rapt4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QizAYMuhQAxmVaZXR3JOi5bnYRBOiDyjQzqrzVI4W4eTWCpsvZBdPmbLdXxrGBHdZ
	 x2BdX2ILSVlc0IR+MJOjtMP0q1JhXgDIzOOyG/+aHKNdrzCkHoePp09co3t2Mcr85g
	 p24ahwWBDdnKwgq6NHW8QGjAnoYKK5e6SUnLnMiH1pxiZSlf8DYnb8hd3oiLXm0kVq
	 Te/WydegN3mHjKfIQT+CU+OxeN9q8Jkut9VX4nxICcSkZp/pxhtV1Ah/8KxVddqgSG
	 7hPs+cJwMPfbb/tJPZznsMgX9qbUTW0PbVeKemQyzwaXBRUFpFYYeFUsn5iBJnBhxF
	 r0nRAYuQ3/sTw==
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c7d1512dbfso914254e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:31:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzmZK7Yd0R+1ygA2IOqxt4cvMegY4aRgTiC800QdJWB1g4Z03Js1U8uZsISUJUWm+2EoYWmZJTcMA==@vger.kernel.org
X-Gm-Message-State: AFuF++lgaTiwFc1QOJNiZvcDSqzcFD8tyDYaXVyARizGGsKbfBYVbfPJ
	xf1bKdifgILFjCDjc+GoDJ9RCakjjZQ75X1MvNXoOrvaqwUbxdokxmMualp66KBqZcM5dcaXrfb
	tk7b3juui4n8cGZDB6T5xDLZ5j4MPfWQ=
X-Received: by 2002:a05:6122:8b11:b0:5c7:a844:493 with SMTP id
 71dfb90a1353d-5c7ed2f89e5mr3331040e0c.0.1788532273855; Fri, 04 Sep 2026
 07:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815095143.3821-2-thorsten.blum@linux.dev>
In-Reply-To: <20260815095143.3821-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:30:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hP8ZiQiNAdz2OLEHu_T=2ARiKRwEg3S+21wSAM9c2PRw@mail.gmail.com>
X-Gm-Features: AcwNN1U0ycofXwvh9021ISYWsetE1Z-QvoegoSyN7HikiCof4XI1Hp96ylG0ga4
Message-ID: <CAJZ5v0hP8ZiQiNAdz2OLEHu_T=2ARiKRwEg3S+21wSAM9c2PRw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: Drop redundant clamp() in duration_set()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yury Norov <ynorov@nvidia.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 11:51=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> duration_set() rejects any new_duration outside the valid range before
> the assignment, making the clamp() call redundant.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index bd7fd98dc310..1efdaabc4bb8 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -94,7 +94,7 @@ static int duration_set(const char *arg, const struct k=
ernel_param *kp)
>         }
>
>         mutex_lock(&powerclamp_lock);
> -       duration =3D clamp(new_duration, 6ul, 25ul) * 1000;
> +       duration =3D new_duration * 1000;
>         mutex_unlock(&powerclamp_lock);
>  exit:
>

Applied as 7.4 material, thanks!

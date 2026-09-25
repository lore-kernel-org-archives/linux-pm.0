Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229046A60E
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367378; cv=none; b=d55Fkg4Y/vLSuX74vOuPMIVlTe7QOeKOJ94aXDJpmTYKQCC+Hqj+V8ZzETATdGuPF/wcB5Wthee1QY36KlM5atO1wR+XSSgtXC9QGbvbHJtHLahLB51o6onh9ZUSmpDn7d16E5CMakJirDBTtvavrpg/mvtREYhGqzyfAq39Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367378; c=relaxed/simple;
	bh=zhCwoSHvOhH/sMmyMDPzYTxwaB5CFqS+vt/BBq5Sww8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKd5SuSvQJZfOGX9/JbjtnBdnhotwlZCSAqf6qBGDx0B6G+uqcCpMPc1nFM1X6vWiI8aJj+490t6IPK0svGHqGwpAPfnq2CCOvM4tApZ2nMMGZbOk9np9fgZfhxtouX6ZEstmljzs8TZgbkmvmfnq4Bl1GtgUqX71qO0wQ27At8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo5jKir0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo5jKir0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75CD1F0089A
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367376;
	bh=yHQYo+JSQ0XDZc7/NCT+iFGUGwIfIqKSC52HsPPN9ko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fo5jKir0aAl3pSrTu094VUCVC7L05JswkGn+p7hxsWSby5XrdRmM6UVh08TG7Ozjp
	 Ijbg03rFbvQeGgXaNc+oHwWFYqcGraCnL+muisOYXLTgBVnYr2uqvs/h/G27+rIV4m
	 DqsltJVqs/A0nb2K+91B/m1FLpcV+jNyzZUXn3bi1HZehrukuYT51i5a+Yj9qJvqF6
	 5ygjix4T5nCyirBLup2Y0lzEsSA5VhVO926adcINUJIlefIbNJXftOOeGbM7WT9IzS
	 stSj9MxKYlVHaiWUzP4FhYtem2FycFBBqwHPrMMU8/ioejs9JWzoVpgg9G1QXdq5cn
	 6HyEiBh0uVVDg==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so10263931fa.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 13:16:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwKuIDcChs15MOumZ2zD7FurzDWZ1oWuXCo0iYtANp9Y7QMlKMOYW5lTpe8kmPJtXHTC91cg3UWaA==@vger.kernel.org
X-Gm-Message-State: AFuF++nqDXYb2aoA47i7GdoHIT/92QA6VnyNWDuspsk8rfy2kE833dxF
	nm66qWwf0c0EDJt87JVVB9LFA8wqZC22rDA9eUBFHi3WXCVGg6cKAcVtAZm21uKDSS7I81g4DuH
	ag6PEMpIEedxNQ4+P4aO+PK6HWKo5a7U=
X-Received: by 2002:a05:651c:19a4:b0:3a4:d4de:bad0 with SMTP id
 38308e7fff4ca-3a63c0f59c8mr18075131fa.19.1790367375165; Fri, 25 Sep 2026
 13:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923202911.90464-3-blum@kernel.org>
In-Reply-To: <20260923202911.90464-3-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 22:14:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ix=uLVTHzVO3t5HdPKrm-ybFU-HeVuYyXdbcDyNxCAUQ@mail.gmail.com>
X-Gm-Features: AclHuK-LV4aj5PiuJEt7_RFmYLgQqlMjsLW-7diENuwp-vDaLduNq-s8v_TxG6c
Message-ID: <CAJZ5v0ix=uLVTHzVO3t5HdPKrm-ybFU-HeVuYyXdbcDyNxCAUQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/cpufreq_cooling: Simplify cpufreq_set_cur_state()
To: Thorsten Blum <blum@kernel.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:30=E2=80=AFPM Thorsten Blum <blum@kernel.org> wr=
ote:
>
> Return freq_qos_update_request() errors directly to simplify the code.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/cpufreq_cooling.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_=
cooling.c
> index 768859a7aed0..e89036077bef 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -488,12 +488,12 @@ static int cpufreq_set_cur_state(struct thermal_coo=
ling_device *cdev,
>         frequency =3D get_state_freq(cpufreq_cdev, state);
>
>         ret =3D freq_qos_update_request(&cpufreq_cdev->qos_req, frequency=
);
> -       if (ret >=3D 0) {
> -               cpufreq_cdev->cpufreq_state =3D state;
> -               ret =3D 0;
> -       }
> +       if (ret < 0)
> +               return ret;
> +
> +       cpufreq_cdev->cpufreq_state =3D state;
>
> -       return ret;
> +       return 0;
>  }
>
>  /**

Applied as 7.4 material, thanks!

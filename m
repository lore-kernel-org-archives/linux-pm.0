Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB943E0725
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735109; cv=none; b=JkaPDdrd8/snE05mMAp6tUGouOzrMCbeKy8ewuYT3eo+gP61uq0zxExGCjG3dZhewyBUA2K0026ZVIwC6Nq8d7jxzzrqoShY9xnzXdcXLmSQN7AQyjAetGDr056xkjIJaCS8uTDJK+D9Da4IGgGwVQ81MN+58o6ARHphpwcfLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735109; c=relaxed/simple;
	bh=OkgcOV5Ul5J63h6nwql5R8DCz8pLNgpXgyXIBOjoO0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3KlCVm6lrJVV3liyqk02GSIkDP03GtehbpSVGM6UvX/MnSL94ufzj9/TdcvpN4+THzXc4S1ZCNSCAcaOwWXXjD2ctd+rjXeWfmElfPgA2Pf2emf3VCAKRQIjHBSXGfBmTrz0AQb9euWUkbUFZbgbjYn62bdmmrTa42ZAAESVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQjrfv1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQjrfv1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA1D1F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735107;
	bh=nZp5zAc/XaV1QO/J4j6Adp1+PrWzaOG1vQMu45wrwJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bQjrfv1g6W8r6thTzPS57sztAAULlnYZ8sqe7205eLsJI9l4jrcqSI/uaKPG5u0i+
	 1PKqgPyvEW/jNsABaWz9SKO8SsvjDEngs2Ju0J0vcJx1r/2cJASjO/SRi+GoL8OhXB
	 It9YE2g4z5tHlxumia256gLxCrqky9rpC1JhAbiqoMQKyvw2ngaTfygYoa5KiCkDNe
	 /qCvxHIlYeh4IXm1N8IxJC3njoaD1HHD4ljdSy686FH1l3cw+JnxfwrN4UZVXVDVQj
	 MqFXWtXcQy0c6MXzt9Jody1XLQI6V6EU4azaYzq/HyiprEkFZjWIBqBqE4UvEDAE47
	 5JXsCJmaJ2wFg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b021916bd3so11770284e87.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 08:45:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RppblhfKKYf/Sia1eZZYRK8I7H2GVqcb7CANSaGJxdijAAfBGt6NLVd8rIdAbtoyXHPo2L3BqUEvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaUjxsh52yN/9mwqCtllzcym9RJ2XHy83ZTokaMUG05lPntch
	1Ue2BGAXAmmFxbIJNTjWLiwO8EcQ1QVb9Ih7hDhBdO+DJhDT06w9bZXKfLuk32vb5Lx6aiJq1Zs
	t9fwgF0KSRzhNU5Tx1wXADyRy5QiAmOI=
X-Received: by 2002:a05:6512:6206:b0:5ae:b713:f26d with SMTP id
 2adb3069b0e04-5b28fab5346mr4692658e87.58.1784735105462; Wed, 22 Jul 2026
 08:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620074157.1059161-1-amarjeet@intel.com> <20260620122637.1334927-1-amarjeet@intel.com>
In-Reply-To: <20260620122637.1334927-1-amarjeet@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 17:44:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpZk6F2sZEu+CGO79Z_rUaBrMzoCXrw4H3g1MxzttCPQ@mail.gmail.com>
X-Gm-Features: AUfX_myDBt-45sA6ahxlSkbYlVGWoAbUDU9X-Lsb8ZLdkwJJmreF25Y4-Lrx9xY
Message-ID: <CAJZ5v0gpZk6F2sZEu+CGO79Z_rUaBrMzoCXrw4H3g1MxzttCPQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools/thermal/thermometer: close fd on realloc failure
To: amarjeet@intel.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 2:27=E2=80=AFPM <amarjeet@intel.com> wrote:
>
> From: Amarjeet <amarjeet@intel.com>
>
> thermometer_add_tz() opens tz_path and then reallocates thermometer->tz.
> If realloc fails, the function returns without closing fd.
>
> Close fd before returning on realloc failure to avoid leaking a file desc=
riptor.
>
> Signed-off-by: Amarjeet <amarjeet@intel.com>
>
> ---
> v2:
> - drop close(fd) on open() failure path
> - keep close(fd) only on realloc failure path
> ---
>  tools/thermal/thermometer/thermometer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/ther=
mometer/thermometer.c
> index 022865da8e3c..1ae6c3ecedb4 100644
> --- a/tools/thermal/thermometer/thermometer.c
> +++ b/tools/thermal/thermometer/thermometer.c
> @@ -272,6 +272,7 @@ static int thermometer_add_tz(const char *path, const=
 char *name, int polling,
>         tz =3D realloc(thermometer->tz, sizeof(*thermometer->tz) * (therm=
ometer->nr_tz + 1));
>         if (!tz) {
>                 ERROR("Failed to allocate thermometer->tz\n");
> +               close(fd);
>                 return -1;
>         }
>
> --

Applied as 7.3 material, thanks!

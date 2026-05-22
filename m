Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA9372675
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469039; cv=none; b=Vmr1AgtBkhJIV/9vDJXKS6Ru0v7hg27RCY6TH/gjDnOeb47O2RdweTLSFpDV2ec9ICCiUs/ofaIeKZ0qNpc4GE8TSmXkNYTasf5F1GQJGt1XA2scOdOd+h5+QxA41PibI9/RCNhHDrTkG2f4H2VCuly6SNhQ+S5VBHEIRP88/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469039; c=relaxed/simple;
	bh=oKltQbpmYlxME7CofbgLqQ850qxw/4UfJkTUuFOLisg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haxMgfJV29XidDwuikhquAPj/f6BxbckxKkIDjVQ6sVHqm8n6JAU8LxMRM5uz6m8/2egumaZIRLqCI5MrYu7R5Edgors3xO20+UpBpW+QtTRK+u1GBpisdR2WtHy8uBAOpdJdabBQQAIPOCj1JWqvFghRhKk4t8PX8PTZiLuB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXn1BoL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXn1BoL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF0C1F00ADE
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469038;
	bh=XDvOCVZwNoeBj/LTvRP2Kk/jvKCTqNq6FjLEMMb3Rl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hXn1BoL1m5DZXzgLiklTDKtrU+Ps8sh+Y/UiUCCv97npxdbPXYq1tVi4bwekxTytv
	 KK7ucu1CzmZ966geYoPeelMuVXuCp27DbCyOJ90SaWl4Wcu9oLt7KHoLQMhpRIFyHd
	 swCwatp75/aTSW3X7fy3Tpx6Rkc0NpRs4d8reIrcXrvkbiFbXS5i3tuDi/ByjoHo1q
	 nEgxccpJptquNXoqdbYE7ta6eI+/+e/TSJTdZEtKEvcmAMyIPe+jRvbUBFlwU6HuVP
	 QjORkVwwM3XCryR7Q/142whyrG2Os9cEOaL1rzJiFcOrKqTJqdG73OipxACH54KUwQ
	 mbgZHzQyjM+Xw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39396f873adso112149371fa.3
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Jgr+8+0rIxZ+BR47RFURA+bU7TrL+GkbEOS1VWt+eJF1SNO7dixv1VbME9YCthlOvGYPviezbKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9NITkswfBrHVKx28rAWIWy3ye4qqBD8/xwtErwt/yvHVnDcn
	MdI1bWkRecBqWDnMwAmje3Nl0+45pl2+IpJJ3GfK3F8nOzZSvQ0AYnwVP0OrJJyAHuxqE/rsImp
	LO1dyUnXiz3ZGgSmvtfMqmZ0xhSv15/A=
X-Received: by 2002:a05:6512:33c2:b0:5a8:d7d4:4948 with SMTP id
 2adb3069b0e04-5aa323c3cbdmr1463693e87.33.1779469036955; Fri, 22 May 2026
 09:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jskPFOQELt+XE6DhcTxVomqzuVJF322n3n3xffbG9Uog@mail.gmail.com>
 <20260511175246.217788-1-kmayur809@gmail.com>
In-Reply-To: <20260511175246.217788-1-kmayur809@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 18:57:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gM4njmYU0KmObQnxXLcWmX9YctN=ZD9QDy_dnQz37S+g@mail.gmail.com>
X-Gm-Features: AVHnY4LSkcs8FfW5plfU-VwwdxhOlWxdXdi1jtmpYhDPQzrjzGFEpZDGO2xlhTM
Message-ID: <CAJZ5v0gM4njmYU0KmObQnxXLcWmX9YctN=ZD9QDy_dnQz37S+g@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: sysfs: remove space before tab in macro
To: Mayur Kumar <kmayur809@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:53=E2=80=AFPM Mayur Kumar <kmayur809@gmail.com> w=
rote:
>
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 5eecae13f07..15f269358e0 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -82,7 +82,7 @@ mode_store(struct device *dev, struct device_attribute =
*attr,
>  }
>
>  #define thermal_trip_of_attr(_ptr_, _attr_)                            \
> -       ({                                                              \
> +       ({\

Broken, but I fixed it up.

>                 struct thermal_trip_desc *td;                           \
>                                                                         \
>                 td =3D container_of(_ptr_, struct thermal_trip_desc,     =
 \
> --

Applied as 7.2 material, thanks!

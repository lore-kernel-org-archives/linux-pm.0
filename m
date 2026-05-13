Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D82315D53
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684827; cv=none; b=qYWZrRu1pKFBS8RFRPn6x4199MoE2sJjM0cKE8LPpT6LiwHxWoNipLRA7Kz5hyBOysdF065NWrbp1B5gFbpCc6DgFwyA/7VJFrmHnmNkXdJShlX+mF9QdFnF5JDx94JigAHq5AGT20MTrQYJ7sKzHWDqf3732wYQIQcA1wVVXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684827; c=relaxed/simple;
	bh=+klZevnj7mVBnynzdY3C16pVIbJBKtFIfXA4RKS+Lsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXZ9gzSMoU6IXaD5DmLQKyvP6xZv8deSKoZbef+4GY7WxJh6a3vwOiA50S75lggX0fnTRxEXXuitJKy4CCyxpONwqaRoREDDukoIbK6iTAjXHNSshk52CItIeg+8cTKB1lnKKNq4HMD4ev8uecwmGL2apYc95pRKuzg92+cHpy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoDd4iNq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoDd4iNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28099C19425
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778684827;
	bh=+klZevnj7mVBnynzdY3C16pVIbJBKtFIfXA4RKS+Lsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KoDd4iNqNIKH2onymxVyFEmI7XgipOrIQ1kwk2sfSKS4A9CLHR3hH0TrnSF4hFtY2
	 bVmOPuw8DtRcDL4bXc7VBM8h8W3JNHbIxLPhtP7CUUQYbEKS3eKcv1UzOdFQTjGHdd
	 MIrSZCXBcEBUsK1/RvSxc7X3TNjeiBgbLuiELRsBxpA+yXuUlgwoZcShHr3FOC6Ko9
	 gtsll64Zq1sFC4Be2iJ1D6SNtlXt43E4vgGhO4+tbdLcmoyVBgl+BDdXyNPXUIZju+
	 Yp6Xgeh6nzw6K/faZSzaK0jUlc0PKnYcPEiCfI/VagzhfgzuHU3OoSWDcRmwzuNY4v
	 Gwi/9qiy3VLww==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39380e79936so82305811fa.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 08:07:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/TjrcIrCTVARZYr1IMBcHzDarPre/nZoNOEi150x5H04bWROixzHZUvaCuKByqOti3VzJM4Z30iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAA/XU7AK8IbWrxHIi0QJMDSd5GnifqKINUr0WIj+HeZuJTJ44
	Zk4DGUyHY5pWYmx5Tk19jle9cOON+22FDmBY3Vd2cz3U42nkCoTHwYXFHP7Lt0PtGB4LpkyWfmE
	7ymdznVCHrURYWxC1XWt324vDk1UHfnQ=
X-Received: by 2002:a05:6512:6c6:b0:5a8:e367:5009 with SMTP id
 2adb3069b0e04-5a8ef92ccdcmr1405401e87.3.1778684825544; Wed, 13 May 2026
 08:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <ce06dddf-3f47-4492-ab30-d3fde92e3b2a@oss.qualcomm.com> <48c1ae15-3fa7-439a-a492-c82b39fb0a89@oss.qualcomm.com>
In-Reply-To: <48c1ae15-3fa7-439a-a492-c82b39fb0a89@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 May 2026 17:06:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxWiPX2iGFZjsF8eiNuiXEXm_b0N9RH=Z1M+JsV268jQ@mail.gmail.com>
X-Gm-Features: AVHnY4J9EUhGq1RKUxbLI1jreuCIzLZg5BAaDyfbe2hWhuLa10OIRdLYgOI6BU0
Message-ID: <CAJZ5v0hxWiPX2iGFZjsF8eiNuiXEXm_b0N9RH=Z1M+JsV268jQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] thermal/core: Decouple release paths for tz and cdev
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, rui.zhang@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 4:22=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
> On 5/8/26 20:10, Daniel Lezcano wrote:
> > On 5/8/26 20:05, Daniel Lezcano wrote:
> >> This series cleans up the lifetime handling of thermal devices.
> >>
> >> Currently, the thermal class release callback handles both thermal
> >> zones and cooling devices by checking the device name prefix. This
> >> approach is fragile and mixes responsibilities across different object
> >> types.
> >>
> >> The first two patches introduce dedicated struct device release
> >> callbacks for thermal zones and cooling devices. This removes the need
> >> to rely on device names and keeps the lifetime management local to
> >> each object.
> >>
> >> The last two patches convert the thermal class to a dynamically
> >> allocated object and simplify the initialization logic by using the
> >> class pointer itself as a guard instead of a separate boolean flag.
> >>
> >> Overall, this results in a clearer separation of responsibilities and
> >> more robust lifetime management aligned with the device model.
> >>
> >> No functional change intended.
> > Unless I=E2=80=99m mistaken, the patch sent to split the cooling device
> > registration is correct with this cleanup.
>
> Were you able to apply the patch splitting the cooling device
> registration on top of this series ?

I haven't tried that yet, but I'll do it later today.

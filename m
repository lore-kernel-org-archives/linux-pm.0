Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAA3C7E19
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927203; cv=none; b=DQGt+kZ+/0byPu3npg2EoLvO7NhOqkRoXMVVuTGuwLz3x+dh+3HLhlQH2DvVowBPeQDMw4n4QcJuMjbj53niE9Plxp/93E7tyR2HGaaxnAKxS2CuktQbs0p74Dn81nhdf1dUO8ooRW1LbpjIuiKEg+omiJydty152XW+xglnCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927203; c=relaxed/simple;
	bh=BVfHSnFBAA+/8iP0H2IACZA45HpFyzJ490buB4SNYK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqKfAi6AjXjdpDH/23GKw+a+6yc/FilgtUI8pqFDBZWUo46XeVDlA7f2385ZNjb/3CgqBLa/9rLY0X0ZPnStDA//vihx1VypaiuqLDpliga8YtbQqXZowB3vO6OshAAua9I09gLKAoLTEkkoP3F2YYVMQaYETj+/NZzWkmdJ9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku17LTZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku17LTZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9695D1F00893
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780927202;
	bh=gwF5ic/UehcmJsD86n6pJQcL+pglhvQPtmiZHlvOMT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ku17LTZ/mAelCeRqFypP6F/cP2WrskvQ++ZsOtnXj2VgwN4fPxl6xm8NecEv3psr4
	 QS6mIva/GK96Ui4XfOLGV0tx6ztDSiVZFzR3tuzxgcX7uldnes4KBfQC0nu4on3BRN
	 eZ/EVxpbtZi2jrV9EdoVVPnXeBkptyuxDGO0xOoq83+EjbDYj2BCctLJJkZ+E0XMS4
	 EXyurbx5iiZgk1wkmxkxeciT7zeYW9hhOKSkkPIPBTlkCW7CbIBbUSOpL3ZcWf0ld6
	 OvrQxzNm9mSt9kGs/eCAhgO2J9Xh2rwJbZbQXXi6dsAexy/K5WokMywKBLg2FOEJpI
	 P8BtD1FRfs+pA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39677aed4d3so38598581fa.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 07:00:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/nn7+faO6w9e/riP2qURKo7u8X3OZRk0eI6UQ8e6iHC3H+lsuzHbx/FyihHnQYTq7z3zRrUoetYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjcADTW+wGBanqM2U1RfZIobyFjUyr07TFBuuAY6fZ9ONCI2m
	e0yaaLLz/9AdhwGfQ4RUPOV6fARKhJVf7R5MnJf7/PGfpgEW3r8dvaHOkYDdjK+0CDeNBrx6ifa
	910oGQPHT9dtuZ2WUcHjf/5WNtTuGERA=
X-Received: by 2002:a05:6512:6893:b0:5aa:6523:22b5 with SMTP id
 2adb3069b0e04-5aa87b7d579mr2866312e87.16.1780927200058; Mon, 08 Jun 2026
 07:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com> <20260606210420.2311145-2-ovidiu.panait.oss@gmail.com>
In-Reply-To: <20260606210420.2311145-2-ovidiu.panait.oss@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:59:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0js4Gt-kvDpnEaUykWvftuO+Q+0+wRMZ61JRuBytp3ZTA@mail.gmail.com>
X-Gm-Features: AVVi8CfSqAoQ-nIeghJ79P1EjZNebnX9NyGculfUi7f03UYegXCBAcWLlISKeT4
Message-ID: <CAJZ5v0js4Gt-kvDpnEaUykWvftuO+Q+0+wRMZ61JRuBytp3ZTA@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: testing: Replace sscanf() with kstrtoint()
To: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 11:05=E2=80=AFPM Ovidiu Panait
<ovidiu.panait.oss@gmail.com> wrote:
>
> Fix the following checkpatch.pl warnings:
> WARNING: Prefer kstrto<type> to single variable sscanf
> 242: FILE: drivers/thermal/testing/zone.c:242:
> +       ret =3D sscanf(arg, "%d", &id);
>
> WARNING: Prefer kstrto<type> to single variable sscanf
> 282: FILE: drivers/thermal/testing/zone.c:282:
> +       ret =3D sscanf(arg, "%d", &id);
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
> ---
>  drivers/thermal/testing/zone.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zon=
e.c
> index 3c339242f52d..f7f9ca2f1f2c 100644
> --- a/drivers/thermal/testing/zone.c
> +++ b/drivers/thermal/testing/zone.c
> @@ -239,9 +239,9 @@ int tt_del_tz(const char *arg)
>         int ret;
>         int id;
>
> -       ret =3D sscanf(arg, "%d", &id);
> -       if (ret !=3D 1)
> -               return -EINVAL;
> +       ret =3D kstrtoint(arg, 10, &id);
> +       if (ret < 0)
> +               return ret;
>
>         struct tt_work *tt_work __free(kfree) =3D kzalloc_obj(*tt_work);
>         if (!tt_work)
> @@ -279,9 +279,9 @@ static struct tt_thermal_zone *tt_get_tt_zone(const c=
har *arg)
>         struct tt_thermal_zone *tt_zone;
>         int ret, id;
>
> -       ret =3D sscanf(arg, "%d", &id);
> -       if (ret !=3D 1)
> -               return ERR_PTR(-EINVAL);
> +       ret =3D kstrtoint(arg, 10, &id);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
>
>         guard(mutex)(&tt_thermal_zones_lock);
>
> --

Applied as 7.2 material along with the [2/3].

However, please note that checkpatch.pl warnings regarding the
existing code are irrelevant, so I've rewritten the changelog of this
patch to indicate the preference to use kstrtoint() rather than refer
to the warnings.

Thanks!
